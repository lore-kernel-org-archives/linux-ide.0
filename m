From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] libata DMADIR support
Date: 17 May 2004 15:20:40 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084828840.3211.26.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com>
	<1084819720.4328.86.camel@patibmrh9>  <40A90D96.2040002@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:22721 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S262026AbUEQVU4
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 May 2004 17:20:56 -0400
In-Reply-To: <40A90D96.2040002@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> "documents 2003" link on http://www.t13.org/ ...
> ATAPI DMA Direction issues Proposal 12/21/03 Hartney
> http://www.t13.org/docs2003/e03132r3.pdf

Links!  Thank you.

> > If bit 15 of word 62 is cleared to 0, DMADIR bit in the PACKET command
> > is not required. If bit 15 of word 62  is cleared to zero, then all bits
> > of word 62 shall be cleared to zero.
> 
> I bet your bridge doesn't _require_ DMADIR, therefore it doesn't bother 
> with word 62?  </wild guess>

Your courage in aggressively sharing wild guesses, I appreciate, thank
you, but in this instance:

My memory of my share of the SATA ATAPI UDMA flurry tells me that my Si
3611CT80 r1.4 bridge hangs with status = xD0 if we ask it to copy DMA
Data In, without having prepared op xA0 "PACKET" features = x05 DMA In
rather than x01 DMA Out.

Are you not convinced?

What further experiments should I run or repeat or reemphasise?

I agree, by connecting my compliant only-DMADIR-capable bridge to a
compliant PATA DMA device I have ended up violating ATA/PI 6 by claiming
classic UDMA in op xA1 "IDENTIFY" "word" 88 (line 12 offset 0), when in
fact the abomination I built only actually supports the DMADIR that
ATA/PI 7 claims will be described in "word" 62 (line 7 offset 6).

I see that as me falling into the pit that t13.org dug for me, while I
admittedly wasn't watching closely enough to notice.

I imagine I was not the first and I will not be the last to fall into
this spiked pit.  Particularly vulnerable will be the people who resell
compliant PATA ATAPI UDMA devices and then fall into erroneously
believing that adding a compliant SATA/PATA bridge makes a compliant
SATA ATAPI UDMA device.

Do you disagree?

Pat LaVarre

$ cat sata
85c0 0000 0000 0000 0000 0000 0000 0000
0000 0000 3139 3130 4343 3944 4345 3442
4646 4145 2020 2020 0000 0000 0000 3734
2e42 2020 2020 496f 6d65 6761 2020 5252
4420 2020 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 0000
0000 0f00 0000 0200 0000 0006 0000 0000
0000 0000 0000 0000 0000 0000 0000 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0040 0000 4218 4000 4000 4218 0000 4000
203f 0000 0000 0000 0000 404f 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 436f 7079 7269 6768 7420 2863 2920
3230 3034 2049 6f6d 6567 6120 436f 7270
2e20 2041 6c6c 2072 6967 6874 7320 7265
7365 7276 6564 2e00 3032 2f32 372f 3034
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
$


