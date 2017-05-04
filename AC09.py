from random import randint, choice, expovariate


class Persona:
    def set_id():
        contador = 0
        while True:
            yield contador
            contador += 1

    def __init__(self):
        self.id = Persona.set_id()
        self.velocidad = randint(5, 8)
        self.inicial = randint(0, 60)
        self.personalidad = Personalidad()
        self.esta_en_auto = False
        self.vivo = True


class Personalidad:

    def __init__(self, tipo):
        self.tipo = tipo

    def recibir(self):
        if self.tipo == "Generoso":
            return prob(6)
        else:
            return prob(3)


def prob(n, total=10):
    lista = [True if i < n else False for i in range(total)]
    return choice(lista)


class Terremoto:
    def __init__(self, tipo):
        if isinstance(tipo, str) and "debil" in tipo:
            self.tipo = False
        else:
            self.tipo = bool(tipo)

    def matar(self, algo):
        if isinstance(algo, Vehiculo):
            if self.tipo:
                p = prob(15, 100)
            else:
                p = prob(6)
            if p:
                for persona in algo.pasajeros:
                    persona.vivo = False
        else:
            if self.tipo:
                p = prob(1)
            else:
                p = prob(3)
            if p:
                algo.vivo = False

    def generar_tsunami(self):
        if self.tipo and prob(7):
            return Tsunami(randint(0, 100))


class Tsunami:
    def __init__(self, posicion):
        self.posicion = posicion
        self.potencia = randint(3, 8)


    def matar(self, algo):
        if (self.posicion - self.potencia * 2 <= algo.posicion) \
                and (self.posicion + self.potencia * 2 >= algo.posicion):
            if prob(self.potencia):
                if isinstance(algo, Persona):
                    algo.vivo = False
                else:
                    for persona in algo.pasajeros:
                        persona.vivo = False


class Vehiculo:

    def __init__(self, tipo, conductor=None):
        self.tipo = tipo
        self.velocidad = randint(12, 20)
        self.conductor = conductor
        self.pasajeros = []
        self.inicial = conductor.inicial
        conductor.esta_en_auto = True


    @property
    def disponible(self):
        if self.tipo == 0:  # 0: Camioneta
            return bool(8 - len(self.pasajeros))
        else:
            return bool(5 - len(self.pasajeros))

    @property  # CAMBIAR
    def posicion(self):
        return self.inicial + self.velocidad  # CAMBIAR

    def subir_personas(self, persona):
        if self.disponible and self.conductor.personalidad.recibir():
            self.pasajeros.append(persona)
            persona.esta_en_auto = True
            persona.velocidad = self.velocidad


class Simulacion:

    cosa_que_pasan = []

    def __init__(self):
        self.personas = [Persona() for i in range(100)]
        self.autos = [Vehiculo(randint(0, 1), self.personas[i]) for i in range(25)]

    def ocurre_terremoto(self):
        l = 1/randint(4, 10)
        p = expovariate(l)


