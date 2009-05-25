From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: add warning about possible HPA compatibility
 issue
Date: Mon, 25 May 2009 23:20:14 +0100
Message-ID: <20090525232014.7b6dd7bd@lxorguk.ukuu.org.uk>
References: <200905252348.08970.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34422 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752609AbZEYWTP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 May 2009 18:19:15 -0400
In-Reply-To: <200905252348.08970.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jacob <fun2program8@yahoo.com>, Christopher Hogan <chris.c.hogan@gmail.com>, Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> +static inline void ata_hpa_warn(unsigned long long first_sector,
> +				unsigned long long last_sector)
> +{
> +	printk(KERN_WARNING "*** possible compatibility issue:\n"
> +		"*** sectors %llu-%llu may be inaccessible\n"
> +		"*** if Host Protected Area is used for filesystem data\n"
> +		"*** (please refer to \"ignore_hpa\" module parameter)\n",
> +		first_sector, last_sector);
> +}

NAK - this is extremely misleading and will just randomly terrify users,
who may then set the paramater and corrupt things like BIOS save areas.
