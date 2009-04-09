From: Jeff Garzik <jeff@garzik.org>
Subject: 32-bit IO to-do item...
Date: Thu, 09 Apr 2009 01:25:40 -0400
Message-ID: <49DD86D4.3090304@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39157 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbZDIFZo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Apr 2009 01:25:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>

Alan,

I keep meaning to mention this (and get it into the mail archive)... 
The 32-bit IO patch was incomplete, because it rendered 
ATA_IOC_[GS]ET_IO32 handling in ata_sas_scsi_ioctl() -- our base ioctl 
handler -- incorrect.

Previously, it simply ensured the ioctls reflected hardcoded 16-bit I/O. 
  Now, behavior no longer matches what the ioctls report.

At a minimum, drivers probably need to set an "I'm using 32bit I/O" 
flag, that the ioctl then reads, replacing ata_sas_scsi_ioctl()'s 
assumption that val==0.

	Jeff


