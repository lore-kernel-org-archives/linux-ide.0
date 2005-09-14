From: Stefan <gentoopower@yahoo.de>
Subject: USB-Storage, slow speed with sync option
Date: Wed, 14 Sep 2005 02:53:25 +0200
Message-ID: <43277485.6030802@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:58302 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932409AbVINAzN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Sep 2005 20:55:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi folks,

I'm not sure if this is the correct list for my problem. So bare with me.

When I copy files to my USB 2.0 Stick , my transferspeed are horrible in
case I mount the device with sync option, the rates are around 50KB/s,
doesn't really matter how big the files are.
If I don't mount with option sync, then the speeds are as expected a
couple of MB/s

I don't think this is the default behaviour, right?

Anybody got an idea what could be wrong?

Filesystem is vfat.
I tried with different kernels and a live cd(knoppix), currently I use
kernel 2.6.13.
Motherboard is an NFORCE 4 based one:

0000:00:02.0 USB Controller: nVidia Corporation CK804 USB Controller
(rev a2)
0000:00:02.1 USB Controller: nVidia Corporation CK804 USB Controller
(rev a3)

USB Info shows the device using ehci_hcd module

Thanks in advance, Stefan


	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de

