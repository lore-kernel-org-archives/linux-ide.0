Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D3FC433F5
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 00:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbhLIAx7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 19:53:59 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40039 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbhLIAx6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 19:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639011026; x=1670547026;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s+7r7ikKkYLhYN5GgFZBRWwdbst8n9nkA2lMkWYFZfk=;
  b=SDgeLkfnQAwM0qg8iHJ2MJOJHiFhWaDF3RPjV8ljjyKCILTN7SuLJZ0u
   Mc99s+mNEOqrGXWueYiOo8TlgmsDPeHw3hHZe9iOyAUF8UF3qBdmUGWiw
   cKTgXu+SGTQ3bGkL9ud2c+t8IqlsAsoJT0AIVRbqT1UXlXHsCzf+ZVr3D
   PYUTrZTDIgpGUCtCfQn79OxgV3Ddgg2wyfaRTRKAYw3+62cRI0VwM8cjI
   OdCDOJsfh+8TYQUqoyd3kWjkJ1LKvSVAUwG+ecUeK/DxuDpal5KQm+P/S
   AMEz5PJT9ipLGmSRlyMhokQFD8peu8jl7qu2HyporKfk6A3JX4BetdRhH
   w==;
X-IronPort-AV: E=Sophos;i="5.88,190,1635177600"; 
   d="scan'208";a="299636232"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 08:50:25 +0800
IronPort-SDR: Q3QdSzDqG4O6sbgmyBwjIJS9JHi/x+6BQFSU7lMG221B377Cgczt8iZuVReVq1iAE7CXnGde+9
 MWO7wIMmUCzOfOg6UZbGmtFXOuDp4nH1UXYtQ+eSuEtp5+XVbFcqZOABK8ddi9nB15mfRecrY0
 piDdRBTtw2VqO6nbyqX4Zpe+wStCbn3PeW3vPpnOOyA3KQFMnZQDqaxOVwTMK6QTftxM2BlrO7
 9pyWNOQkkc2qs+G/8Yt93lapCShXVaRbzByRzd9hQT7b4Pe/SMa3JGCiY8aDnCs47C46GZg8qq
 qSAGWOLgindeZiImlc0T/8Er
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:25:00 -0800
IronPort-SDR: LZcNBf6V2AoZsFykGZmvpZi4hlaFHm+PRdFQb2zh1yN0gQrkskHetPsXKGwRaBYj63qCZLXuzL
 BvvMbwtMfPfTHFxftqTnHV3hecUGqOgdq4pmDCkt8m1k+3+dQKgLQBBOJUTJuGeCcDBiuP0gKE
 QqIf5g7GDECQaq928Sf8lvFeERg78ig11nL4LOklLgbC+CxkqvMo25+K0qWJWiAd6CU9ZILp8g
 oNymyGlE86kI1drLMkUIs1y3hE8Vvs4yWbIjrVGoeXWRTUwCjBm2DoCP9b6btarMvxCk/TkT35
 0MA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:50:27 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J8b6n4yxxz1Rwnv
        for <linux-ide@vger.kernel.org>; Wed,  8 Dec 2021 16:50:25 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639011025; x=1641603026; bh=s+7r7ikKkYLhYN5GgFZBRWwdbst8n9nkA2l
        MkWYFZfk=; b=LnSLGFPa5bJ4gzS2tGUOZGATJBnFvYjz/ZdfylD9DJctChUuM1t
        l0YNtbJgoLTMw8ZsE6QiSesz2KlmbDG5bTLOeALw98v925537l4o3Cm/CfFh5uYg
        Hsg7iaTGiHQHntxU5sArYnPiY25OhgVg+YmCnCaC+zjrH+uDsSRMBBPpKhcG798K
        DkTcmTFvggciCL275LHmM1VxRXZlIz48AzxVqTkidE5zWu4713C8aNA2sjzScyaG
        OuzLE76s0seBGhP7tpxLK9pHHVljTAJr4Pbz7LLL+Jgg01w17cMJvDS+WaQWjrsL
        QfrPgGPQbvyCBUe38kEnufJFSru4dtGEZ0Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bppIEh255BIy for <linux-ide@vger.kernel.org>;
        Wed,  8 Dec 2021 16:50:25 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J8b6m5Gmxz1RtVG;
        Wed,  8 Dec 2021 16:50:24 -0800 (PST)
Message-ID: <cb0248e5-3572-5a36-e428-33d97364a879@opensource.wdc.com>
Date:   Thu, 9 Dec 2021 09:50:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 19/73] libata: drop DPRINTK() calls during ATA error
 handling
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-20-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211208163255.114660-20-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/09 1:32, Hannes Reinecke wrote:
> The information is now logged with tracepoints, so the DPRINTK()
> calls can be dropped.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

squash this one in the previous patch ?

