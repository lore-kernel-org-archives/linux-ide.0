Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5E6C433FE
	for <linux-ide@archiver.kernel.org>; Fri,  7 Oct 2022 22:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJGWbJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Oct 2022 18:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiJGWbI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Oct 2022 18:31:08 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8449BDFB74
        for <linux-ide@vger.kernel.org>; Fri,  7 Oct 2022 15:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665181864; x=1696717864;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UB39JjukNPhvRAztbQBWPABE6u3Z5axCKGG117qzrnM=;
  b=UX6BWm0n/TBndPSd1fPR08N+nzO5Gdb8GkuwSZ4vv4Ai3OaIHE3AOMk8
   UgX2kI0W9lzz1m9UvbNTn0VAcYcNB5Efvp3fsvceMNSWBM9oIDLc+hV6f
   yeDmBqeuxJAPHNMEB5NdwTpGBzxAD2MJ0U9OjBLQxTNWdx2+kfYnKfuyG
   3+JPcQf8Zl+5c+TzjoPgre6T/vI5h6iX5sKkT153urwxNIzsvKCatey0z
   WlQ4ef4oxbBJ4eqw5GIuTyDRnBwJ66GM+tCL7lbJFkXGtE2MWeMa1ai7w
   F8txC0kPF4rwDp2JAgPWWMh/ybfrf3B6nyPFYbxB1ot04wYKFMl6rrzP5
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,168,1661788800"; 
   d="scan'208";a="211609766"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Oct 2022 06:31:03 +0800
IronPort-SDR: FP6DuZtzenQnP2eeX0zwgOb/7/2nqulIXI6scKIV8xQeg9ql2rIbMxOjDiHQPa+tabTFMI/RkN
 wOP+B9wxwqkAoLAXeEnLT6lDbdh+SQjzY5gQjh6NcQJYWR90MyaEiJUO1++lPkD48hKVcexwYQ
 gzXv7RMUUvUBaNFXFkiqDT/8+CKt6Q29DluCT23t0arQ1mZs629L4wmHxlVyBB89vjrw0k5ume
 Y8Oh9y4st5GcNFYpnTXN0PP2gktl+YzZoBnFyct7C/Pn0jKohxG8YTzsd+rdjKEa8VuvO7dqP2
 pyvocqpiRUA7FyvriTuzgmdO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2022 14:50:47 -0700
IronPort-SDR: WnJS9m2ZUDsxeITAB360b/jmKinUxrthinG8HkvmBKwan+xrSlt8jvG0WOFeCYDiMItRS9v0DQ
 k3svG7QYlEQGdEC1wArbscXoRU0ikFqmsf55kQKq+7Nckgjlnwhl7bUYASc78t3XHKLUlaJ0UN
 aW45gNQUbn+RhkqZvCgVf8wF/hZqW+CHDwqLtkdEzhIIjdn71otzwkV02gdj+LeeXLQZTHA6e9
 kRM4KFFZBm+BQr6ClkDWQTcmoBLPpag5wH7fMwXGx1UWwBHeCg0AR2AW6ax0GKiXANhdGB5ibV
 dpM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2022 15:31:03 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mkjh70xl2z1RwqL
        for <linux-ide@vger.kernel.org>; Fri,  7 Oct 2022 15:31:03 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665181862; x=1667773863; bh=UB39JjukNPhvRAztbQBWPABE6u3Z5axCKGG
        117qzrnM=; b=YozXPp3L0LOe9b7FaTQb/HxFAYZaM54Qi7FCa5aNQ/jhCBbMgjx
        tTolDsV8Ow+EOxnJ/YBynVWQgNcm+PJnqaEkZfjakZHDENTipepyvQTytaIKt//U
        oCv3EY6BgxyQKT5T/5BPV1sHgyYtGKfHWIGYdSgIsqPXhCHK4yXJrmlXVVKys02n
        DuAkBoGXgnl7jwNG0RRHoKBw7dJ7tceTRbZBvDKk2mO/G+qSLonh6VQ8sLf/WJCm
        /VljOuacoF82rT01MAL2yCHhdAZWxX8aEE3WUdvz6gyTgn+5HYUQPY2BaP3R2Ll2
        YTVDDxYvTuQelJ57LakCiUtRxk3Jd3oj8Hw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9q5RezoHl7Yd for <linux-ide@vger.kernel.org>;
        Fri,  7 Oct 2022 15:31:02 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mkjh54htQz1RvLy;
        Fri,  7 Oct 2022 15:31:01 -0700 (PDT)
