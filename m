From: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
Subject: FUA and DPO unsupported using sata_nv on MCP55?
Date: Thu, 05 Apr 2007 14:13:31 +0100
Message-ID: <1175778811.5181.9.camel@ukabzc383.uk.saic.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpmx.mail.saic.com ([139.121.17.160]:49220 "EHLO
	cpmx.mail.saic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992692AbXDEN3I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Apr 2007 09:29:08 -0400
Received: from 0599-its-ieg02.mail.saic.com ([139.121.18.36] [139.121.18.36]) by cpmx.mail.saic.com for linux-ide@vger.kernel.org; Thu, 5 Apr 2007 06:13:53 -0700
Received: from cpmx.mail.saic.com ([139.121.18.36])
 by 0599-its-ieg02.mail.saic.com (SMSSMTP 4.0.5.66) with SMTP id M2007040506135318539
 for <linux-ide@vger.kernel.org>; Thu, 05 Apr 2007 06:13:53 -0700
Received: from ukabzc383.uk.saic.com ([10.89.2.37] [10.89.2.37]) by cpmx.mail.saic.com with ESMTP for linux-ide@vger.kernel.org; Thu, 5 Apr 2007 06:13:53 -0700
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by ukabzc383.uk.saic.com (Postfix) with ESMTP id 63A312AFE6
	for <linux-ide@vger.kernel.org>; Thu,  5 Apr 2007 14:13:31 +0100 (BST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I've got a couple of Samsung HD501LJ drives attached to a KN9 Ultra
board using the MCp55 chipset, and I'm getting an NCQ depth of 0
reported at boot, which as I understand it is because support for NCQ
isn't in the sata_nv driver yet for this chipset.

ata1.00: ATA-7, max UDMA7, 976773168 sectors: LBA48 NCQ (depth 0/32)
ata2.00: ATA-7, max UDMA7, 976773168 sectors: LBA48 NCQ (depth 0/32)

Later in the boot, however, I get 
SCSI device sda: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
SCSI device sda: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA

which as I understand it means my data ( plus the wifes picture
archive! ) is at risk, as I have write cache enabled and barrier support
is disabled because of the lack of FUA. Is this caused by my drives, or
is there something I need to enable?

Any hints gratefully received,
Eamonn

-- 
Eamonn Hamilton <eamonn.hamilton@saic.com>


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

