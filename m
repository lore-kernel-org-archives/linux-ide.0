Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C0EC433F5
	for <linux-ide@archiver.kernel.org>; Sun, 13 Feb 2022 23:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238772AbiBMXZZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 13 Feb 2022 18:25:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238771AbiBMXZZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 13 Feb 2022 18:25:25 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E4D5132E
        for <linux-ide@vger.kernel.org>; Sun, 13 Feb 2022 15:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644794718; x=1676330718;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=pcReoYeDBoRBuu3RhFR7LjW2j6nf0uCNGQhDKuTs7Ac=;
  b=VCIFweFzDnpOwhPmlsbmE8Ti6ussJJQUoNS0I7d4mzOdIoCdckUlb3UO
   39UxneDcSXznzMlMwTCJfS8r7P+m1UhIDHLBbneB772LFpZCfiVPUj/+E
   M9wIuOCtLL44jSowSIwJYAiWV8ECJgjP4dmrc1+WFnSMMUMiMIsupnl4D
   QUXkxDHUnJ5gP5CETPDwVAiowgZXH6pbsCb4dXvYg2MJyZhcmQwlBqBW2
   n/Z/evDFSfw/e/jwWBZf5z9/Qvhs3OyNhwgiR7WnCNza+DbF0ZHuOrnUO
   cdEgN3BPqRNZUaQUvosYG9rC+bEJ880LlNJGoExWMCVmrZICDj1+KSptT
   w==;
X-IronPort-AV: E=Sophos;i="5.88,366,1635177600"; 
   d="scan'208";a="193790898"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2022 07:25:18 +0800
IronPort-SDR: d1kJyp0nl76FN7BSdyAd3OriVM829gLOwpUxU5iNKTzjX5TY+3ifukm4hzYhMopZyVof3Uf3Qq
 sU5NQ17W7Hp8T9+nN3dMz7sO55R8RQ+0gNN+40mXScjz1DskQMObnBNI89o8hCERQs3G0Mvbgd
 6JAm+3QReDjtY7m87EdXP7D5iuMHcVuvYQjdBfMkf8Cun+f/U+hq8iX38iEQCwp/rZoOhKXqmr
 fk8waTrBvy04SGQeLS1ip7rawu4f488R70CpGGAscAkkt3Eg8SAbBlO7hVIXKbg23+zqlzv4fr
 51xenMMoKt88ET59m9p+1XAF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 14:57:00 -0800
IronPort-SDR: oBMV+5R9ZrUGgRCVNN3u3SSoCCaXR5580zW/vjfM8nwFgFKCSHboxO+t+zC27y+XtWk/Hqj/se
 KDHpmXUww0E4uUiN9/eXCiFb9S7AE4cSkDcqRwHP2ipWxt0D0c+ocp+z93/t2fhdO+JH/h/3OE
 5fVmK/bd4wwRfxGOghUGmFq1mSxqpRVxVAWr6njNp2O26B0xFN9BXwXiKEgTCeq3OchVAJ837Z
 tEO95wa6MtX/oxmI95Iesk0W65g2/CcUeqAn1O5n0qm+LfCTT+5InaBaroKEc/0vJBrLufFrw2
 5hs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 15:25:18 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jxk3d3Tyvz1SVnx
        for <linux-ide@vger.kernel.org>; Sun, 13 Feb 2022 15:25:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644794716; x=1647386717; bh=pcReoYeDBoRBuu3RhFR7LjW2j6nf0uCNGQh
        DKuTs7Ac=; b=NYmdKmC3FKddIWjmV7zENXKtaidE67oDitR4TdEN2jtbU/Gv0Cw
        DZNoNlugWZKEK3TSacU/YebTnPZc+3j/PTAWgBtNsei2F4RC7VoVVVeEI7vKavvF
        sQe/b9EFpnYa2yrFPldhEUJfVOySH2tJc3ewBH6g/4Wp3BBmDBnm3jEnIBsst1I8
        CbdTANSbcgKoYMZFf6W3FARs/57Q2XIE20l/iYF89s3WJupzinYX8UKiUePYyiY/
        TLXbLWPrVMgMBNL23Z5hoR+6XElanCdGql+kfZhHssq0C8iy8VN5eEtRG7DefpBw
        aCK8r/POmlOG5QxxvOtOvXVlLDLy49qC23g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id D4AGgAiINYPS for <linux-ide@vger.kernel.org>;
        Sun, 13 Feb 2022 15:25:16 -0800 (PST)
