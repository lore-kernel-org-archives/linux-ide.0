From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with
 SSD
Date: Fri, 23 Oct 2009 21:27:38 +0400
Message-ID: <4AE1E78A.2090801@ru.mvista.com>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com>	<200910221144.04471.bzolnier@gmail.com>	<Pine.LNX.4.64.0910231024240.324@hs20-bc2-1.build.redhat.com>	<200910231644.29919.bzolnier@gmail.com>	<Pine.LNX.4.64.0910231050330.3007@hs20-bc2-1.build.redhat.com> <20091023175157.3a898525@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:64743 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751448AbZJWRx5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2009 13:53:57 -0400
In-Reply-To: <20091023175157.3a898525@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, elendil@planet.nl

Hello.

Alan Cox wrote:

>>So, why was it serialized before? I assume that either someone noticed the 
>>corruption or someone read some datasheet noting the corruption or someone 
>>reverse engineered some other driver and saw the serialization.

> The data sheet has some things to say for the 643 abd 646

> In PIO mode it says you must check

> CFR bit 2   (indicates primary interrupt)
> ARTIM23 bit 4  (secondary interrupt)

> Both bits can be written 1 to clear the interrupt.

    Not in the original PCI0646 datasheet -- it says that reading the 
register clears the interrupt bit. PCI0646U datashett however started 
talking about writing one to clear the bit.

> The doc doesn't say
> anything about not touching status but it also uses the word "must" about
> the other bits so make what you will of it.

    I think they use must in the sense that if the driver *really* needs to 
know from which channel the interrupt has come. Since most of the chip don't 
provide that capability, the real world Linux drivers, both old and new, had 
to get along without such knowledge. The IDE driver does read and clear the 
interrupt bits now though, in both PIO abnd DMA modes.

> In DMA mode I would read the BMDMA status in preference to status but the
> doc doesn't specifically say to do so and simply say it works to the
> spec. it isn't clear if ARTIM23 and CFR work for reporting/clearing a DMA
> interrupt. You'd have to try it.

    Earlier the IDE driver did chec CFR/ARTTIM23 bits before the BMIDE 
status interrupt bit in dma_test_irq() method and that used to work.  Now it 
also does so, via the new test_irq() method.

> ARTIM23 may well need some locking care

    Locking WRT what? It's not shared between channels...

> The 646U2 adds the MRDMODE register so you can check the bits more sanely

    Yeah. The libata driver however doesn't make use of that register, 
unlike  cmd64x. It doesn't even touch the interrupt bits on PCI0646, only 
manipulation the "old" bits on PCI-64[89].
    It seems that I need to sync up these two, pata_cmd64x.c seems to be 
lagging behind the changes in cmd64x.c. Well, not only this one, at least 
pata_hpt* drivers are lagging behind too...

WBR, Sergei
