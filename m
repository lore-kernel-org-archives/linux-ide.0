From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: fix out-of-bounds access in pata_oldpiix.c
Date: Sun, 03 Aug 2008 14:22:52 +0900
Message-ID: <489540AC.9060409@kernel.org>
References: <488040E4.1090500@gmx.ch>	<20080718095541.6bf01fff@the-village.bc.nu>	<200807181615.26272.bzolnier@gmail.com>	<4892927A.1000808@kernel.org> <20080801232914.3077c21b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49029 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbYHCFXe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Aug 2008 01:23:34 -0400
In-Reply-To: <20080801232914.3077c21b@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, =?ISO-8859-1?Q?David_?= =?ISO-8859-1?Q?M=FCller?= <dave.mueller@gmx.ch>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Alan Cox wrote:
>> see it as libata-core won't call them if unsupported but qc_issue will
>> see it.  Can you please unnak?
> 
> No. Please see the patch I posted. It got a bit stuck as I got no reply
> at all to the original query so it was filed on the low priority pile.
> Simply quick fixing one case isn't the way to sort a bug like that. 
> 
> No un-nak as I've now been through and fixed the lot including a couple
> of really nasty assumptions that >= UDMA_0 means UDMA mode (which isnt
> true as 0xFF is no DMA)

Ah... okay.  That looks like a much better way to handle this.  Let's
continue there.  Thanks.

-- 
tejun
