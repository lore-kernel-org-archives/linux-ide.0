Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B70C433EF
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 01:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238281AbhLIBDc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 20:03:32 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2251 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbhLIBDc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 20:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639011598; x=1670547598;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=12o1iLPH4MUJztTdch5xMYWMtYqgRVXjtOxKaw0CCnA=;
  b=MrjNbk3ecQQWBa8WwD+uv5lhCXKk31yCGU2UBrH+LHbz11iMGrnThzw9
   tL9+xTUENbK3U7g6O2cTEE1YCGokWqvTXAeKmtkXmeqCavvpasDZmwnUn
   Si2Gjrak2O4jXs/lNfQi2Pbgr+Boaiz8huVMv4JCdeouwJfUHa0k2o4NF
   MBypYv2BZtJcqQjLSgvHH3LB3ipQ6YZo6qRVpGC7581cwkath+dV/UT1C
   ye5CjfC9r9ygfu0sq3BCz8eF5VQoCAiMf4EN8LIzJKoNnp5mPM/BuSe65
   71rItVRGhIYh+KNCQ0EUBNGuK3fG7oxtWWflvUV0VTeoHqZWSAdo1N5Wx
   w==;
X-IronPort-AV: E=Sophos;i="5.88,190,1635177600"; 
   d="scan'208";a="192574978"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 08:59:57 +0800
IronPort-SDR: E0M+4cTDoTF5pSYk1HvG0uH/i1V3ujowClGpnqJCFAoOHnyz++nOuOWaxjFsRhxafY5xEt/C5g
 2/mHy9ryPVY4fcdib5WP43kZ1xHUSMzhq6AAW33liEqIvkUbsdV5dTkIgBb/h1eWLy2Jds4mPt
 oGthIcEYyo2C0Yokk7oC4EdXufQpoZGBFokdSLhxU/zWTsSS1RxmhL5RMQuR6ND2fEGZiDeiN8
 REs5UU6RhyCW6AJg4mmg61C7jxUJw5EH2q+qKAzEyIes04ruUjQr2oqxnHkZ+BImpfiv6jaMfM
 dowCIBF7vwVg8zKXpRmEdIvR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:34:33 -0800
IronPort-SDR: W21U8FzGpIJHjm/oLO5FJsuDGcS5G20ktY7RbgXIbkStWrl0GJCBWLACWqzzh8MdfKtnW7wMQ+
 he+/J4Br+x/QJJAkOKy4SbVGgh73iTgoUob4Y4noCa6oC30nDOYYzdP2i2faADMTRht/1poHnW
 suA31h8fHolNTFQgcTie4YpdvxfYR+wIn4HVz4KSJg9/rEPbikXUOl5OTgb/TFtX8j5I2BOji3
 22px+sAXyBACwxPCmkJ4axoJsX8AyTypY17DbFy//vDZLLMLQmVrx+kjrqt8NjP6fFJEqlMJf/
 lUk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 17:00:00 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J8b3Q2MK4z1RwFN
        for <linux-ide@vger.kernel.org>; Wed,  8 Dec 2021 16:47:30 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639010849; x=1641602850; bh=12o1iLPH4MUJztTdch5xMYWMtYqgRVXjtOx
        Kaw0CCnA=; b=eOU24a4VQJY0bVSat8dE/3E6mMlLmOItK2hxx2/gYg11qBw5E0b
        l6H7INloV+8L7GoK2mpRiJK2IrrFSSEu2apD1JGcwBvveUfe87tuIWJ9t3VJ1kEV
        GofWgDMD0suECheMPS/E6KEu7VKYyfbirBXgfevPEEgTQU8EHk0rE7sQ7Qs02N3P
        n/a4lCo2syTcR543Jrv3pne9pPpnow6fZMRCsh79BHu4JOj2qeXN05/RHQwd5DDR
        PEDzVShp79Ly2uxnNC2zh8mLNvhqnVEhD9phLiuLIGUYjR2Mxy+FZKGVIYTrOrPJ
        hPC6PubEhSleu0etVYa+4lYa4KdQ2hYgAEQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8LeK3vMkzPkQ for <linux-ide@vger.kernel.org>;
        Wed,  8 Dec 2021 16:47:29 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J8b3P0kRHz1RtVG;
        Wed,  8 Dec 2021 16:47:28 -0800 (PST)
