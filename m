From: Krzysztof =?utf-8?q?B=C5=82aszkowski?= <kb@sysmikro.com.pl>
Subject: ATA_16 support on mptsas
Date: Mon, 23 Jun 2008 18:00:08 +0200
Message-ID: <200806231800.08659.kb@sysmikro.com.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from v007470.home.net.pl ([212.85.125.104]:57908 "HELO
	v007470.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754699AbYFWQIk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jun 2008 12:08:40 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, DL-MPTFusionLinux@lsi.com

Hello,

I found that any HDIO_DRIVE_CMD ioctl on sata drive connected through mpsas 
and backplane will fail. Basically the scsi_host_template structure is 
missing ioctl callback. after adding it and temporary tweaking domain_device 
structure associated to scsi_device (rphy only) i reached a point where 
ata_scsi_ioctl returns EIO and this why i need some clue on a way of adding 
such support similar way to aic94 where it has been done.

I found also that mptsas leaves domain_device rather uninitialized. the 
example is rphy but there more fields i don't know if they are revelant to 
proper processing of HDIO_DRIVE_CMD.
i need additional references on libata design, call flow and structures 
relationship.

probably it would be the best to design mptsas from scratch using libsas but 
this seems to me as huge work although if i was guided i would probably 
complete this.


I tried another approach where i used SG_IO ioctl and prepared ATA_16 cdb 
(just like libata does) but this failed on mptsas connected drives too 
altough this way works on drives connected to ICH6.

Regards,
Krzysztof Blaszkowski

