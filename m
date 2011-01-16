From: Marc MERLIN <marc@merlins.org>
Subject: PMP SMART error recovery and failure code decoding help
Date: Sun, 16 Jan 2011 08:39:50 -0800
Message-ID: <20110116163950.GA691@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:60844 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992Ab1APRJk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Jan 2011 12:09:40 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

I have 2 sets of 5 drives being a PMP.

- 2.6.36.0 kernel
- sata_sil24 card
- Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9

All 10 are outputting errors on a schedule after being queried by some Smart tool
(I have hddtemp and smartmontools at least).

Error is:
ata10.02: failed command: SMART
ata10.02: cmd b0/d8:00:00:4f:c2/00:00:00:00:00/00 tag 0
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata10.02: status: { DRDY }

I think it's due to a script that I wrote that uses hdparm -y to spin
drives down after an idle period (because at least 5 of my drives, WDC
WD20EADS, have stupid green firmware that prevents auto spindowns with
hdparm -S).
My swdisksusp script is at:
http://marc.merlins.org/perso/linux/post_2010-08-03_Spinning-Down-WD20EADS-Drives-and-Fixing-Load-Cycle.html

Anyway, the problem happens with both drives that I manually spin down and
drives that spin down on their own. I think it's not actually a 'real',
error but more an issue where drives cannot answer some SMART error when
they are spun down.
That said, is it normal/expected for the PMP code to do a full bus reset
because of a SMART command that couldn't go through?

Thanks,
Marc

Jan 16 05:54:23 gargamel kernel: ata9.00: failed command: SMART
Jan 16 05:54:31 gargamel kernel: ata9.01: failed command: SMART
Jan 16 05:54:39 gargamel kernel: ata9.02: failed command: SMART
Jan 16 05:54:47 gargamel kernel: ata9.03: failed command: SMART
Jan 16 05:54:55 gargamel kernel: ata9.04: failed command: SMART
Jan 16 06:05:04 gargamel kernel: ata9.00: failed command: SMART
Jan 16 06:05:12 gargamel kernel: ata9.01: failed command: SMART
Jan 16 06:05:20 gargamel kernel: ata9.02: failed command: SMART
Jan 16 06:05:28 gargamel kernel: ata9.03: failed command: SMART
Jan 16 06:05:36 gargamel kernel: ata9.04: failed command: SMART
Jan 16 06:05:44 gargamel kernel: ata10.00: failed command: SMART
Jan 16 06:06:01 gargamel kernel: ata10.01: failed command: SMART
Jan 16 06:06:18 gargamel kernel: ata10.02: failed command: SMART
Jan 16 06:16:35 gargamel kernel: ata9.00: failed command: SMART
Jan 16 06:16:52 gargamel kernel: ata9.01: failed command: SMART
Jan 16 06:17:01 gargamel kernel: ata9.02: failed command: SMART
Jan 16 06:17:08 gargamel kernel: ata9.03: failed command: SMART
Jan 16 06:17:16 gargamel kernel: ata9.04: failed command: SMART
Jan 16 06:27:25 gargamel kernel: ata10.00: failed command: SMART
Jan 16 06:27:42 gargamel kernel: ata10.01: failed command: SMART
Jan 16 06:27:59 gargamel kernel: ata10.02: failed command: SMART
Jan 16 06:38:16 gargamel kernel: ata9.00: failed command: SMART
Jan 16 06:38:24 gargamel kernel: ata9.01: failed command: SMART
Jan 16 06:38:32 gargamel kernel: ata9.02: failed command: SMART
Jan 16 06:38:40 gargamel kernel: ata9.03: failed command: SMART
Jan 16 06:38:48 gargamel kernel: ata9.04: failed command: SMART
Jan 16 06:59:05 gargamel kernel: ata10.00: failed command: SMART
Jan 16 06:59:19 gargamel kernel: ata10.01: failed command: SMART
Jan 16 06:59:36 gargamel kernel: ata10.02: failed command: SMART
Jan 16 07:29:58 gargamel kernel: ata10.00: failed command: SMART
Jan 16 07:30:15 gargamel kernel: ata10.01: failed command: SMART
Jan 16 07:30:32 gargamel kernel: ata10.02: failed command: SMART
Jan 16 08:00:55 gargamel kernel: ata10.00: failed command: SMART
Jan 16 08:01:12 gargamel kernel: ata10.01: failed command: SMART
Jan 16 08:01:29 gargamel kernel: ata10.02: failed command: SMART

A full error looks like this:
ata10.00: failed to read SCR 1 (Emask=0x40)
ata10.01: failed to read SCR 1 (Emask=0x40)
ata10.02: failed to read SCR 1 (Emask=0x40)
ata10.03: failed to read SCR 1 (Emask=0x40)
ata10.04: failed to read SCR 1 (Emask=0x40)
ata10.05: failed to read SCR 1 (Emask=0x40)
ata10.15: exception Emask 0x4 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.02: failed command: SMART
ata10.02: cmd b0/d8:00:00:4f:c2/00:00:00:00:00/00 tag 0
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata10.02: status: { DRDY }
ata10.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.15: hard resetting link
ata10.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata10.05: limiting SATA link speed to 1.5 Gbps
ata10.00: hard resetting link
ata10.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata10.01: hard resetting link
ata10.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.02: hard resetting link
ata10.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.03: hard resetting link
ata10.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.04: hard resetting link
ata10.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.05: hard resetting link
ata10.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata10.00: configured for UDMA/100
ata10.01: configured for UDMA/100
ata10.02: qc timeout (cmd 0xec)
ata10.02: failed to IDENTIFY (I/O error, err_mask=0x5)
ata10.02: revalidation failed (errno=-5)
ata10.15: hard resetting link
ata10.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata10.00: hard resetting link
ata10.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata10.01: hard resetting link
ata10.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.02: hard resetting link
ata10.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.03: hard resetting link
ata10.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.04: hard resetting link
ata10.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.05: hard resetting link
ata10.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata10.00: configured for UDMA/100
ata10.01: configured for UDMA/100
ata10.02: configured for UDMA/100
ata10.03: configured for UDMA/100
ata10.04: configured for UDMA/100
ata10: EH complete


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems & security ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
