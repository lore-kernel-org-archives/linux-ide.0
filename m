From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] libata DMADIR support
Date: 17 May 2004 16:05:24 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084831524.3211.67.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com>
	<1084819720.4328.86.camel@patibmrh9>  <40A90D96.2040002@pobox.com><108482 8
	840.3211.26.camel@patibmrh9>  <40A92F69.6030309@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:54216 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S262438AbUEQWFk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 May 2004 18:05:40 -0400
In-Reply-To: <40A92F69.6030309@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> > my Si 3611CT80 r1.4 bridge ...
> 
> I am convinced that your hardware requires DMADIR.

Me too.

> I am not convinced that there is no way to detect this condition at 
> runtime, based on some hardware characteristic, or output.

I agree.

Shall we try timeout, reset, and retry of the initial DMA op x12
Inquiry?

If that fails for timeout with xD0 status, then we guess oh DMADIR and
try again with Features = x05 Dma In, rather than our default of x01 Dma
Out/classic?

> > My op xA1 "IDENTIFY" bytes appear nybble-for-nybble identical, no
> > matter if sampled via the SATA ATAPI of Si 3611CT80 r1.4 or if
> > sampled via the original PATA ATAPI.
> 
> Disappointing...

Yes.  We may have a phasing trouble here: the bridge appeared before the
final definition of the relevant op xA1 "IDENTIFY" "word"s.

> word 62

Ouch, ouch, ouch.

I just dug up the fact that mask x0707 of word 62 used to mean single
word DMA e.g. in page 54 of 111, ATA-2 of 1996-03-18, d0948r4c.pdf.

t13.org ATA/PI 7 redefining word 62 to mean DMADIR may become a
pernicious way of searching out anyone who still thinks SWDMA exists.

> <shrug>  Honestly, I think the requirement of a data-direction bit was 
> inevitable.  I'm surprised you don't have one for ATA devices. 
> Consider:  what data direction will a vendor-reserved SCSI opcode 
> require?  The OS driver cannot know.
> 
> If you accept that premise, then these changes to ATA were required...

I agree, vehemently.

Indeed, we have more trouble coming eventually.  If we compare the
serial USB CBW to what we see on a serial SATA emulation of a parallel
PATA cable, what's missing is:

bCBLength = length of the CDB
bmCBWFlags.Direction = Data In/Out
dCSWDataResidue = data bytes clocked but not copied

All the missing info causes trouble in one way or another.  Also both
USB and ATAPI die when we cross the 64-bit lba barrier that takes us
past 16 bytes/CDB.  Also both may break as aligning data only to 32-bit
boundaries rather than 64-bit boundaries starts to matter.

> > Consider:  what data direction will a vendor-reserved SCSI opcode 
> > require?  The OS driver cannot know.
> 
> s/OS driver/bridge/ obviously...

I think you're saying that knowing the SCSI opcode does not decide the
data copy direction.

I agree, vehemently.

By definition, knowing the opcode cannot decide the data copy direction
of vendor-specific and newly standard commands.

Also in theory, the data copy direction of SCSI opcodes may vary in
accord with PDT (= Peripheral Device Type = mask x1F of byte 0 of op x12
"INQUIRY" = x 0E/ 07/ 04/ 00 SBC of HDD/ Flash = x05 MMC of DVD/CD).

Also in practice, some (rudely designed) vendor-specific ops move data
both ways.

None of those facts have kept people over the years from writing host
software that thinks the op decides the direction.  I think I remember
seeing Linux-2.2 broken that way.

Pat LaVarre


