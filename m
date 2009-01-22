From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2 v1] pata_via.c:  support VX855 and future chips whose
 IDE controller use 0x0571.
Date: Thu, 22 Jan 2009 10:19:26 +0900
Message-ID: <4977C99E.1000102@kernel.org>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB808831374@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43090 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754973AbZAVBTl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Jan 2009 20:19:41 -0500
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB808831374@exchtp03.taipei.via.com.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: JosephChan@via.com.tw
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, sshtylyov@ru.mvista.com

Hello, Joseph.

JosephChan@via.com.tw wrote:
>> Also, you can just bypass whole southbridge thing.  Add 
>> another flag, say, VIA_IDFLAG_IGN_SOUTH or something and just 
>> skip the whole thing if the flags is set.
>>
> 
> This is our next goal for this. :)

:-)

> @@ -97,8 +101,14 @@
>  	u8 rev_max;
>  	u16 flags;
>  } via_isa_bridges[] = {
> +	{ "vtxxxx",	PCI_DEVICE_ID_VIA_ANON,    0x00, 0x2f, VIA_UDMA_133 |
> +	VIA_BAD_AST },

More usual line breaking / indenting style would be...

	{ "vtxxxx",	PCI_DEVICE_ID_VIA_ANON,    0x00, 0x2f,
	  VIA_UDMA_133 | VIA_BAD_AST },

> @@ -460,6 +470,7 @@
>  	static int printed_version;
>  	u8 enable;
>  	u32 timing;
> +	unsigned long flags = id->driver_data;
>  	int rc;
>  
>  	if (!printed_version++)
> @@ -469,6 +480,9 @@
>  	if (rc)
>  		return rc;
>  
> +	if (flags & VIA_IDFLAG_SINGLE)
> +		ppi[1] = &ata_dummy_port_info;
> +	

Yay.

> @@ -483,10 +497,10 @@
>  		}
>  
>  	if (!config->id) {
> -		printk(KERN_WARNING "via: Unknown VIA SouthBridge, disabling.\n");
> -		return -ENODEV;
> -	}
> -	pci_dev_put(isa);
> +		printk(KERN_WARNING "via: Unknown VIA SouthBridge.\n");
> +		config = via_isa_bridges;

Heh.. a bit confusing.  Can you please put the wildcard entry at the
end of the list and make the loop condition

 for (config = via_isa_bridges; config->id != PCI_DEVICE_ID_VIA_ANON; config++)

That way, you won't need any special handling and just use "UNKNOWN"
as the name of the wildcard entry.

Thanks.

-- 
tejun
