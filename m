From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.19-rc6] ata_piix: IDE mode SATA patch for Intel ICH9
Date: Wed, 22 Nov 2006 10:03:31 +0900
Message-ID: <4563A1E3.1030703@gmail.com>
References: <39B20DF628532344BC7A2692CB6AEE07A5A310@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:54703 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S966981AbWKVBDk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Nov 2006 20:03:40 -0500
Received: by nf-out-0910.google.com with SMTP id c2so337659nfe
        for <linux-ide@vger.kernel.org>; Tue, 21 Nov 2006 17:03:39 -0800 (PST)
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE07A5A310@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Gaston, Jason D wrote:
> Did this come through ok, using Evolution, or do I need to try a
> different email client and send again?

It's wrapped and more comments below.

> -----Original Message-----
> From: Gaston, Jason D 
> Sent: Tuesday, November 21, 2006 2:52 PM
> To: jgarzik@pobox.com; linux-ide@vger.kernel.org;
> linux-kernel@vger.kernel.org; Gaston, Jason D
> Subject: [PATCH 2.6.19-rc6] ata_piix: IDE mode SATA patch for Intel ICH9
> 
> This patch adds the Intel ICH9 IDE mode SATA controller DID's.
> 
> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
> 
> --- linux-2.6.19-rc6/drivers/ata/ata_piix.c.orig	2006-11-20
> 04:58:48.000000000 -0800
> +++ linux-2.6.19-rc6/drivers/ata/ata_piix.c	2006-11-20
> 06:15:12.000000000 -0800

Above two lines are wrapped.

> @@ -127,6 +127,7 @@
>  	ich6_sata_ahci		= 8,
>  	ich6m_sata_ahci		= 9,
>  	ich8_sata_ahci		= 10,
> +	ich9_sata_ahci		= 11,

AFAICS, ich9 isn't different from ich8.  Any reason not to simply use 
ich8_sata_ahci?

[--snip--]
> +static const struct piix_map_db ich9_map_db = {
> +	.mask = 0x3,
> +	.port_enable = 0x3,
> +	.present_shift = 8,

I guess this patch is against libata-dev#upstream-fixes.  Just FYI 
.present_shift is gone in libata-dev#upstream.

-- 
tejun
