From: Nicola <ivololeribar@yahoo.it>
Subject: Re: SiS 180 pata
Date: Mon, 5 Jul 2004 23:05:29 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200407052305.29015.ivololeribar@yahoo.it>
References: <200407051253.47003.ivololeribar@yahoo.it> <200407051603.48708.ivololeribar@yahoo.it> <1089059471.2868.9.camel@uk3.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:20414 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262382AbUGEVFY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jul 2004 17:05:24 -0400
In-Reply-To: <1089059471.2868.9.camel@uk3.local>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Monday 05 July 2004 22:31, you wrote:
> Hello Nicola,
>
> please can you provide the output of lspci -vvxxx
>
Here we are:

00:0c.0 RAID bus controller: Silicon Integrated Systems [SiS]: Unknown device 
0180 (prog-if 85)
	Subsystem: Silicon Integrated Systems [SiS]: Unknown device 0180
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 128
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at d800
	Region 1: I/O ports at dc00 [size=4]
	Region 2: I/O ports at e000 [size=8]
	Region 3: I/O ports at e400 [size=4]
	Region 4: I/O ports at e800 [size=16]
	Region 5: I/O ports at <unassigned>
00: 39 10 80 01 07 00 20 02 00 85 04 01 00 80 00 00
10: 01 d8 00 00 01 dc 00 00 01 e0 00 00 01 e4 00 00
20: 01 e8 00 00 01 00 00 00 00 00 00 00 39 10 80 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 0c 01 00 00
40: 56 23 06 04 56 23 06 04 00 00 00 00 00 00 00 00
50: 82 20 82 00 2a 96 00 03 00 00 00 00 00 00 00 00
60: ff aa 00 00 d9 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: bd 33 72 40 bd 33 72 40 00 00 00 00 00 00 00 00
90: 34 00 00 03 01 00 00 00 cc 04 0c 10 c0 05 c0 05
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 01 00 18 00 00 03 00 00 00 00 00 00
d0: 00 00 00 00 01 00 18 00 00 03 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

