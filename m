From: =?ISO-8859-1?Q?Dan_No=E9?= <dpn@isomerica.net>
Subject: libata error/reset
Date: Fri, 05 Sep 2008 14:47:13 -0400
Message-ID: <48C17EB1.2020206@isomerica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from colobus.isomerica.net ([216.93.242.10]:47803 "EHLO
	colobus.isomerica.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755296AbYIESw3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Sep 2008 14:52:29 -0400
Received: from [10.12.20.122] (unknown [12.189.151.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by colobus.isomerica.net (Postfix) with ESMTP id CE1F510440F7D
	for <linux-ide@vger.kernel.org>; Fri,  5 Sep 2008 14:47:13 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Just after midnight last night, during an rsync job which copies a lot=20
of data onto my backup disk (half of a Linux software RAID 1), I=20
received the following:

-- SNIP --
ata3.00: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xe frozen
ata3.00: irq_stat 0x00400000, PHY RDY changed
ata3: SError: { PHYRdyChg }
ata3.00: cmd 35/00:10:3f:00:34/00:00:22:00:00/e0 tag 0 dma 8192 out
          res 50/00:00:4e:01:18/00:00:22:00:00/e0 Emask 0x10 (ATA bus e=
rror)
ata3.00: status: { DRDY }
ata3: hard resetting link
ata3: link is slow to respond, please be patient (ready=3D0)
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: qc timeout (cmd 0xec)
ata3.00: failed to IDENTIFY (I/O error, err_mask=3D0x5)
ata3.00: revalidation failed (errno=3D-5)
ata3: failed to recover some devices, retrying in 5 secs
ata3: hard resetting link
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: configured for UDMA/100
ata3: EH complete
sd 2:0:0:0: [sdc] 625142448 512-byte hardware sectors (320073 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't=20
support DPO or FUA
-- SNIP --

The system seems to be working fine now, and there was not even a RAID=20
failure reported by the md system.  Is this something I should be=20
concerned about? Hardware issue, software bug?

Linux colobus 2.6.26.3 #1 SMP Thu Aug 21 10:15:38 EDT 2008 i686 Intel(R=
)=20
Pentium(R) 4 CPU 3.20GHz GenuineIntel GNU/Linux

00:1f.2 SATA controller: Intel Corporation 82801FR/FRW (ICH6R/ICH6RW)=20
SATA Controller (rev 03)

I am using the libata ahci driver.  There are four drives crammed into =
a=20
1U with hotplug trays, but AFAIK no one was poking around the system.

Thanks much,
Dan

--=20
Dan No=E9
Software Engineer
Lime Brokerage LLC
781-370-2518
