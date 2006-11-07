From: Martin Devera <devik@cdi.cz>
Subject: sata_via broken in 2.6.19rc4
Date: Tue, 07 Nov 2006 23:36:08 +0100
Message-ID: <45510A58.1040300@cdi.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.cdi.cz ([80.95.109.117]:24986 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id S1753465AbWKGWgN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Nov 2006 17:36:13 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi,

it seems there is typo in sata_via.c (see ATA_PFLAG_LOADING constant usage):

static int vt6420_prereset(struct ata_port *ap)
{
         struct ata_eh_context *ehc = &ap->eh_context;
         unsigned long timeout = jiffies + (HZ * 5);
         u32 sstatus, scontrol;
         int online;

         /* don't do any SCR stuff if we're not loading */
         if (!ATA_PFLAG_LOADING)
                 goto skip_scr;

also, It doesn't work on my 6420 hw. When I unplugged (and replugged) drive it
cycles forever like below. Any idea what is wrong ?

Nov  7 19:07:10 www1 kernel: [ 4774.536000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x
2 frozen
Nov  7 19:07:10 www1 kernel: [ 4774.536000] ata1.00: (BMDMA stat 0x1)
Nov  7 19:07:10 www1 kernel: [ 4774.536000] ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 
0x0 (tim
eout)
Nov  7 19:07:16 www1 kernel: [ 4779.636000] ata1: SATA link down 1.5 Gbps (SStatus 1 
SControl 300)
Nov  7 19:07:16 www1 kernel: [ 4779.636000] ATA: abnormal status 0xD0 on port 0xC007
Nov  7 19:07:16 www1 kernel: [ 4779.640000] ata1: EH complete
Nov  7 19:07:16 www1 kernel: [ 4779.640000] ATA: abnormal status 0xD0 on port 0xC007
Nov  7 19:07:16 www1 last message repeated 2 times
Nov  7 19:07:46 www1 kernel: [ 4809.640000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x
2 frozen
Nov  7 19:07:46 www1 kernel: [ 4809.640000] ata1.00: (BMDMA stat 0x1)
Nov  7 19:07:46 www1 kernel: [ 4809.640000] ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 
0x0 (tim
eout)
Nov  7 19:07:51 www1 kernel: [ 4814.740000] ata1: SATA link down 1.5 Gbps (SStatus 1 
SControl 300)
Nov  7 19:14:52 www1 kernel: [ 4814.740000] ATA: abnormal status 0xD0 on port 0xC007
Nov  7 19:14:52 www1 kernel: [ 4814.744000] ata1: EH complete
Nov  7 19:14:52 www1 kernel: [ 4814.744000] ATA: abnormal status 0xD0 on port 0xC007
Nov  7 19:14:52 www1 last message repeated 2 times
Nov  7 19:14:52 www1 kernel: [ 4844.744000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x
2 frozen
Nov  7 19:14:52 www1 kernel: [ 4844.744000] ata1.00: (BMDMA stat 0x1)
Nov  7 19:14:52 www1 kernel: [ 4844.744000] ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 
0x0 (tim
eout)
Nov  7 19:14:52 www1 kernel: [ 4849.844000] ata1: SATA link down 1.5 Gbps (SStatus 1 
SControl 300)
Nov  7 19:14:52 www1 kernel: [ 4849.844000] ATA: abnormal status 0xD0 on port 0xC007
Nov  7 19:14:52 www1 kernel: [ 4849.848000] ata1: EH complete
Nov  7 19:14:52 www1 kernel: [ 4849.848000] ATA: abnormal status 0xD0 on port 0xC007
Nov  7 19:14:52 www1 last message repeated 2 times
Nov  7 19:14:52 www1 kernel: [ 4879.848000] ata1.00: limiting speed to UDMA/100
Nov  7 19:14:52 www1 kernel: [ 4879.848000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x
2 frozen
Nov  7 19:14:52 www1 kernel: [ 4879.848000] ata1.00: (BMDMA stat 0x1)
Nov  7 19:14:52 www1 kernel: [ 4879.848000] ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 
0x0 (tim
eout)
Nov  7 19:14:52 www1 kernel: [ 4884.948000] ata1: SATA link down 1.5 Gbps (SStatus 1 
SControl 300)
Nov  7 19:14:52 www1 kernel: [ 4884.948000] ATA: abnormal status 0xD0 on port 0xC007
Nov  7 19:14:52 www1 kernel: [ 4884.952000] ata1: EH complete
Nov  7 19:14:52 www1 kernel: [ 4884.952000] ATA: abnormal status 0xD0 on port 0xC007
Nov  7 19:14:52 www1 last message repeated 2 times
Nov  7 19:14:52 www1 kernel: [ 4914.952000] ata1.00: limiting speed to UDMA/66
Nov  7 19:14:52 www1 kernel: [ 4914.952000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x
2 frozen
Nov  7 19:14:52 www1 kernel: [ 4914.952000] ata1.00: (BMDMA stat 0x1)
Nov  7 19:14:52 www1 kernel: [ 4914.952000] ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 
0x0 (tim
eout)
Nov  7 19:14:52 www1 kernel: [ 4920.052000] ata1: SATA link down 1.5 Gbps (SStatus 1 
SControl 300)
Nov  7 19:14:52 www1 kernel: [ 4920.052000] ATA: abnormal status 0xD0 on port 0xC007
Nov  7 19:14:52 www1 kernel: [ 4920.056000] ata1: EH complete
Nov  7 19:14:52 www1 kernel: [ 4920.056000] ATA: abnormal status 0xD0 on port 0xC007
Nov  7 19:14:52 www1 last message repeated 2 times
Nov  7 19:14:52 www1 kernel: [ 4950.056000] ata1.00: limiting speed to UDMA/44
