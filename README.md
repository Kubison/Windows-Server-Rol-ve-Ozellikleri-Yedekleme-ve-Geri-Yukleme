# Windows Server Rol ve Ozellikleri Yedekleme ve Geri Yukleme
Kurulumu yapılırken dökumantasyonu yapılmamış ve üzerinde canlı uygulamanın çalıştığı bir Windows sunucumuz olsun ve bu uygulamaya gelen istekleri Load Balancing yapılabilmek adına yeni bir sunucu kurulumu yapılması istensin. Uygulamanın sıkıntısız çalışabilmesi, load balancing yapısına hızlı geçilebilmesi için yeni sunucuya Windows Server rol ve özelliklerinin eksiksiz ve düzgün şekilde kurulması gerekmektedir. Powershell vasıtası ile rol ve özelliklerin listesi kolayca dışarı aktarabilir ve dışarı aktarılan dosya ile başka sunuculara kurulum yapılabilir.

Öncelikle canlı uygulamamızın çalıştığı sunucuya Rdp yapıp Powershell açalım(Uzak ps bağlantısı da yapabilirsiniz.). 

Ardından yüklü olan windows özelliklerini ekrana özellik ve yüklenme durumu adında iki kolon olarak bastıran Powershell betiğini yapıştıralım.
```powershell
Get-WindowsFeature | where{$_.InstallState -eq "Installed"} | select Name,Installstate
```

![resim](https://user-images.githubusercontent.com/49712212/126983781-a96ee3a5-a596-4f94-adaa-119a1495ddef.png)

Yüklü olan özellikler bir liste haline powershell ekranında gözükecektir. Buradan özellikleri inceleyebilir, tek tek elle yükleme yapabilirsiniz. Lakin sayının yüksek olduğu durumlarda tek tek uğraşmak verimsiz olacaktır. Onun yerine tüm bu paketleri csv'ye export edebiliriz.

```powershell
Get-WindowsFeature | where{$_.InstallState -eq "Installed"} | select Name | Export-Csv C:\temp\features.csv
```
Bu komut ekrana bir çıktı basmayacak aksine sonda belirttiğiniz dosya yoluna her satırda bir özellik ismi olacak şekilde bir csv dosyası oluşturacak.

![resim](https://user-images.githubusercontent.com/49712212/126987678-9a5355fd-6ee8-4c59-9546-2e3e1e268dc1.png)

Bu dosyayı özellikleri ekleyeceğiniz sunucuya kopyalayın. Powershell açıp dosyayı kopyaladığınız dosya yoluna göre modifiye edip şu komutu yapıştırın.

```powershell
Import-Csv C:\Users\Administrator\Desktop\features.csv | foreach{ Install-WindowsFeature $_.name}
```
Bu komutun çalıştırılmasının ardından Powershell özellikleri yüklemeye başlayacak sonrasında yüklediği veya yükleyemediği paketler, restart gerektirip gerektirmediğine dair sizi bilgilendiren bir sonuç bastıracak. İşlem tamamdır.

![resim](https://user-images.githubusercontent.com/49712212/126988494-e9b18b4c-5dee-47f6-ba93-7a561b34379d.png)
![resim](https://user-images.githubusercontent.com/49712212/126988731-c5f56168-2dda-441a-ad2d-c65ce2e42c5c.png)

