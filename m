From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: sata_mv hotplug status?
Date: Fri, 11 May 2007 13:29:44 +0200
Message-ID: <464453A8.9080307@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.syneticon.net ([213.239.212.131]:43997 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757813AbXEKLbO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 07:31:14 -0400
Received: from postfix1.syneticon.net (postfix1.syneticon.net [192.168.112.6])
	by mail2.syneticon.net (Postfix) with ESMTP id 219CC5CC8F
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 13:31:11 +0200 (CEST)
Received: from localhost (filter1.syneticon.net [192.168.113.3])
	by postfix1.syneticon.net (Postfix) with ESMTP id CFDA99481
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 13:31:10 +0200 (CEST)
Received: from postfix1.syneticon.net ([192.168.113.4])
	by localhost (mx03.syneticon.net [192.168.113.3]) (amavisd-new, port 10025)
	with ESMTP id qk-sCmgTHdR2 for <linux-ide@vger.kernel.org>;
	Fri, 11 May 2007 11:31:07 +0000 (UTC)
Received: from [192.168.10.145] (unknown [87.79.108.105])
	by postfix1.syneticon.net (Postfix) with ESMTP
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 13:31:07 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>

I'm a little confused about sata_mv hotplug status.

According to http://linux-ata.org/driver-status.html#marvell, the driver 
has "full SATA control including hotplug".

A bit down on that same page, the matrix 
http://linux-ata.org/driver-status.html#matrix says sata_mv - device 
hotplug: no.

Which one is true? I guess the first says about drive hotplug, and the 
second says about (PCI) device hotplug?


Today, I tried to add a drive to that Marvell SATA controller:

01:00.0 SCSI storage controller: Marvell Technology Group Ltd. 
MV88SX6081 8-port SATA II PCI-X Controller (rev 09)


But it wasn't detected at all (no dmesg/kernel sign that the drive was 
connected) - I had to reboot the machine to get that drive  detected.

This would indicate that sata_mv doesn't support any sort of drive 
*plug? Or do I have to take some extra steps to get the drives detected?

I'm running 2.6.21 kernel.


-- 
Tomasz Chmielewski
http://wpkg.org
