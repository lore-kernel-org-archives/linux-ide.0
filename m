From: Matt Darcy <kernel-lists@projecthugo.co.uk>
Subject: Sata_mv 2.6.15 driver information request.
Date: Sun, 27 Nov 2005 20:08:50 +0000
Message-ID: <438A1252.1010507@projecthugo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host81-138-64-234.in-addr.btopenworld.com ([81.138.64.234]:20146
	"HELO alesi.projecthugo.co.uk") by vger.kernel.org with SMTP
	id S1751087AbVK0UJK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Nov 2005 15:09:10 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello Linux-ide list,

I'm trying to get some additional information on the sata_mv driver that 
has appeared in the 2.6.15 kernel

This has long been a personal pain to me, after being locked into the 
2.6.12 kernel with the propritary driver, and the ammount of hacked up 
boot scripts I have to include sata disks that hang of my controller in 
a raid 5 array.

I've decided to try to not use the 3rd party driver and try to get the 
driver in .15 working.

I was very pleased that my test upgrad worked well, and my meta devices 
where seen and configured straight away, and with straight boot scripts, 
no hacking needed.

I am however having some pretty serious stability issues with it 
(locking my whole system up in certain situations)

I note that comments mark it as extremly experimental - and I totally 
appriciate this, which is why I'd like to try offer up as much 
information as possible to get this driver to a more stable condition, 
as quickly as possible.

I notice that Brett Russ wrote the driver and its copyrighted by EMC 
(seems unusual for a sata driver). The notes in the drivers code say to 
copy this email list on any mails, and seeing as the driver doesn't 
provide any information on any one else to contact, it seemed like a 
good place to start.

What base information and pre-requists are there in reporting bugs and 
issues with a driver, and is this the best place to do it ?

Many thanks,

Matt Darcy
