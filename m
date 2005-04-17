From: "Eric A. Cottrell" <eac@shore.net>
Subject: Re: [PATCH 2.6.12-rc2 1/2] libata: add missing read of error register
Date: Sat, 16 Apr 2005 21:54:55 -0400
Message-ID: <4261C1EF.9060708@shore.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.primushost.com ([209.58.220.66]:14295 "EHLO
	smtp2.primushost.com") by vger.kernel.org with ESMTP
	id S261239AbVDQBzD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Apr 2005 21:55:03 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Hello Jeff,

Problem:
The feature member is not being set from the error register when the taskfile is read.  This causes a problem when the task file is 
read to determine errors.

Solution:
In libata-core.c add code to set the feature member in the taskfile structure.


Signed-off-by: Eric A. Cottrell  eac@shore.net



--- a/drivers/scsi/libata-core.c	2005-04-09 19:34:19.000000000 -0400
+++ b/drivers/scsi/libata-core.c	2005-04-16 18:10:39.000000000 -0400
@@ -261,6 +261,7 @@
  {
  	struct ata_ioports *ioaddr = &ap->ioaddr;

+	tf->feature = inb(ioaddr->error_addr);
  	tf->nsect = inb(ioaddr->nsect_addr);
  	tf->lbal = inb(ioaddr->lbal_addr);
  	tf->lbam = inb(ioaddr->lbam_addr);
@@ -293,6 +294,7 @@
  {
  	struct ata_ioports *ioaddr = &ap->ioaddr;

+	tf->feature = readb((void __iomem *)ioaddr->error_addr);
  	tf->nsect = readb((void __iomem *)ioaddr->nsect_addr);
  	tf->lbal = readb((void __iomem *)ioaddr->lbal_addr);
  	tf->lbam = readb((void __iomem *)ioaddr->lbam_addr);
