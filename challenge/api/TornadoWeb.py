import os

import tornado.ioloop
import tornado.web

PATH_FILES = "files/"


class Text(tornado.web.RequestHandler):
    def get(self, file_name):

        if os.path.isfile(PATH_FILES + file_name + ".txt"):
            file_object = open(PATH_FILES + file_name + ".txt", "r")

            self.write(file_object.read())

            file_object.close()
            self.set_status(200)
        else:
            self.set_status(404)
            self.finish("Error 404")

    def post(self, file_name):
        file_object = open("files/" + file_name + ".txt", "w")

        body = bytes.decode(self.request.body)

        if body == "":
            self.set_status(400)
            self.finish("Error 400")

        file_object.write(str(body))

        file_object.close()
        self.set_status(200)


application = tornado.web.Application([
    (r"/content/(\w+)", Text),
])

if __name__ == "__main__":
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()
