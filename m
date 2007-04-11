From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH] libata: HPA support
Date: Wed, 11 Apr 2007 12:38:14 -0400
Message-ID: <20070411163814.GA22089@athena.road.mcmartin.ca>
References: <20070411002313.29069ca5@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:59685 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251AbXDKQjs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Apr 2007 12:39:48 -0400
Content-Disposition: inline
In-Reply-To: <20070411002313.29069ca5@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Wed, Apr 11, 2007 at 12:23:13AM +0100, Alan Cox wrote:
> @@ -3341,6 +3545,11 @@ static int ata_dev_same_device(struct at
>  			       "%llu != %llu\n",
>  			       (unsigned long long)dev->n_sectors,
>  			       (unsigned long long)new_n_sectors);
> +		/* Are we the boot time size - if so we appear to be the
> +		   same disk at this point and our HPA got reapplied */
> +		if (ata_ignore_hpa && dev->n_sectors_boot == new_n_sectors 
> +		    && ata_id_hpa_enabled(new_id))
> +			return 1;
>  		return 0;

Instead of storing the n_sectors_boot, would it not be sufficient to
attempt ata_hpa_resize, and compare dev->n_sectors with the result?
(Or even just redo the read_native_max command to check it?)

Cheers,
	Kyle M.
