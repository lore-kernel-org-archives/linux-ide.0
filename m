From: Silken Tiger <st@iss.tu-darmstadt.de>
Subject: SATA and hotplug
Date: Thu, 28 Apr 2005 14:05:29 +0200
Message-ID: <200504281405.29926.st@iss.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailserver2.hrz.tu-darmstadt.de ([130.83.174.20]:24211 "EHLO
	mailserver2.hrz.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id S262088AbVD1MFg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Apr 2005 08:05:36 -0400
Received: from iss1.vlsi.informatik.tu-darmstadt.de (iss1.vlsi.informatik.tu-darmstadt.de [130.83.164.1])
	by mailserver2.hrz.tu-darmstadt.de (8.12.10/8.12.10) with ESMTP id j3SC5UL6027576
	for <linux-ide@vger.kernel.org>; Thu, 28 Apr 2005 14:05:30 +0200
Received: from localhost (localhost [127.0.0.1])
	by iss1.vlsi.informatik.tu-darmstadt.de (Postfix) with ESMTP id 63A0E8007
	for <linux-ide@vger.kernel.org>; Thu, 28 Apr 2005 14:05:30 +0200 (CEST)
Received: from iss1.vlsi.informatik.tu-darmstadt.de ([127.0.0.1])
	by localhost (iss1 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 28435-01 for <linux-ide@vger.kernel.org>;
	Thu, 28 Apr 2005 14:05:30 +0200 (CEST)
Received: from iss10.vlsi.informatik.tu-darmstadt.de (iss10.vlsi.informatik.tu-darmstadt.de [130.83.164.10])
	by iss1.vlsi.informatik.tu-darmstadt.de (Postfix) with ESMTP id 471DF8006
	for <linux-ide@vger.kernel.org>; Thu, 28 Apr 2005 14:05:30 +0200 (CEST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi

I have a via kt600 chipset with sata ports. As described on the sata page
http://linux.yyz.us/sata/sata-status.html. This driver supports hotplug. 
Unfortunatly the libsata doesn't. So my question is if there is a easy way 
around this. Sometimes hotplugging works, most times not with the following 
error message: 
kernel: ATA: abnormal status 0xD0 on port 0xA807 (on 2.6.11.7)
The kernel doesn't even reboot. Can this error be removed by issuing some 
commands with hdparm or scsitools or /sysfs tricks?
If this doesn't work, is it possible to find a solution with a cheap sil pci 
bus sata controller and by unloading loading the driver module?

Besides is there much missing for hotplug support in libsata?

Thanks
ST

PS: Please cc me, not subscribed.
