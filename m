From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/9] libata: implement per-dev xfermask
Date: Sat, 05 Aug 2006 14:38:56 +0100
Message-ID: <1154785137.10971.20.camel@localhost.localdomain>
References: <11547252932391-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51107 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161439AbWHENUI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Aug 2006 09:20:08 -0400
In-Reply-To: <11547252932391-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, davej@redhat.com, linux-ide@vger.kernel.org

Ar Sad, 2006-08-05 am 06:01 +0900, ysgrifennodd Tejun Heo:
> +	/* Use the lowest common PIO mode to avoid violating device
> +	 * selection timing.
> +	 */
> +	for (i = 0; i < ATA_MAX_DEVICES; i++) {
> +		struct ata_device *d = &ap->device[i];
> +		if (!ata_dev_absent(d))
> +			xfer_mask &= ata_pack_xfermask(d->pio_mask,
> +						       UINT_MAX, UINT_MAX);
>  	}

We should not do this. Many of the controllers are smart enough to get
it right and those which do not implement this logic internally and
correctly by merging the relevant fields in the ata timing structure.

Alan

