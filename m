From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 82/86] pata_via: clear UDMA transfer mode bit for PIO
 and MWDMA
Date: Wed, 25 Nov 2009 17:52:57 +0000
Message-ID: <20091125175257.796afeb3@lxorguk.ukuu.org.uk>
References: <20091125170218.5446.13513.sendpatchset@localhost>
	<20091125171218.5446.41962.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56871 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932858AbZKYRuw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:50:52 -0500
In-Reply-To: <20091125171218.5446.41962.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

>  	/* Set UDMA unless device is not UDMA capable */
> -	if (udma_type && t.udma) {
> -		u8 cable80_status;
> +	if (udma_type) {
> +		u8 udma_etc;

This seems odd the original test is that we are a udma controller and
have a udma timing specified. Otherwise there is no point doing any work.

The rest seems to be gratuitious register renaming and makes the patches
hard to review. Please split this sort of stuff up.

