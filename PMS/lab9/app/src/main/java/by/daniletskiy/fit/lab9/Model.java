package by.daniletskiy.fit.lab9;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

import java.io.Serializable;
import java.util.Calendar;

@Entity(tableName = "Business_Cards")
public class Model implements Serializable {
    @PrimaryKey(autoGenerate = true)
    private int id;
    private String surname;
    private String name;
    private String patronymic;
    private String work_place;
    private String telephone;
    private String links;

    public Model(){
        this.surname = "";
        this.name = "";
        this.patronymic = "";
        this.work_place = "";
        this.telephone = "";
        this.links = "";
    }

    public void setSurname(String Surname){
        this.surname = Surname;
    }
    public void setName(String Name){
        this.name = Name;
    }
    public void setPatronymic(String Patronymic){
        this.patronymic = Patronymic;
    }
    public void setWork_place(String Work_Place){
        this.work_place = Work_Place;
    }
    public void setTelephone(String Telephone){
        this.telephone = Telephone;
    }
    public void setLinks(String Links){
        this.links = Links;
    }

    public int getId(){
        return this.id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getSurname(){
        return this.surname;
    }
    public String getName(){
        return  this.name;
    }
    public String getPatronymic(){
        return this.patronymic;
    }
    public String getWork_place(){
        return this.work_place;
    }
    public String getTelephone(){
        return this.telephone;
    }
    public String getLinks(){
        return this.links;
    }
}
