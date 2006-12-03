From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.19 3/3] sata_promise: cleanups
Date: Sun, 03 Dec 2006 22:05:51 +0900
Message-ID: <4572CBAF.1010800@gmail.com>
References: <200612010959.kB19xmAw002464@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:41269 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759646AbWLCNGF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Dec 2006 08:06:05 -0500
Received: by nf-out-0910.google.com with SMTP id o25so4086029nfa
        for <linux-ide@vger.kernel.org>; Sun, 03 Dec 2006 05:06:03 -0800 (PST)
In-Reply-To: <200612010959.kB19xmAw002464@alkaid.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> This patch performs two simple cleanups of sata_promise.
> 
> * Remove board_20771 and map device id 0x3577 to board_2057x.
>   After the recent corrections for SATAII chips, board_20771 and
>   board_2057x were equivalent in the driver.

Ack.

> * Remove hp->hotplug_offset and use hp->flags & PDC_FLAG_GEN_II
>   to compute hotplug_offset in pdc_host_init().

Please explain why.

> @@ -704,7 +684,7 @@ static void pdc_host_init(unsigned int c
>  {
>  	void __iomem *mmio = pe->mmio_base;
>  	struct pdc_host_priv *hp = pe->private_data;
> -	int hotplug_offset = hp->hotplug_offset;
> +	int hotplug_offset = (hp->flags & PDC_FLAG_GEN_II) ? PDC2_SATA_PLUG_CSR : PDC_SATA_PLUG_CSR;

People tend to prefer explicit if () over ?: and dislike lines much
longer than 80 column, well, at least in libata.

Thanks.

-- 
tejun