> ---
>  drivers/ata/libata-eh.c   | 12 ------------
>  drivers/ata/libata-pmp.c  |  8 --------
>  drivers/ata/libata-sata.c |  3 ---
>  3 files changed, 23 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 2a25be588e14..a0fd38260f48 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -533,8 +533,6 @@ void ata_scsi_error(struct Scsi_Host *host)
>  	unsigned long flags;
>  	LIST_HEAD(eh_work_q);
>  
> -	DPRINTK("ENTER\n");
> -
>  	spin_lock_irqsave(host->host_lock, flags);
>  	list_splice_init(&host->eh_cmd_q, &eh_work_q);
>  	spin_unlock_irqrestore(host->host_lock, flags);
> @@ -548,7 +546,6 @@ void ata_scsi_error(struct Scsi_Host *host)
>  	/* finish or retry handled scmd's and clean up */
>  	WARN_ON(!list_empty(&eh_work_q));
>  
> -	DPRINTK("EXIT\n");
>  }
>  
>  /**
> @@ -1932,8 +1929,6 @@ static void ata_eh_link_autopsy(struct ata_link *link)
>  	u32 serror;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> -
>  	if (ehc->i.flags & ATA_EHI_NO_AUTOPSY)
>  		return;
>  
> @@ -2040,7 +2035,6 @@ static void ata_eh_link_autopsy(struct ata_link *link)
>  		ehc->i.action |= ata_eh_speed_down(dev, eflags, all_err_mask);
>  		trace_ata_eh_link_autopsy(dev, ehc->i.action, all_err_mask);
>  	}
> -	DPRINTK("EXIT\n");
>  }
>  
>  /**
> @@ -2940,8 +2934,6 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
>  	unsigned long flags;
>  	int rc = 0;
>  
> -	DPRINTK("ENTER\n");
> -
>  	/* For PATA drive side cable detection to work, IDENTIFY must
>  	 * be done backwards such that PDIAG- is released by the slave
>  	 * device before the master device is identified.
> @@ -3055,7 +3047,6 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
>  
>   err:
>  	*r_failed_dev = dev;
> -	DPRINTK("EXIT rc=%d\n", rc);
>  	return rc;
>  }
>  
> @@ -3570,8 +3561,6 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
>  	int rc, nr_fails;
>  	unsigned long flags, deadline;
>  
> -	DPRINTK("ENTER\n");
> -
>  	/* prep for recovery */
>  	ata_for_each_link(link, ap, EDGE) {
>  		struct ata_eh_context *ehc = &link->eh_context;
> @@ -3779,7 +3768,6 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
>  	if (rc && r_failed_link)
>  		*r_failed_link = link;
>  
> -	DPRINTK("EXIT, rc=%d\n", rc);
>  	return rc;
>  }
>  
> diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
> index ba7be3f38617..e2e9cbd405fa 100644
> --- a/drivers/ata/libata-pmp.c
> +++ b/drivers/ata/libata-pmp.c
> @@ -652,8 +652,6 @@ static int sata_pmp_revalidate(struct ata_device *dev, unsigned int new_class)
>  	u32 *gscr = (void *)ap->sector_buf;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> -
>  	ata_eh_about_to_do(link, NULL, ATA_EH_REVALIDATE);
>  
>  	if (!ata_dev_enabled(dev)) {
> @@ -686,12 +684,10 @@ static int sata_pmp_revalidate(struct ata_device *dev, unsigned int new_class)
>  
>  	ata_eh_done(link, NULL, ATA_EH_REVALIDATE);
>  
> -	DPRINTK("EXIT, rc=0\n");
>  	return 0;
>  
>   fail:
>  	ata_dev_err(dev, "PMP revalidation failed (errno=%d)\n", rc);
> -	DPRINTK("EXIT, rc=%d\n", rc);
>  	return rc;
>  }
>  
> @@ -759,8 +755,6 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
>  	int detach = 0, rc = 0;
>  	int reval_failed = 0;
>  
> -	DPRINTK("ENTER\n");
> -
>  	if (dev->flags & ATA_DFLAG_DETACH) {
>  		detach = 1;
>  		rc = -ENODEV;
> @@ -828,7 +822,6 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
>  	/* okay, PMP resurrected */
>  	ehc->i.flags = 0;
>  
> -	DPRINTK("EXIT, rc=0\n");
>  	return 0;
>  
>   fail:
> @@ -838,7 +831,6 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
>  	else
>  		ata_dev_disable(dev);
>  
> -	DPRINTK("EXIT, rc=%d\n", rc);
>  	return rc;
>  }
>  
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 4e88597aa9df..7b72c68bc9f7 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -533,8 +533,6 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
>  	u32 scontrol;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> -
>  	if (online)
>  		*online = false;
>  
> @@ -610,7 +608,6 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
>  			*online = false;
>  		ata_link_err(link, "COMRESET failed (errno=%d)\n", rc);
>  	}
> -	DPRINTK("EXIT, rc=%d\n", rc);
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(sata_link_hardreset);
> 


-- 
Damien Le Moal
Western Digital Research
