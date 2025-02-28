using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Data.SqlClient;

namespace QLPhongTroTests
{
    [TestClass]
    public class UnitTest1
    {
        private string connectionString = @"Server=np:\\.\pipe\LOCALDB#97AD2A0C\tsql\query;Database=QLPhongTro;Integrated Security=True;";

        [TestMethod]
        public void TestDatabaseConnection()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                Assert.AreEqual(System.Data.ConnectionState.Open, conn.State, "Không thể kết nối đến database!");
            }
        }

        [TestMethod]
        public void TestSelectRooms()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT COUNT(*) FROM Rooms;";
                SqlCommand cmd = new SqlCommand(query, conn);
                int count = (int)cmd.ExecuteScalar();
                Assert.IsTrue(count >= 0, "Bảng Rooms không có dữ liệu hoặc lỗi truy vấn!");
            }
        }
        [TestMethod]
        // add room 
        public void TestInsertRoom()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "INSERT INTO Rooms (RoomName, RentPrice, Status) VALUES ('Phòng 101', 2000000, 'Available')";
                SqlCommand cmd = new SqlCommand(query, conn);
                int rowsAffected = cmd.ExecuteNonQuery();
                Assert.IsTrue(rowsAffected > 0, "Thêm phòng thành công");
            }
        }
        [TestMethod]
        // update RentPrice
        public void TestUpdateRoom()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "UPDATE Rooms SET RentPrice = 2500000 WHERE RoomName = 'Phòng 101'";
                SqlCommand cmd = new SqlCommand(query, conn);
                int rowsAffected = cmd.ExecuteNonQuery();
                Assert.IsTrue(rowsAffected > 0, "Cập nhật giá phòng thành công");
            }
        }
        [TestMethod]
        // delete room
        public void TestDeleteRoom()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "DELETE FROM Rooms WHERE RoomName = 'Phòng 101'";
                SqlCommand cmd = new SqlCommand(query, conn);
                int rowsAffected = cmd.ExecuteNonQuery();
                Assert.IsTrue(rowsAffected > 0, "Xóa phòng thành công");
            }
        }



    }
}
