From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] pata_cs5536: ATA driver for Geode companion chip
Date: Wed, 3 Oct 2007 19:51:33 +0100
Message-ID: <20071003195133.367b6655@the-village.bc.nu>
References: <yq14ph8xg3z.fsf@sermon.lab.mkp.net>
	<20071003192232.558ec72b@the-village.bc.nu>
	<yq1tzp8vxzb.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51520 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752037AbXJCSqi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Oct 2007 14:46:38 -0400
In-Reply-To: <yq1tzp8vxzb.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <mkp@mkp.net>
Cc: linux-ide@vger.kernel.org, info-linux@geode.amd.com

On Wed, 03 Oct 2007 14:45:12 -0400
"Martin K. Petersen" <mkp@mkp.net> wrote:

> >>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> Alan> The older AMD ex NS ex Cyrix chipsets mishandle 64K DMA blocks -
> Alan> is that the case for the CS5536 or not - does it consider a PRD
> Alan> entry with zero length as 64K or 0 bytes
> 
> The databook says: "The size must be in multiples of 1 WORD (2 bytes)
> or zero (which means a 64 KB transfer)."

So does the older databook for the ones that get it wrong 8)

Alan
