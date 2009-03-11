From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH,v2][1/2] sata-mv: enable HDD led blinking when NCQ is
 active for GenIIe
Date: Wed, 11 Mar 2009 08:47:05 -0400
Message-ID: <49B7B2C9.10203@rtr.ca>
References: <200903110813.25650.elendil@planet.nl> <200903110815.52650.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:44444 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173AbZCKMrJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Mar 2009 08:47:09 -0400
In-Reply-To: <200903110815.52650.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

Frans Pop wrote:
..
> @@ -480,11 +487,19 @@ struct mv_hw_ops {
>  			   unsigned int port);
>  	void (*enable_leds)(struct mv_host_priv *hpriv, void __iomem *mmio);
>  	void (*read_preamp)(struct mv_host_priv *hpriv, int idx,
> -			   void __iomem *mmio);
> +			    void __iomem *mmio);
>  	int (*reset_hc)(struct mv_host_priv *hpriv, void __iomem *mmio,
>  			unsigned int n_hc);
>  	void (*reset_flash)(struct mv_host_priv *hpriv, void __iomem *mmio);
>  	void (*reset_bus)(struct ata_host *host, void __iomem *mmio);
> +	void (*enable_led_blink)(struct mv_host_priv *hpriv,
> +				 void __iomem *mmio, int enable_blink);
> +
> +	/*
> +	 * ->inherits must be the last field and all the preceding
> +	 * fields must be pointers.
> +	 */
> +	const struct mv_hw_ops	*inherits;
>  };
..

>  
> +static const struct mv_hw_ops mv6xxx_iie_ops = {
> +	.inherits		= &mv6xxx_ops,
> +	.enable_led_blink	= mv_iie_enable_led_blink,
> +};
> +


I'm afraid I just don't understand the purpose of "inherits" above.
This field appears to never be referenced anywhere.

(or did I miss an update to the C programming language at some point?  :)

???
