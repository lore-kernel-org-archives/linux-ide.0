From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC] add DMA setup FIS auto-activate feature
Date: Thu, 23 Jul 2009 13:55:07 +0400
Message-ID: <4A68337B.60807@ru.mvista.com>
References: <1248320734.9035.22.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:26264 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752107AbZGWJzO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Jul 2009 05:55:14 -0400
In-Reply-To: <1248320734.9035.22.camel@sli10-desk.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, tj@kernel.org

Hello.

Shaohua Li wrote:

> hi,
> The SATA spec defines DMA setup FIS auto-activate optimization for FPDMA
> transfers. I had an attempt to add it, though my test doesn't show obvious
> performance improvement (not worse too), I wonder why not add this feature?
>
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 2c6aeda..53cc355 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2303,6 +2303,7 @@ static void ata_dev_config_ncq(struct ata_device *dev,
>  {
>  	struct ata_port *ap = dev->link->ap;
>  	int hdepth = 0, ddepth = ata_id_queue_depth(dev->id);
> +	const u16 *id = dev->id;
>   

   Why introduce the variable if you're only using it once?

>  	if (!ata_id_has_ncq(dev->id)) {
>   

   Should be changed to just 'id'...

>  		desc[0] = '\0';
> @@ -2317,6 +2318,9 @@ static void ata_dev_config_ncq(struct ata_device *dev,
>  		dev->flags |= ATA_DFLAG_NCQ;
>  	}
>  
> +	if (ata_id_has_daa(id))
> +		ata_dev_set_feature(dev, SETFEATURES_SATA_ENABLE, SATA_DAA);
> +
>   

MBR, Sergei