Message-ID: <dac5c025-1f77-9972-977d-cb3d22023db4@opensource.wdc.com>
Date:   Sat, 8 Oct 2022 07:31:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/4] ata: make use of ata_port_is_frozen() helper
Content-Language: en-US
To:     Niklas Cassel <niklas.cassel@wdc.com>,
        Mikael Pettersson <mikpelinux@gmail.com>
Cc:     john.garry@huawei.com, linux-ide@vger.kernel.org
References: <20221007132342.1590367-1-niklas.cassel@wdc.com>
 <20221007132342.1590367-3-niklas.cassel@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221007132342.1590367-3-niklas.cassel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/7/22 22:23, Niklas Cassel wrote:
> Clean up the code by making use of the newly introduced
> ata_port_is_frozen() helper function.

Looks good, but I think this should be squashed with patch 1.

> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  drivers/ata/libahci.c      |  6 +++---
>  drivers/ata/libata-acpi.c  |  4 ++--
>  drivers/ata/libata-core.c  |  4 ++--
>  drivers/ata/libata-eh.c    | 21 ++++++++++-----------
>  drivers/ata/libata-sata.c  |  2 +-
>  drivers/ata/libata-scsi.c  |  2 +-
>  drivers/ata/sata_nv.c      |  2 +-
>  drivers/ata/sata_promise.c |  2 +-
>  drivers/ata/sata_sx4.c     |  2 +-
>  9 files changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 954386a2b500..399feb09d1ba 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -2106,7 +2106,7 @@ void ahci_error_handler(struct ata_port *ap)
>  {
>  	struct ahci_host_priv *hpriv = ap->host->private_data;
>  
> -	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
> +	if (!ata_port_is_frozen(ap)) {
>  		/* restart engine */
>  		hpriv->stop_engine(ap);
>  		hpriv->start_engine(ap);
> @@ -2297,7 +2297,7 @@ static void ahci_pmp_attach(struct ata_port *ap)
>  	 * Note that during initialization, the port is marked as
>  	 * frozen since the irq handler is not yet registered.
>  	 */
> -	if (!(ap->pflags & ATA_PFLAG_FROZEN))
> +	if (!ata_port_is_frozen(ap))
>  		writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
>  }
>  
> @@ -2316,7 +2316,7 @@ static void ahci_pmp_detach(struct ata_port *ap)
>  	pp->intr_mask &= ~PORT_IRQ_BAD_PMP;
>  
>  	/* see comment above in ahci_pmp_attach() */
> -	if (!(ap->pflags & ATA_PFLAG_FROZEN))
> +	if (!ata_port_is_frozen(ap))
>  		writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
>  }
>  
> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
> index 61b4ccf88bf1..d36e71f475ab 100644
> --- a/drivers/ata/libata-acpi.c
> +++ b/drivers/ata/libata-acpi.c
> @@ -992,7 +992,7 @@ int ata_acpi_on_devcfg(struct ata_device *dev)
>  
>   acpi_err:
>  	/* ignore evaluation failure if we can continue safely */
> -	if (rc == -EINVAL && !nr_executed && !(ap->pflags & ATA_PFLAG_FROZEN))
> +	if (rc == -EINVAL && !nr_executed && !ata_port_is_frozen(ap))
>  		return 0;
>  
>  	/* fail and let EH retry once more for unknown IO errors */
> @@ -1007,7 +1007,7 @@ int ata_acpi_on_devcfg(struct ata_device *dev)
>  	/* We can safely continue if no _GTF command has been executed
>  	 * and port is not frozen.
>  	 */
> -	if (!nr_executed && !(ap->pflags & ATA_PFLAG_FROZEN))
> +	if (!nr_executed && !ata_port_is_frozen(ap))
>  		return 0;
>  
>  	return rc;
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 75b86913db1a..1cf326dd7c41 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1489,7 +1489,7 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
>  	spin_lock_irqsave(ap->lock, flags);
>  
>  	/* no internal command while frozen */
> -	if (ap->pflags & ATA_PFLAG_FROZEN) {
> +	if (ata_port_is_frozen(ap)) {
>  		spin_unlock_irqrestore(ap->lock, flags);
>  		return AC_ERR_SYSTEM;
>  	}
> @@ -4717,7 +4717,7 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
>  			return;
>  		}
>  
> -		WARN_ON_ONCE(ap->pflags & ATA_PFLAG_FROZEN);
> +		WARN_ON_ONCE(ata_port_is_frozen(ap));
>  
>  		/* read result TF if requested */
>  		if (qc->flags & ATA_QCFLAG_RESULT_TF)
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 1b82283f4b49..00181e747932 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1406,7 +1406,7 @@ static void ata_eh_request_sense(struct ata_queued_cmd *qc)
>  	struct ata_taskfile tf;
>  	unsigned int err_mask;
>  
> -	if (qc->ap->pflags & ATA_PFLAG_FROZEN) {
> +	if (ata_port_is_frozen(qc->ap)) {
>  		ata_dev_warn(dev, "sense data available but port frozen\n");
>  		return;
>  	}
> @@ -1588,7 +1588,7 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc)
>  		break;
>  
>  	case ATA_DEV_ATAPI:
> -		if (!(qc->ap->pflags & ATA_PFLAG_FROZEN)) {
> +		if (!ata_port_is_frozen(qc->ap)) {
>  			tmp = atapi_eh_request_sense(qc->dev,
>  						qc->scsicmd->sense_buffer,
>  						qc->result_tf.error >> 4);
> @@ -1995,7 +1995,7 @@ static void ata_eh_link_autopsy(struct ata_link *link)
>  		ehc->i.flags |= ATA_EHI_QUIET;
>  
>  	/* enforce default EH actions */
> -	if (ap->pflags & ATA_PFLAG_FROZEN ||
> +	if (ata_port_is_frozen(ap) ||
>  	    all_err_mask & (AC_ERR_HSM | AC_ERR_TIMEOUT))
>  		ehc->i.action |= ATA_EH_RESET;
>  	else if (((eflags & ATA_EFLAG_IS_IO) && all_err_mask) ||
> @@ -2237,7 +2237,7 @@ static void ata_eh_link_report(struct ata_link *link)
>  		return;
>  
>  	frozen = "";
> -	if (ap->pflags & ATA_PFLAG_FROZEN)
> +	if (ata_port_is_frozen(ap))
>  		frozen = " frozen";
>  
>  	if (ap->eh_tries < ATA_EH_MAX_TRIES)
> @@ -2558,8 +2558,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
>  		if (reset && !(ehc->i.action & ATA_EH_RESET)) {
>  			ata_for_each_dev(dev, link, ALL)
>  				classes[dev->devno] = ATA_DEV_NONE;
> -			if ((ap->pflags & ATA_PFLAG_FROZEN) &&
> -			    ata_is_host_link(link))
> +			if (ata_port_is_frozen(ap) && ata_is_host_link(link))
>  				ata_eh_thaw_port(ap);
>  			rc = 0;
>  			goto out;
> @@ -2717,7 +2716,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
>  	ap->pflags &= ~ATA_PFLAG_EH_PENDING;
>  	spin_unlock_irqrestore(link->ap->lock, flags);
>  
> -	if (ap->pflags & ATA_PFLAG_FROZEN)
> +	if (ata_port_is_frozen(ap))
>  		ata_eh_thaw_port(ap);
>  
>  	/*
> @@ -3224,7 +3223,7 @@ static int ata_eh_maybe_retry_flush(struct ata_device *dev)
>  		if (err_mask & AC_ERR_DEV) {
>  			qc->err_mask |= AC_ERR_DEV;
>  			qc->result_tf = tf;
> -			if (!(ap->pflags & ATA_PFLAG_FROZEN))
> +			if (!ata_port_is_frozen(ap))
>  				rc = 0;
>  		}
>  	}
> @@ -3401,7 +3400,7 @@ static int ata_eh_skip_recovery(struct ata_link *link)
>  		return 1;
>  
>  	/* thaw frozen port and recover failed devices */
> -	if ((ap->pflags & ATA_PFLAG_FROZEN) || ata_link_nr_enabled(link))
> +	if (ata_port_is_frozen(ap) || ata_link_nr_enabled(link))
>  		return 0;
>  
>  	/* reset at least once if reset is requested */
> @@ -3756,7 +3755,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
>  		if (dev)
>  			ata_eh_handle_dev_fail(dev, rc);
>  
> -		if (ap->pflags & ATA_PFLAG_FROZEN) {
> +		if (ata_port_is_frozen(ap)) {
>  			/* PMP reset requires working host port.
>  			 * Can't retry if it's frozen.
>  			 */
> @@ -3930,7 +3929,7 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
>  	ap->pflags &= ~ATA_PFLAG_PM_PENDING;
>  	if (rc == 0)
>  		ap->pflags |= ATA_PFLAG_SUSPENDED;
> -	else if (ap->pflags & ATA_PFLAG_FROZEN)
> +	else if (ata_port_is_frozen(ap))
>  		ata_port_schedule_eh(ap);
>  
>  	spin_unlock_irqrestore(ap->lock, flags);
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index eef57d101ed1..60009ac03a8f 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1420,7 +1420,7 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
>  	int tag, rc;
>  
>  	/* if frozen, we can't do much */
> -	if (ap->pflags & ATA_PFLAG_FROZEN)
> +	if (ata_port_is_frozen(ap))
>  		return;
>  
>  	/* is it NCQ device error? */
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index f3c64e796423..ccacaa5db936 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -642,7 +642,7 @@ static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
>  	struct ata_queued_cmd *qc;
>  	int tag;
>  
> -	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
> +	if (unlikely(ata_port_is_frozen(ap)))
>  		goto fail;
>  
>  	if (ap->flags & ATA_FLAG_SAS_HOST) {
> diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
> index 7f14d0d31057..9b2d289e89e1 100644
> --- a/drivers/ata/sata_nv.c
> +++ b/drivers/ata/sata_nv.c
> @@ -2185,7 +2185,7 @@ static void nv_swncq_host_interrupt(struct ata_port *ap, u16 fis)
>  	if (!fis)
>  		return;
>  
> -	if (ap->pflags & ATA_PFLAG_FROZEN)
> +	if (ata_port_is_frozen(ap))
>  		return;
>  
>  	if (fis & NV_SWNCQ_IRQ_HOTPLUG) {
> diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
> index b8465fef2ed2..9cd7d8b71361 100644
> --- a/drivers/ata/sata_promise.c
> +++ b/drivers/ata/sata_promise.c
> @@ -817,7 +817,7 @@ static int pdc_sata_hardreset(struct ata_link *link, unsigned int *class,
>  
>  static void pdc_error_handler(struct ata_port *ap)
>  {
> -	if (!(ap->pflags & ATA_PFLAG_FROZEN))
> +	if (!ata_port_is_frozen(ap))
>  		pdc_reset_port(ap);
>  
>  	ata_sff_error_handler(ap);
> diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
> index 6ceec59cb291..ab70cbc78f96 100644
> --- a/drivers/ata/sata_sx4.c
> +++ b/drivers/ata/sata_sx4.c
> @@ -855,7 +855,7 @@ static int pdc_softreset(struct ata_link *link, unsigned int *class,
>  
>  static void pdc_error_handler(struct ata_port *ap)
>  {
> -	if (!(ap->pflags & ATA_PFLAG_FROZEN))
> +	if (!ata_port_is_frozen(ap))
>  		pdc_reset_port(ap);
>  
>  	ata_sff_error_handler(ap);

-- 
Damien Le Moal
Western Digital Research

