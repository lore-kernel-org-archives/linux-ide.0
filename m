From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 46/73] pata_radisys: use ata.h mode mask defines, add
 ATA_UDMA24_ONLY
Date: Sat, 14 Mar 2009 19:44:05 +0000
Message-ID: <20090314194405.52e80b21@lxorguk.ukuu.org.uk>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
	<alpine.BSF.1.00.0903142019350.59456@anduin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45992 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752962AbZCNTnY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:43:24 -0400
In-Reply-To: <alpine.BSF.1.00.0903142019350.59456@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Inge =?ISO-8859-14?B?Qm9sc/g=?= <knan-lkml@anduin.net>
Cc: linux-ide@vger.kernel.org

> +		.mwdma_mask	= ATA_MWDMA2, /* mwdma1-2 */
> +		.udma_mask	= ATA_UDMA24_ONLY,

Your suspicions are correct here btw - the device can only do MWDMA1 and
MWDMA2 (much like some PIIX devices)
