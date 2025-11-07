package model;

public class Attendance {
    private int id;
    private String studentId;
    private String date;
    private String subject;
    private String status;

    // Default constructor
    public Attendance() {}

    // Constructor with parameters
    public Attendance(String studentId, String date, String subject, String status) {
        this.studentId = studentId;
        this.date = date;
        this.subject = subject;
        this.status = status;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Attendance{" +
                "id=" + id +
                ", studentId='" + studentId + '\'' +
                ", date='" + date + '\'' +
                ", subject='" + subject + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
