/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package edu.mx.uttt.bdapp.control;

import java.util.List;

/**
 *
 * @author DEIMO
 */
public interface iOperaciones {
    void agregar(Object obj);
    boolean eliminar(Object obj);
    boolean actualizar(Object obj);
    List<Object> conusltar ();          
}
