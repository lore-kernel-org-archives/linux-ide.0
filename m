From: venkat <venkat.s@vortexindia.co.in>
Subject: AHCI patching guidance for ICH7-M chipset
Date: Tue, 03 Dec 2013 21:07:10 +0530
Message-ID: <529DFAA6.4040105@vortexindia.co.in>
References: <529DF9F7.6000502@vortexindia.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp102.biz.mail.sg3.yahoo.com ([106.10.167.245]:24984 "HELO
	smtp102.biz.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752731Ab3LCPda (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Dec 2013 10:33:30 -0500
In-Reply-To: <529DF9F7.6000502@vortexindia.co.in>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


All

I am trying to make my chipset(ICH7 - M) to support AHCI in my debian 6 
(linux-source-2.6.32).

With mentioned link's ref 
:http://tartarus.org/~ds/quirk-ich-force-ahci.patch 
<http://tartarus.org/%7Eds/quirk-ich-force-ahci.patch> i cooked the 
quirk.c in my work machine and compiled the KERNEL
  make SUBDIRS=drivers/pci/ and  make module SUBDIRS=drivers/pci/

After successful compilation

i copied the "pci-stub.ko" from linux-source-2.6.32/drivers/pci to test  
machine's :"/lib/modules/2.6.32-5-686/kernel/drivers/pci" path
and then set quirks.ich_force_ahci=1 in /etc/grub/grub.conf

and rebooted the system

But after reboot my IDE is using ata_PIIX driver not AHCI driver.

Don't know what is error.request some guidance on applying the patch

-- 
Regards
Venkat.S



