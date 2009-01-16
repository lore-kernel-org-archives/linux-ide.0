From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2 v1] pata_via.c:  support VX855 and future chips whose
 IDE controller use 0x0571.
Date: Fri, 16 Jan 2009 23:34:28 +0900
Message-ID: <49709AF4.4010505@kernel.org>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8087ECECE@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47703 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757631AbZAPOee (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Jan 2009 09:34:34 -0500
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB8087ECECE@exchtp03.taipei.via.com.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: JosephChan@via.com.tw
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Hello, Joseph.

JosephChan@via.com.tw wrote:
> How about this one? Thanks.

Yeap, I like this one much better but I think this can be made a bit
prettier.

> --- a/drivers/ata/pata_via.c	2008-12-25 07:26:37.000000000 +0800
> +++ b/drivers/ata/pata_via.c	2009-01-17 03:34:55.000000000 +0800
> @@ -63,6 +63,7 @@
>  
>  #define DRV_NAME "pata_via"
>  #define DRV_VERSION "0.3.3"
> +#define SINGLE	1 /* To identify single channel controllers */

It's customary to prefix identifiers with something which is somewhat
unique, say, VIA_IDFLAG_SINGLE.  And if it's gonna be flags, the libata way
of doing it is...

enum {
     VIA_IDFLAG_SINGLE		= (1 << 0),
     VIA_IDFLAG_WHATEVER_NEXT	= (1 << 1),
};

and so on...

> @@ -460,6 +463,7 @@
>  	static int printed_version;
>  	u8 enable;
>  	u32 timing;
> +	int single_port = (int) id->driver_data;

How about unsigned long flags = id->driver_data; here

> +	if (single_port)
> +		ppi[1] = &ata_dummy_port_info;
> +	

and flags & VIA_IDFLAG_SINGLE here?

>  	if (!config->id) {
> -		printk(KERN_WARNING "via: Unknown VIA SouthBridge, disabling.\n");
> -		return -ENODEV;
> -	}
> -	pci_dev_put(isa);
> +		printk(KERN_WARNING "via: Unknown VIA SouthBridge.\n");
> +		config = via_isa_bridges;
> +	} else
> +		pci_dev_put(isa);

Also, you can just bypass whole southbridge thing.  Add another flag,
say, VIA_IDFLAG_IGN_SOUTH or something and just skip the whole thing
if the flags is set.

Thanks.

-- 
tejun
