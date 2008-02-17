From: Joris <joris@v5.be>
Subject: ICH7: ata_piix twice as fast as ahci?
Date: Sun, 17 Feb 2008 16:41:42 +0100
Message-ID: <6b9952490802170741h1de9be53nefccea3775f7de00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:55255 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbYBQPln (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Feb 2008 10:41:43 -0500
Received: by an-out-0708.google.com with SMTP id d31so305895and.103
        for <linux-ide@vger.kernel.org>; Sun, 17 Feb 2008 07:41:43 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>

Hello List,

Odd problem on my machines: the sata disks appear to be a lot slower
when used via ata_piix vs the ahci driver.

* dd if=/dev/sda of=/dev/null runs at roughly 50MB/s under ahci a
steady 100MB/s under ata_piix, same for hdparm
* bonnie++ -d /home/bonnietest -s 16G -r 8192 -u root returns:
** ahci 64bit,16G,70460,99,92676,15,45442,6,66155,94,103556,7,515.9,0,16,4300,16,+++++,+++,2698,9,4735,18,+++++,+++,2611,9
** ata_piix 32bit,16G,50939,99,88159,16,41311,11,38945,69,108351,16,352.9,0,16,5045,5,+++++,+++,3882,4,5099,5,+++++,+++,3489,3

Is this a known issue? Is there a way to diagnose and/or fix this?
I'd love to combine a high-speed system with hotpluggable disks.


Kind regards,
Joris

Extra info:


I tried the following without result:
* The 'raid' functionality was disabled in the bios.
* Update kernels (the debian stable 2.6.18-6-amd64 and 2.6.22-3-amd64
from backports.org)
* Reinstall OS in 32 bit mode
* Limit the amount of ram on the machine to 2GB using the mem=2048M
kernel parameter.


HW info:
Xeon 3210, Supermicro PDSMi+ motherboard, Seagate ES2 500GB sata disks, 8GB ram
Sata controller: 00:1f.2 SATA controller: Intel Corporation 82801GR/GH
(ICH7 Family) Serial ATA Storage Controller AHCI (rev 01)

OS: A bare Debian 4.0 with all security updates, running nothing but
some idle daemons and ssh.
