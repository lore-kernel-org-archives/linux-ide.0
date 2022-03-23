Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D44C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 23 Mar 2022 14:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiCWOKw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 10:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbiCWOKv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 10:10:51 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85955EBE9
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 07:09:18 -0700 (PDT)
Received: from [192.168.0.7] (ip5f5ae903.dynamic.kabel-deutschland.de [95.90.233.3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 472F361E64846;
        Wed, 23 Mar 2022 15:09:15 +0100 (CET)
Message-ID: <c67343a7-ae8f-2460-665d-5dc5ee47db97@molgen.mpg.de>
Date:   Wed, 23 Mar 2022 15:09:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/4] ata: libata-sata: Introduce struct sata_deb_timing
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20220323081740.540006-1-damien.lemoal@opensource.wdc.com>
 <20220323081740.540006-3-damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220323081740.540006-3-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Dear Damien,


Am 23.03.22 um 09:17 schrieb Damien Le Moal:
> The SATA interval, duration and timeout debounce timing parameters
> (sata_deb_timing_normal, sata_deb_timing_hotplug and
> sata_deb_timing_long) are defined as an array of 3 unsigned long
> integers. The entries are referenced directly without any index macro
> indicating the name of the field being accessed.

> Introduce struct sata_deb_timing to more clearly define the values and
> their use. The interface of the sata_ehc_deb_timing(),
> sata_link_hardreset() and sata_link_debounce() functions is modified to
> take this new structure as argument.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   drivers/ata/ahci.c          |  7 +++---
>   drivers/ata/ahci_qoriq.c    |  5 ++--
>   drivers/ata/ahci_xgene.c    |  3 ++-
>   drivers/ata/libahci.c       |  5 ++--
>   drivers/ata/libata-core.c   |  5 ++--
>   drivers/ata/libata-pmp.c    |  2 +-
>   drivers/ata/libata-sata.c   | 47 ++++++++++++++++++++++++++-----------
>   drivers/ata/libata-sff.c    |  6 ++---
>   drivers/ata/sata_highbank.c |  4 ++--
>   drivers/ata/sata_mv.c       |  8 +++----
>   drivers/ata/sata_nv.c       |  2 +-
>   drivers/ata/sata_sil24.c    |  2 +-
>   include/linux/libata.h      | 38 +++++++++++++++++++-----------
>   13 files changed, 80 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 84456c05e845..ccf94e8a3056 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -787,7 +787,6 @@ static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
>   static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
>   			      unsigned long deadline)
>   {
> -	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
>   	struct ata_port *ap = link->ap;
>   	struct ahci_port_priv *pp = ap->private_data;
>   	struct ahci_host_priv *hpriv = ap->host->private_data;
> @@ -811,8 +810,10 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
>   		tf.status = ATA_BUSY;
>   		ata_tf_to_fis(&tf, 0, 0, d2h_fis);
>   
> -		rc = sata_link_hardreset(link, timing, deadline, &online,
> -				ahci_check_ready);
> +		rc = sata_link_hardreset(link,
> +					 sata_ehc_deb_timing(&link->eh_context),
> +					 deadline, &online,
> +					 ahci_check_ready);
>   
>   		if (sata_scr_read(link, SCR_STATUS, &sstatus) != 0 ||
>   				(sstatus & 0xf) != 1)
> diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
> index 6cd61842ad48..a5eeedadf0c9 100644
> --- a/drivers/ata/ahci_qoriq.c
> +++ b/drivers/ata/ahci_qoriq.c
> @@ -90,7 +90,6 @@ MODULE_DEVICE_TABLE(acpi, ahci_qoriq_acpi_match);
>   static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
>   			  unsigned long deadline)
>   {
> -	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
>   	void __iomem *port_mmio = ahci_port_base(link->ap);
>   	u32 px_cmd, px_is, px_val;
>   	struct ata_port *ap = link->ap;
> @@ -126,8 +125,8 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
>   	tf.status = ATA_BUSY;
>   	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
>   
> -	rc = sata_link_hardreset(link, timing, deadline, &online,
> -				 ahci_check_ready);
> +	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
> +				 deadline, &online, ahci_check_ready);
>   
>   	/* restore the PxCMD and PxIS on ls1021 */
>   	if (ls1021a_workaround) {
> diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
> index 7bb5db17f864..8d1598232e92 100644
> --- a/drivers/ata/ahci_xgene.c
> +++ b/drivers/ata/ahci_xgene.c
> @@ -350,7 +350,8 @@ static void xgene_ahci_set_phy_cfg(struct xgene_ahci_context *ctx, int channel)
>   static int xgene_ahci_do_hardreset(struct ata_link *link,
>   				   unsigned long deadline, bool *online)
>   {
> -	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
> +	const struct sata_deb_timing *timing =
> +		sata_ehc_deb_timing(&link->eh_context);
>   	struct ata_port *ap = link->ap;
>   	struct ahci_host_priv *hpriv = ap->host->private_data;
>   	struct xgene_ahci_context *ctx = hpriv->plat_data;
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index cf8c7fd59ada..0ac3b382fa52 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1549,7 +1549,6 @@ static int ahci_pmp_retry_softreset(struct ata_link *link, unsigned int *class,
>   int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
>   		      unsigned long deadline, bool *online)
>   {
> -	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
>   	struct ata_port *ap = link->ap;
>   	struct ahci_port_priv *pp = ap->private_data;
>   	struct ahci_host_priv *hpriv = ap->host->private_data;
> @@ -1564,8 +1563,8 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
>   	tf.status = ATA_BUSY;
>   	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
>   
> -	rc = sata_link_hardreset(link, timing, deadline, online,
> -				 ahci_check_ready);
> +	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
> +				 deadline, online, ahci_check_ready);
>   
>   	hpriv->start_engine(ap);
>   
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 1bdb6e78f0ed..ffad7c1afb64 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3616,12 +3616,13 @@ EXPORT_SYMBOL_GPL(ata_std_prereset);
>   int sata_std_hardreset(struct ata_link *link, unsigned int *class,
>   		       unsigned long deadline)
>   {
> -	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
>   	bool online;
>   	int rc;
>   
>   	/* do hardreset */
> -	rc = sata_link_hardreset(link, timing, deadline, &online, NULL);
> +	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
> +				 deadline, &online, NULL);
> +
>   	return online ? -EAGAIN : rc;
>   }
>   EXPORT_SYMBOL_GPL(sata_std_hardreset);
> diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
> index e2e9cbd405fa..1ea472ddbe3f 100644
> --- a/drivers/ata/libata-pmp.c
> +++ b/drivers/ata/libata-pmp.c
> @@ -851,7 +851,7 @@ static int sata_pmp_eh_handle_disabled_links(struct ata_port *ap)
>   		/* Some PMPs require hardreset sequence to get
>   		 * SError.N working.
>   		 */
> -		sata_link_hardreset(link, sata_deb_timing_normal,
> +		sata_link_hardreset(link, &sata_deb_timing_normal,
>   				ata_deadline(jiffies, ATA_TMOUT_INTERNAL_QUICK),
>   				NULL, NULL);
>   
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 86f1475e5bca..be46833d77a6 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -16,12 +16,31 @@
>   #include "libata.h"
>   #include "libata-transport.h"
>   
> -/* debounce timing parameters in msecs { interval, duration, timeout } */
> -const unsigned long sata_deb_timing_normal[]		= {   5,  100, 2000 };
> +/*
> + * Debounce timing parameters in msecs.
> + */
> +const struct sata_deb_timing sata_deb_timing_normal =
> +{
> +	.interval	= 5,

I find it always useful to append the unit to the variable name: 
`interval_ms`.


The rest looks good.


Kind regards,

Paul


> +	.duration	= 100,
> +	.timeout	= 2000
> +};
>   EXPORT_SYMBOL_GPL(sata_deb_timing_normal);
> -const unsigned long sata_deb_timing_hotplug[]		= {  25,  500, 2000 };
> +
> +const struct sata_deb_timing sata_deb_timing_hotplug =
> +{
> +	.interval	= 25,
> +	.duration	= 500,
> +	.timeout	= 2000
> +};
>   EXPORT_SYMBOL_GPL(sata_deb_timing_hotplug);
> -const unsigned long sata_deb_timing_long[]		= { 100, 2000, 5000 };
> +
> +const struct sata_deb_timing sata_deb_timing_long =
> +{
> +	.interval	= 100,
> +	.duration	= 2000,
> +	.timeout	= 5000
> +};
>   EXPORT_SYMBOL_GPL(sata_deb_timing_long);
>   
>   /**
> @@ -211,7 +230,7 @@ EXPORT_SYMBOL_GPL(ata_tf_from_fis);
>   /**
>    *	sata_link_debounce - debounce SATA phy status
>    *	@link: ATA link to debounce SATA phy status for
> - *	@params: timing parameters { interval, duration, timeout } in msec
> + *	@timing: debounce timing
>    *	@deadline: deadline jiffies for the operation
>    *
>    *	Make sure SStatus of @link reaches stable state, determined by
> @@ -230,16 +249,15 @@ EXPORT_SYMBOL_GPL(ata_tf_from_fis);
>    *	RETURNS:
>    *	0 on success, -errno on failure.
>    */
> -int sata_link_debounce(struct ata_link *link, const unsigned long *params,
> +int sata_link_debounce(struct ata_link *link,
> +		       const struct sata_deb_timing *timing,
>   		       unsigned long deadline)
>   {
> -	unsigned long interval = params[0];
> -	unsigned long duration = params[1];
>   	unsigned long last_jiffies, t;
>   	u32 last, cur;
>   	int rc;
>   
> -	t = ata_deadline(jiffies, params[2]);
> +	t = ata_deadline(jiffies, timing->timeout);
>   	if (time_before(t, deadline))
>   		deadline = t;
>   
> @@ -251,7 +269,7 @@ int sata_link_debounce(struct ata_link *link, const unsigned long *params,
>   	last_jiffies = jiffies;
>   
>   	while (1) {
> -		ata_msleep(link->ap, interval);
> +		ata_msleep(link->ap, timing->interval);
>   		if ((rc = sata_scr_read(link, SCR_STATUS, &cur)))
>   			return rc;
>   		cur &= 0xf;
> @@ -261,7 +279,7 @@ int sata_link_debounce(struct ata_link *link, const unsigned long *params,
>   			if (cur == 1 && time_before(jiffies, deadline))
>   				continue;
>   			if (time_after(jiffies,
> -				       ata_deadline(last_jiffies, duration)))
> +				ata_deadline(last_jiffies, timing->duration)))
>   				return 0;
>   			continue;
>   		}
> @@ -280,7 +298,7 @@ int sata_link_debounce(struct ata_link *link, const unsigned long *params,
>   EXPORT_SYMBOL_GPL(sata_link_debounce);
>   
>   static int __sata_link_resume(struct ata_link *link,
> -			      const unsigned long *timing,
> +			      const struct sata_deb_timing *timing,
>   			      unsigned long deadline)
>   {
>   	int tries = ATA_LINK_RESUME_TRIES;
> @@ -511,7 +529,7 @@ EXPORT_SYMBOL_GPL(sata_set_spd);
>   /**
>    *	sata_link_hardreset - reset link via SATA phy reset
>    *	@link: link to reset
> - *	@timing: timing parameters { interval, duration, timeout } in msec
> + *	@timing: debounce timing parameters
>    *	@deadline: deadline jiffies for the operation
>    *	@online: optional out parameter indicating link onlineness
>    *	@check_ready: optional callback to check link readiness
> @@ -532,7 +550,8 @@ EXPORT_SYMBOL_GPL(sata_set_spd);
>    *	RETURNS:
>    *	0 on success, -errno otherwise.
>    */
> -int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
> +int sata_link_hardreset(struct ata_link *link,
> +			const struct sata_deb_timing *timing,
>   			unsigned long deadline,
>   			bool *online, int (*check_ready)(struct ata_link *))
>   {
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index b3be7a8f5bea..ffd085b09abc 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -2030,13 +2030,11 @@ EXPORT_SYMBOL_GPL(ata_sff_softreset);
>   int sata_sff_hardreset(struct ata_link *link, unsigned int *class,
>   		       unsigned long deadline)
>   {
> -	struct ata_eh_context *ehc = &link->eh_context;
> -	const unsigned long *timing = sata_ehc_deb_timing(ehc);
>   	bool online;
>   	int rc;
>   
> -	rc = sata_link_hardreset(link, timing, deadline, &online,
> -				 ata_sff_check_ready);
> +	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
> +				 deadline, &online, ata_sff_check_ready);
>   	if (online)
>   		*class = ata_sff_dev_classify(link->device, 1, NULL);
>   
> diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
> index dfbf9493e451..16da571e8083 100644
> --- a/drivers/ata/sata_highbank.c
> +++ b/drivers/ata/sata_highbank.c
> @@ -385,7 +385,7 @@ static int highbank_initialize_phys(struct device *dev, void __iomem *addr)
>   static int ahci_highbank_hardreset(struct ata_link *link, unsigned int *class,
>   				unsigned long deadline)
>   {
> -	static const unsigned long timing[] = { 5, 100, 500};
> +	const struct sata_deb_timing timing = { 5, 100, 500};
>   	struct ata_port *ap = link->ap;
>   	struct ahci_port_priv *pp = ap->private_data;
>   	struct ahci_host_priv *hpriv = ap->host->private_data;
> @@ -405,7 +405,7 @@ static int ahci_highbank_hardreset(struct ata_link *link, unsigned int *class,
>   
>   	do {
>   		highbank_cphy_disable_overrides(link->ap->port_no);
> -		rc = sata_link_hardreset(link, timing, deadline, &online, NULL);
> +		rc = sata_link_hardreset(link, &timing, deadline, &online, NULL);
>   		highbank_cphy_override_lane(link->ap->port_no);
>   
>   		/* If the status is 1, we are connected, but the link did not
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index de5bd02cad44..8ad0f3776c48 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -3633,11 +3633,9 @@ static int mv_hardreset(struct ata_link *link, unsigned int *class,
>   
>   	/* Workaround for errata FEr SATA#10 (part 2) */
>   	do {
> -		const unsigned long *timing =
> -				sata_ehc_deb_timing(&link->eh_context);
> -
> -		rc = sata_link_hardreset(link, timing, deadline + extra,
> -					 &online, NULL);
> +		rc = sata_link_hardreset(link,
> +					 sata_ehc_deb_timing(&link->eh_context),
> +					 deadline + extra, &online, NULL);
>   		rc = online ? -EAGAIN : rc;
>   		if (rc)
>   			return rc;
> diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
> index b5f27eac86b1..5c8db8f8c47f 100644
> --- a/drivers/ata/sata_nv.c
> +++ b/drivers/ata/sata_nv.c
> @@ -1526,7 +1526,7 @@ static int nv_hardreset(struct ata_link *link, unsigned int *class,
>   	 */
>   	if (!(link->ap->pflags & ATA_PFLAG_LOADING) &&
>   	    !ata_dev_enabled(link->device))
> -		sata_link_hardreset(link, sata_deb_timing_hotplug, deadline,
> +		sata_link_hardreset(link, &sata_deb_timing_hotplug, deadline,
>   				    NULL, NULL);
>   	else {
>   		int rc;
> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
> index 2fef6ce93f07..4c4ff67bf06a 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -735,7 +735,7 @@ static int sil24_hardreset(struct ata_link *link, unsigned int *class,
>   	/* SStatus oscillates between zero and valid status after
>   	 * DEV_RST, debounce it.
>   	 */
> -	rc = sata_link_debounce(link, sata_deb_timing_long, deadline);
> +	rc = sata_link_debounce(link, &sata_deb_timing_long, deadline);
>   	if (rc) {
>   		reason = "PHY debouncing failed";
>   		goto err;
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index e89d612326f6..166263d9bbc7 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1150,17 +1150,26 @@ extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *
>    * SATA specific code - drivers/ata/libata-sata.c
>    */
>   #ifdef CONFIG_SATA_HOST
> -extern const unsigned long sata_deb_timing_normal[];
> -extern const unsigned long sata_deb_timing_hotplug[];
> -extern const unsigned long sata_deb_timing_long[];
>   
> -static inline const unsigned long *
> +/*
> + * Debounce timing parameters in msecs.
> + */
> +struct sata_deb_timing {
> +	unsigned long interval;
> +	unsigned long duration;
> +	unsigned long timeout;
> +};
> +
> +extern const struct sata_deb_timing sata_deb_timing_normal;
> +extern const struct sata_deb_timing sata_deb_timing_hotplug;
> +extern const struct sata_deb_timing sata_deb_timing_long;
> +
> +static inline const struct sata_deb_timing *
>   sata_ehc_deb_timing(struct ata_eh_context *ehc)
>   {
>   	if (ehc->i.flags & ATA_EHI_HOTPLUGGED)
> -		return sata_deb_timing_hotplug;
> -	else
> -		return sata_deb_timing_normal;
> +		return &sata_deb_timing_hotplug;
> +	return &sata_deb_timing_normal;
>   }
>   
>   extern int sata_scr_valid(struct ata_link *link);
> @@ -1169,12 +1178,13 @@ extern int sata_scr_write(struct ata_link *link, int reg, u32 val);
>   extern int sata_scr_write_flush(struct ata_link *link, int reg, u32 val);
>   extern int sata_set_spd(struct ata_link *link);
>   extern int sata_link_hardreset(struct ata_link *link,
> -			const unsigned long *timing, unsigned long deadline,
> -			bool *online, int (*check_ready)(struct ata_link *));
> +			       const struct sata_deb_timing *timing,
> +			       unsigned long deadline, bool *online,
> +			       int (*check_ready)(struct ata_link *));
>   extern int sata_link_resume(struct ata_link *link, unsigned long deadline);
>   extern void ata_eh_analyze_ncq_error(struct ata_link *link);
>   #else
> -static inline const unsigned long *
> +static inline const struct sata_deb_timing *
>   sata_ehc_deb_timing(struct ata_eh_context *ehc)
>   {
>   	return NULL;
> @@ -1194,9 +1204,8 @@ static inline int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)
>   }
>   static inline int sata_set_spd(struct ata_link *link) { return -EOPNOTSUPP; }
>   static inline int sata_link_hardreset(struct ata_link *link,
> -				      const unsigned long *timing,
> -				      unsigned long deadline,
> -				      bool *online,
> +				      const struct sata_deb_timing *timing,
> +				      unsigned long deadline, bool *online,
>   				      int (*check_ready)(struct ata_link *))
>   {
>   	if (online)
> @@ -1211,7 +1220,8 @@ static inline int sata_link_resume(struct ata_link *link,
>   static inline void ata_eh_analyze_ncq_error(struct ata_link *link) { }
>   #endif
>   extern int sata_link_debounce(struct ata_link *link,
> -			const unsigned long *params, unsigned long deadline);
> +			      const struct sata_deb_timing *timing,
> +			      unsigned long deadline);
>   extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>   			     bool spm_wakeup);
>   extern int ata_slave_link_init(struct ata_port *ap);