Received: from [10.89.82.198] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.82.198])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jxk3c26MWz1Rwrw;
        Sun, 13 Feb 2022 15:25:16 -0800 (PST)
Message-ID: <82f8b8fd-56c8-b6ed-9658-822643e0e0c9@opensource.wdc.com>
Date:   Mon, 14 Feb 2022 08:25:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v2 1/2] ata: libata-sff: refactor ata_sff_set_devctl()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220213151032.4694-1-s.shtylyov@omp.ru>
 <20220213151032.4694-2-s.shtylyov@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220213151032.4694-2-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/02/14 0:10, Sergey Shtylyov wrote:
> Commit 41dec29bcb05 ("libata: introduce sff_set_devctl() method") left some
> clumsy checks surrounding calls to ata_sff_set_devctl() which Jeff Garzik
> suggested to factor out...  and I never followed up. :-(
> 
> At last, refactor ata_sff_set_devctl() to include the repetitive checks and
> return a 'bool' result indicating if the device control register exists or
> not.
> 
> While at it, further update the 'kernel-doc' comment -- the device control
> register has never been a part of the taskfile, despite what Jeff and co.
> think! :-)
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

This patch has "v2"... I do not recall seeing a v1 and the cover letter has no
changelog (and no v2 tag)... Is this a new series ?

> ---
>  drivers/ata/libata-sff.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 546b1f73ede5..3fb5bd4de50c 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -265,20 +265,26 @@ EXPORT_SYMBOL_GPL(ata_sff_wait_ready);
>   *	@ap: port where the device is
>   *	@ctl: value to write
>   *
> - *	Writes ATA taskfile device control register.
> + *	Writes ATA device control register.
>   *
> - *	Note: may NOT be used as the sff_set_devctl() entry in
> - *	ata_port_operations.
> + *	RETURN:
> + *	true if the register exists, false if not.
>   *
>   *	LOCKING:
>   *	Inherited from caller.
>   */
> -static void ata_sff_set_devctl(struct ata_port *ap, u8 ctl)
> +static bool ata_sff_set_devctl(struct ata_port *ap, u8 ctl)
>  {
> -	if (ap->ops->sff_set_devctl)
> +	if (ap->ops->sff_set_devctl) {
>  		ap->ops->sff_set_devctl(ap, ctl);
> -	else
> +		return true;
> +	}
> +	if (ap->ioaddr.ctl_addr) {
>  		iowrite8(ctl, ap->ioaddr.ctl_addr);
> +		return true;
> +	}
> +
> +	return false;
>  }
>  
>  /**
> @@ -357,8 +363,6 @@ static void ata_dev_select(struct ata_port *ap, unsigned int device,
>   */
>  void ata_sff_irq_on(struct ata_port *ap)
>  {
> -	struct ata_ioports *ioaddr = &ap->ioaddr;
> -
>  	if (ap->ops->sff_irq_on) {
>  		ap->ops->sff_irq_on(ap);
>  		return;
> @@ -367,8 +371,7 @@ void ata_sff_irq_on(struct ata_port *ap)
>  	ap->ctl &= ~ATA_NIEN;
>  	ap->last_ctl = ap->ctl;
>  
> -	if (ap->ops->sff_set_devctl || ioaddr->ctl_addr)
> -		ata_sff_set_devctl(ap, ap->ctl);
> +	ata_sff_set_devctl(ap, ap->ctl);
>  	ata_wait_idle(ap);
>  
>  	if (ap->ops->sff_irq_clear)
> @@ -1662,8 +1665,7 @@ void ata_sff_freeze(struct ata_port *ap)
>  	ap->ctl |= ATA_NIEN;
>  	ap->last_ctl = ap->ctl;
>  
> -	if (ap->ops->sff_set_devctl || ap->ioaddr.ctl_addr)
> -		ata_sff_set_devctl(ap, ap->ctl);
> +	ata_sff_set_devctl(ap, ap->ctl);
>  
>  	/* Under certain circumstances, some controllers raise IRQ on
>  	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
> @@ -2061,10 +2063,8 @@ void ata_sff_postreset(struct ata_link *link, unsigned int *classes)
>  		return;
>  
>  	/* set up device control */
> -	if (ap->ops->sff_set_devctl || ap->ioaddr.ctl_addr) {
> -		ata_sff_set_devctl(ap, ap->ctl);
> +	if (ata_sff_set_devctl(ap, ap->ctl))
>  		ap->last_ctl = ap->ctl;
> -	}
>  }
>  EXPORT_SYMBOL_GPL(ata_sff_postreset);
>  


-- 
Damien Le Moal
Western Digital Research
