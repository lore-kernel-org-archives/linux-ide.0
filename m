From: Kantor Zsolt <kantorzsolt@yahoo.com>
Subject: can't read sectors with SG_IO
Date: Mon, 8 Oct 2007 23:42:52 -0700 (PDT)
Message-ID: <297662.13489.qm@web35404.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web35404.mail.mud.yahoo.com ([66.163.179.113]:33413 "HELO
	web35404.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752795AbXJIGnk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Oct 2007 02:43:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,I want to read for instance 1 sector from my ATA hard
disk with the SG_IO ioctl.I havecreated,set the fields for
the SG_IO ioctl,it returns 0 but no data in the buffer.I
even used the hdparm 7.7 sg16 function to read sectors from
the ATA device but no data came back.After the ioctl is
executed the sense buffer,status,device_status contains
data so there is a problem but I don't know what kind.For
instance the identify command works,so I can not read,and
probably write sectors.It is not possible to read sectors 
with SG_IO ? and how ?

Thanks
  Kantor


      ____________________________________________________________________________________
Check out the hottest 2008 models today at Yahoo! Autos.
http://autos.yahoo.com/new_cars.html
