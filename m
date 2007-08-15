From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/4] libata: implement BROKEN_HPA horkage and apply to
 affected drives
Date: Wed, 15 Aug 2007 19:22:57 +0100
Message-ID: <20070815192257.126fa84b@the-village.bc.nu>
References: <20070815180508.GD21623@htj.dyndns.org>
	<20070815180721.GF21623@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34902 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S934886AbXHOSPK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 14:15:10 -0400
In-Reply-To: <20070815180721.GF21623@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

> +	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_HORKAGE_BROKEN_HPA, },
> +	{ "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_HORKAGE_BROKEN_HPA },
> +	{ "WDC WD2500JD-00HBB0", "WD-WMAL71490727", ATA_HORKAGE_BROKEN_HPA },


I'm still a little bothered that we haven't seen these reported with old
IDE (unlike the off by one which was there once you knew where to look).
Guess they've simply not shown up as they are all SATA

Series:

Acked-by: Alan Cox <alan@redhat.com>
