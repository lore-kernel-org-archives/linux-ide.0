From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: fix out-of-bounds access in pata_oldpiix.c
Date: Fri, 1 Aug 2008 23:29:14 +0100
Message-ID: <20080801232914.3077c21b@lxorguk.ukuu.org.uk>
References: <488040E4.1090500@gmx.ch>
	<20080718095541.6bf01fff@the-village.bc.nu>
	<200807181615.26272.bzolnier@gmail.com>
	<4892927A.1000808@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60237 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762200AbYHAWqb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Aug 2008 18:46:31 -0400
In-Reply-To: <4892927A.1000808@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, David =?UTF-8?B?TcO8?= =?UTF-8?B?bGxlcg==?= <dave.mueller@gmx.ch>, jgarzik@pobox.com, linux-ide@vger.kernel.org


> see it as libata-core won't call them if unsupported but qc_issue will
> see it.  Can you please unnak?

No. Please see the patch I posted. It got a bit stuck as I got no reply
at all to the original query so it was filed on the low priority pile.
Simply quick fixing one case isn't the way to sort a bug like that. 

No un-nak as I've now been through and fixed the lot including a couple
of really nasty assumptions that >= UDMA_0 means UDMA mode (which isnt
true as 0xFF is no DMA)
