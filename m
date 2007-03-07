From: Richard Scobie <richard@sauce.co.nz>
Subject: NVIDIA MCP55 NCQ
Date: Thu, 08 Mar 2007 10:56:30 +1300
Message-ID: <45EF350E.9040205@sauce.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.sauce.co.nz ([210.48.49.72]:35064 "EHLO smtp.sauce.co.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992452AbXCGWBv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Mar 2007 17:01:51 -0500
Received: from [192.168.4.111] (unknown [192.168.4.111])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp22.sauce.co.nz (Postfix) with ESMTP id AF20D28825B
	for <linux-ide@vger.kernel.org>; Thu,  8 Mar 2007 10:55:08 +1300 (NZDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Am running a Redhat FC6 machine with kernel 2.6.19-1.2911.6.5 and 
wondering if there is not yet support for the NCQ feature of sata_nv on 
boards using the NVIDIA MCP55 chipset.

ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 0/32)
ata4.00: ata4: dev 0 multi count 1
ata4.00: configured for UDMA/133
scsi 2:0:0:0: Direct-Access     ATA      WDC WD5000YS-01M 09.0 PQ: 0 ANSI: 5
SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00

The drive is NCQ capable and when I attempt to:

echo 31 > /sys/block/sdc/device/queue_depth

I get a "permission denied", (as root) and am reluctant to force the 
issue, as I understand it should all just work, (depth 31/3), if 
everything is OK.

Regards,

Richard
