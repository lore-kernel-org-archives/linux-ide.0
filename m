From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/7] libata: implement ap->sata_spd_limit and helpers
Date: Sun, 02 Apr 2006 06:43:01 -0400
Message-ID: <442FAAB5.30501@pobox.com>
References: <11439680862635-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:63469 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932310AbWDBKnJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 06:43:09 -0400
In-Reply-To: <11439680862635-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> -	/* Issue phy wake/reset */
> +	/* SATA spec says nothing about how to reconfigure spd.
> +	 * Configuring before starting hardreset works for both of my
> +	 * test cases - ICH7 AHCI and sil3124.  Configuring while phy
> +	 * is off sounds nice but ICH7 chokes on that.  It preserves
> +	 * configured value but does not apply it.
> +	 */
> +	ata_set_sata_spd(ap);
> +
> +	/* issue phy wake/reset */
>  	scontrol = scr_read(ap, SCR_CONTROL);
>  	scontrol = (scontrol & 0x0f0) | 0x301;
>  	scr_write_flush(ap, SCR_CONTROL, scontrol);

This code is an example of configuring the phy while its off...  You put 
the speed setting before the phy wake.

Everything else looks OK.

	Jeff


