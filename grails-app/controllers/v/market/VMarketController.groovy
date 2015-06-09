package v.market

import grails.plugin.springsecurity.annotation.Secured

@Secured('permitAll')
class VMarketController {

    def springSecurityService

    def index() {

        def cate = [[1:'saludyaseo',2:'Salud y Aseo'],[1:'licores',2:'Licores'],[1:'refrigerados',2:'Refrigerados'],[1:'frutasyverduras',2:'Frutas y Verduras'],[1:'alimentosvarios',2:'Alimentos Varios']]
        def cat = new String("'#saludyaseo','#licores','#refrigerados','#frutasyverduras','#alimentosvarios'").encodeAsRaw();
        //def cat = new String("'#refrigerados','#carnes','#fritos'").encodeAsRaw();
        //def cate = ['Refrigerados','Carnes','Fritos'];
        //def divs = ['#Refrigerados','#Carnes','#Fritos'];
        //def cate = ['Salud y Aseo','Licores','Refrigerados','Frutas y Verduras', 'Alimentos varios']
        def divs = ['#saludyaseo','#licores','#refrigerados','#frutasyverduras','#alimentosvarios']
        //[categories: cat,cate:cate];

        if (springSecurityService.isLoggedIn()){
            def user = User.get(springSecurityService.principal.id)
            respond user, model: [user:user, categories: cat , cate:cate]
        }
        else{
            [categories: cat, cate:cate]
        }
    }
}