Message-ID: <3d231ef3-d233-071c-c49d-84d41ecd8599@opensource.wdc.com>
Date:   Thu, 9 Dec 2021 09:47:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 08/73] libata: drop DPRINTK() calls in reset
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-9-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211208163255.114660-9-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/09 1:31, Hannes Reinecke wrote:
> Reset is now logged with tracepoints, so the DPRINTK() calls can
> be dropped.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

This could be merged with the previous patch, no ? This way, a single patch
switch from old DPRINTK() to modern tracepoints.

> ---
>  drivers/ata/ahci.c           |  7 -------
>  drivers/ata/ahci_qoriq.c     |  4 ----
>  drivers/ata/libahci.c        | 10 ----------
>  drivers/ata/libata-core.c    |  4 ----
>  drivers/ata/libata-sff.c     | 11 +----------
>  drivers/ata/pata_octeon_cf.c |  2 --
>  drivers/ata/sata_fsl.c       | 10 ----------
>  drivers/ata/sata_rcar.c      |  4 ----
>  drivers/ata/sata_sil24.c     |  3 ---
>  9 files changed, 1 insertion(+), 54 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 5fa8a12c6b3b..6a867ef64c9c 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -699,8 +699,6 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
>  	bool online;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> -
>  	hpriv->stop_engine(ap);
>  
>  	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
> @@ -708,8 +706,6 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
>  
>  	hpriv->start_engine(ap);
>  
> -	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
> -
>  	/* vt8251 doesn't clear BSY on signature FIS reception,
>  	 * request follow-up softreset.
>  	 */
> @@ -789,8 +785,6 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
>  	bool online;
>  	int rc, i;
>  
> -	DPRINTK("ENTER\n");
> -
>  	hpriv->stop_engine(ap);
>  
>  	for (i = 0; i < 2; i++) {
> @@ -828,7 +822,6 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
>  	if (online)
>  		*class = ahci_dev_classify(ap);
>  
> -	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
>  	return rc;
>  }
>  
> diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
> index 5b46fc9aeb4a..bf5b388bd4e0 100644
> --- a/drivers/ata/ahci_qoriq.c
> +++ b/drivers/ata/ahci_qoriq.c
> @@ -103,8 +103,6 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
>  	int rc;
>  	bool ls1021a_workaround = (qoriq_priv->type == AHCI_LS1021A);
>  
> -	DPRINTK("ENTER\n");
> -
>  	hpriv->stop_engine(ap);
>  
>  	/*
> @@ -146,8 +144,6 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
>  
>  	if (online)
>  		*class = ahci_dev_classify(ap);
> -
> -	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
>  	return rc;
>  }
>  
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 21dbcd551443..ee7e63da0437 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1415,8 +1415,6 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
>  	bool fbs_disabled = false;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> -
>  	/* prepare for SRST (AHCI-1.1 10.4.1) */
>  	rc = ahci_kick_engine(ap);
>  	if (rc && rc != -EOPNOTSUPP)
> @@ -1476,7 +1474,6 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
>  	if (fbs_disabled)
>  		ahci_enable_fbs(ap);
>  
> -	DPRINTK("EXIT, class=%u\n", *class);
>  	return 0;
>  
>   fail:
> @@ -1498,8 +1495,6 @@ static int ahci_softreset(struct ata_link *link, unsigned int *class,
>  {
>  	int pmp = sata_srst_pmp(link);
>  
> -	DPRINTK("ENTER\n");
> -
>  	return ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
>  }
>  EXPORT_SYMBOL_GPL(ahci_do_softreset);
> @@ -1529,8 +1524,6 @@ static int ahci_pmp_retry_softreset(struct ata_link *link, unsigned int *class,
>  	int rc;
>  	u32 irq_sts;
>  
> -	DPRINTK("ENTER\n");
> -
>  	rc = ahci_do_softreset(link, class, pmp, deadline,
>  			       ahci_bad_pmp_check_ready);
>  
> @@ -1564,8 +1557,6 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
>  	struct ata_taskfile tf;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> -
>  	hpriv->stop_engine(ap);
>  
>  	/* clear D2H reception area to properly wait for D2H FIS */
> @@ -1581,7 +1572,6 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
>  	if (*online)
>  		*class = ahci_dev_classify(ap);
>  
> -	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(ahci_do_hardreset);
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 3977da2d098e..02cd8fe1acab 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3697,16 +3697,12 @@ void ata_std_postreset(struct ata_link *link, unsigned int *classes)
>  {
>  	u32 serror;
>  
> -	DPRINTK("ENTER\n");
> -
>  	/* reset complete, clear SError */
>  	if (!sata_scr_read(link, SCR_ERROR, &serror))
>  		sata_scr_write(link, SCR_ERROR, serror);
>  
>  	/* print link status */
>  	sata_print_link_status(link);
> -
> -	DPRINTK("EXIT\n");
>  }
>  EXPORT_SYMBOL_GPL(ata_std_postreset);
>  
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index a119fabe0919..4cc7c0606e06 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -1956,8 +1956,6 @@ static int ata_bus_softreset(struct ata_port *ap, unsigned int devmask,
>  {
>  	struct ata_ioports *ioaddr = &ap->ioaddr;
>  
> -	DPRINTK("ata%u: bus reset via SRST\n", ap->print_id);
> -
>  	if (ap->ioaddr.ctl_addr) {
>  		/* software reset.  causes dev0 to be selected */
>  		iowrite8(ap->ctl, ioaddr->ctl_addr);
> @@ -1995,8 +1993,6 @@ int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
>  	int rc;
>  	u8 err;
>  
> -	DPRINTK("ENTER\n");
> -
>  	/* determine if device 0/1 are present */
>  	if (ata_devchk(ap, 0))
>  		devmask |= (1 << 0);
> @@ -2007,7 +2003,6 @@ int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
>  	ap->ops->sff_dev_select(ap, 0);
>  
>  	/* issue bus reset */
> -	DPRINTK("about to softreset, devmask=%x\n", devmask);
>  	rc = ata_bus_softreset(ap, devmask, deadline);
>  	/* if link is occupied, -ENODEV too is an error */
>  	if (rc && (rc != -ENODEV || sata_scr_valid(link))) {
> @@ -2022,7 +2017,6 @@ int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
>  		classes[1] = ata_sff_dev_classify(&link->device[1],
>  						  devmask & (1 << 1), &err);
>  
> -	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(ata_sff_softreset);
> @@ -2055,7 +2049,6 @@ int sata_sff_hardreset(struct ata_link *link, unsigned int *class,
>  	if (online)
>  		*class = ata_sff_dev_classify(link->device, 1, NULL);
>  
> -	DPRINTK("EXIT, class=%u\n", *class);
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(sata_sff_hardreset);
> @@ -2085,10 +2078,8 @@ void ata_sff_postreset(struct ata_link *link, unsigned int *classes)
>  		ap->ops->sff_dev_select(ap, 0);
>  
>  	/* bail out if no device is present */
> -	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE) {
> -		DPRINTK("EXIT, no device\n");
> +	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE)
>  		return;
> -	}
>  
>  	/* set up device control */
>  	if (ap->ops->sff_set_devctl || ap->ioaddr.ctl_addr) {
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> index b5a3f710d76d..cdc95eb2b2cb 100644
> --- a/drivers/ata/pata_octeon_cf.c
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -440,7 +440,6 @@ static int octeon_cf_softreset16(struct ata_link *link, unsigned int *classes,
>  	int rc;
>  	u8 err;
>  
> -	DPRINTK("about to softreset\n");
>  	__raw_writew(ap->ctl, base + 0xe);
>  	udelay(20);
>  	__raw_writew(ap->ctl | ATA_SRST, base + 0xe);
> @@ -455,7 +454,6 @@ static int octeon_cf_softreset16(struct ata_link *link, unsigned int *classes,
>  
>  	/* determine by signature whether we have ATA or ATAPI devices */
>  	classes[0] = ata_sff_dev_classify(&link->device[0], 1, &err);
> -	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
>  	return 0;
>  }
>  
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index dbc57b7a58b8..5421625dcf6e 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -825,8 +825,6 @@ static int sata_fsl_hardreset(struct ata_link *link, unsigned int *class,
>  	int i = 0;
>  	unsigned long start_jiffies;
>  
> -	DPRINTK("in xx_hardreset\n");
> -
>  try_offline_again:
>  	/*
>  	 * Force host controller to go off-line, aborting current operations
> @@ -941,10 +939,7 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  	u8 *cfis;
>  	u32 Serror;
>  
> -	DPRINTK("in xx_softreset\n");
> -
>  	if (ata_link_offline(link)) {
> -		DPRINTK("PHY reports no device\n");
>  		*class = ATA_DEV_NONE;
>  		return 0;
>  	}
> @@ -957,8 +952,6 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  	 * reached here, we can send a command to the target device
>  	 */
>  
> -	DPRINTK("Sending SRST/device reset\n");
> -
>  	ata_tf_init(link->device, &tf);
>  	cfis = (u8 *) &pp->cmdentry->cfis;
>  
> @@ -1030,8 +1023,6 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  	 */
>  	iowrite32(0x01, CC + hcr_base);	/* We know it will be cmd#0 always */
>  
> -	DPRINTK("SATA FSL : Now checking device signature\n");
> -
>  	*class = ATA_DEV_NONE;
>  
>  	/* Verify if SStatus indicates device presence */
> @@ -1045,7 +1036,6 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  
>  		*class = sata_fsl_dev_classify(ap);
>  
> -		DPRINTK("class = %d\n", *class);
>  		VPRINTK("ccreg = 0x%x\n", ioread32(hcr_base + CC));
>  		VPRINTK("cereg = 0x%x\n", ioread32(hcr_base + CE));
>  	}
> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> index 44b0ed8f6bb8..9005833ab02f 100644
> --- a/drivers/ata/sata_rcar.c
> +++ b/drivers/ata/sata_rcar.c
> @@ -323,8 +323,6 @@ static int sata_rcar_bus_softreset(struct ata_port *ap, unsigned long deadline)
>  {
>  	struct ata_ioports *ioaddr = &ap->ioaddr;
>  
> -	DPRINTK("ata%u: bus reset via SRST\n", ap->print_id);
> -
>  	/* software reset.  causes dev0 to be selected */
>  	iowrite32(ap->ctl, ioaddr->ctl_addr);
>  	udelay(20);
> @@ -350,7 +348,6 @@ static int sata_rcar_softreset(struct ata_link *link, unsigned int *classes,
>  		devmask |= 1 << 0;
>  
>  	/* issue bus reset */
> -	DPRINTK("about to softreset, devmask=%x\n", devmask);
>  	rc = sata_rcar_bus_softreset(ap, deadline);
>  	/* if link is occupied, -ENODEV too is an error */
>  	if (rc && (rc != -ENODEV || sata_scr_valid(link))) {
> @@ -361,7 +358,6 @@ static int sata_rcar_softreset(struct ata_link *link, unsigned int *classes,
>  	/* determine by signature whether we have ATA or ATAPI devices */
>  	classes[0] = ata_sff_dev_classify(&link->device[0], devmask, &err);
>  
> -	DPRINTK("classes[0]=%u\n", classes[0]);
>  	return 0;
>  }
>  
> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
> index 7e9c1945dc81..2fef6ce93f07 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -656,8 +656,6 @@ static int sil24_softreset(struct ata_link *link, unsigned int *class,
>  	const char *reason;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> -
>  	/* put the port into known state */
>  	if (sil24_init_port(ap)) {
>  		reason = "port not ready";
> @@ -682,7 +680,6 @@ static int sil24_softreset(struct ata_link *link, unsigned int *class,
>  	sil24_read_tf(ap, 0, &tf);
>  	*class = ata_port_classify(ap, &tf);
>  
> -	DPRINTK("EXIT, class=%u\n", *class);
>  	return 0;
>  
>   err:
> 


-- 
Damien Le Moal
Western Digital Research
