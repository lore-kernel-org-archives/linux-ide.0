From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with
 SSD
Date: Fri, 23 Oct 2009 17:51:57 +0100
Message-ID: <20091023175157.3a898525@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com>
	<200910221144.04471.bzolnier@gmail.com>
	<Pine.LNX.4.64.0910231024240.324@hs20-bc2-1.build.redhat.com>
	<200910231644.29919.bzolnier@gmail.com>
	<Pine.LNX.4.64.0910231050330.3007@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47395 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752398AbZJWQuc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2009 12:50:32 -0400
In-Reply-To: <Pine.LNX.4.64.0910231050330.3007@hs20-bc2-1.build.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, elendil@planet.nl

> So, why was it serialized before? I assume that either someone noticed the 
> corruption or someone read some datasheet noting the corruption or someone 
> reverse engineered some other driver and saw the serialization.

The data sheet has some things to say for the 643 abd 646

In PIO mode it says you must check

CFR bit 2   (indicates primary interrupt)
ARTIM23 bit 4  (secondary interrupt)

Both bits can be written 1 to clear the interrupt. The doc doesn't say
anything about not touching status but it also uses the word "must" about
the other bits so make what you will of it.

In DMA mode I would read the BMDMA status in preference to status but the
doc doesn't specifically say to do so and simply say it works to the
spec. it isn't clear if ARTIM23 and CFR work for reporting/clearing a DMA
interrupt. You'd have to try it.

ARTIM23 may well need some locking care


The 646U2 adds the MRDMODE register so you can check the bits more sanely


