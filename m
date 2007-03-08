From: Richard Scobie <richard@sauce.co.nz>
Subject: sata_nv error with smartctl access
Date: Fri, 09 Mar 2007 09:59:28 +1300
Message-ID: <45F07930.6000102@sauce.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.sauce.co.nz ([210.48.49.72]:54858 "EHLO smtp.sauce.co.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933315AbXCHU6D (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Mar 2007 15:58:03 -0500
Received: from [192.168.4.111] (unknown [192.168.4.111])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp22.sauce.co.nz (Postfix) with ESMTP id 10A3428825B
	for <linux-ide@vger.kernel.org>; Fri,  9 Mar 2007 09:57:57 +1300 (NZDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

This may already be addressed, but in case anyone is interested.

Fedora Core 6 2.6.19-1.2911.6.5, NVIDIA MCP55 based board using sata_nv.

When querying a drive using smartctl and SMART is not enabled on the 
drive, I get the following error:

ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata3.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata3.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata3.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata3.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata3.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata3.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata3: EH complete
SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back

This does not seem to cause any problems and once SMART is enabled, 
there are no more errors.

Regards,

Richard
