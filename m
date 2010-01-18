From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 23/64] pata_via: store UDMA masks in via_isa_bridges
 table
Date: Mon, 18 Jan 2010 18:03:37 +0000
Message-ID: <20100118180337.64f4f45b@lxorguk.ukuu.org.uk>
References: <20100118171349.14623.90030.sendpatchset@localhost>
	<20100118171712.14623.9408.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58324 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752347Ab0ARSAv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 13:00:51 -0500
In-Reply-To: <20100118171712.14623.9408.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


> +	switch (udma_type) {
> +	case ATA_UDMA4:
> +		UT = T / 2; break;
> +	case ATA_UDMA5:
> +		UT = T / 3; break;
> +	case ATA_UDMA6:
> +		UT = T / 4; break;
> +	}

UT = T (udma_type - ATA_UDMA3) ?



Looks good
