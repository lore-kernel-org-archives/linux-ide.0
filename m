Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA59C433F5
	for <linux-ide@archiver.kernel.org>; Wed, 23 Mar 2022 14:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244678AbiCWO0d (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 10:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244668AbiCWO0d (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 10:26:33 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D486DEE7
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 07:25:02 -0700 (PDT)
Received: from [192.168.0.7] (ip5f5ae903.dynamic.kabel-deutschland.de [95.90.233.3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D327161E6478B;
        Wed, 23 Mar 2022 15:25:00 +0100 (CET)
Message-ID: <e9dbac4a-4612-9a3f-ddb4-ee3625510b77@molgen.mpg.de>
Date:   Wed, 23 Mar 2022 15:25:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/4] ata: libata-sata: Remove debounce delay by default
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20220323081740.540006-1-damien.lemoal@opensource.wdc.com>
 <20220323081740.540006-4-damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220323081740.540006-4-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org



Am 23.03.22 um 09:17 schrieb Damien Le Moal:
> Many adapters and SATA controllers are fine with accesses to the
> SControl register right after resuming. For these adapters, the
> additional 200ms delay implemented in sata_link_resume() is redundant
> and unnecessarily increase boot time.

increase*s*

> Drivers can opt out from this additional delay using the
> ATA_LFLAG_NO_DEBOUNCE_DELAY link flag, but by default, this additional
> delay exists for all adapters.
> 
> Reverse the situation and do not add by default this 200ms delay. For
> adapters that actually need this delay, rename the
> ATA_LFLAG_NO_DEBOUNCE_DELAY link flag to ATA_LFLAG_DEBOUNCE_DELAY and
> execute the 200ms delay in sata_link_resume() only if a driver request
> it using the new link flag. Otherwise, arbitrarily delay by 1ms only.
> 
> Since ata_piix adapters are known to require the longer delay, specify

Was it 200 ms or some delay, they require?

> the ATA_LFLAG_DEBOUNCE_DELAY for all adapters supported by the ata_piix
> driver.

Maybe also add a reference to the archeology [1] I once did.

> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   drivers/ata/ahci.c        | 12 ++----------
>   drivers/ata/ahci_brcm.c   |  1 -
>   drivers/ata/ata_generic.c |  1 +
>   drivers/ata/ata_piix.c    | 17 +++++++++++++++++
>   drivers/ata/libata-sata.c | 18 +++++++++++-------
>   include/linux/libata.h    |  2 +-
>   6 files changed, 32 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index ccf94e8a3056..ac1e227a07cd 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -51,7 +51,6 @@ enum board_ids {
>   	board_ahci,
>   	board_ahci_ign_iferr,
>   	board_ahci_low_power,
> -	board_ahci_no_debounce_delay,
>   	board_ahci_nomsi,
>   	board_ahci_noncq,
>   	board_ahci_nosntf,
> @@ -142,13 +141,6 @@ static const struct ata_port_info ahci_port_info[] = {
>   		.udma_mask	= ATA_UDMA6,
>   		.port_ops	= &ahci_ops,
>   	},
> -	[board_ahci_no_debounce_delay] = {
> -		.flags		= AHCI_FLAG_COMMON,
> -		.link_flags	= ATA_LFLAG_NO_DEBOUNCE_DELAY,
> -		.pio_mask	= ATA_PIO4,
> -		.udma_mask	= ATA_UDMA6,
> -		.port_ops	= &ahci_ops,
> -	},
>   	[board_ahci_nomsi] = {
>   		AHCI_HFLAGS	(AHCI_HFLAG_NO_MSI),
>   		.flags		= AHCI_FLAG_COMMON,
> @@ -445,7 +437,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>   		board_ahci_al },
>   	/* AMD */
>   	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
> -	{ PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD Hudson-2 (AHCI mode) */
> +	{ PCI_VDEVICE(AMD, 0x7801), board_ahci }, /* AMD Hudson-2 (AHCI mode) */
>   	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>   	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_low_power }, /* AMD Green Sardine */
>   	/* AMD is using RAID class only for ahci controllers */
> @@ -583,7 +575,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>   	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
>   	  .driver_data = board_ahci_yes_fbs },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9235),
> -	  .driver_data = board_ahci_no_debounce_delay },
> +	  .driver_data = board_ahci },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642), /* highpoint rocketraid 642L */
>   	  .driver_data = board_ahci_yes_fbs },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0645), /* highpoint rocketraid 644L */
> diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> index ab8552b1ff2a..e4584aed0ded 100644
> --- a/drivers/ata/ahci_brcm.c
> +++ b/drivers/ata/ahci_brcm.c
> @@ -333,7 +333,6 @@ static struct ata_port_operations ahci_brcm_platform_ops = {
>   
>   static const struct ata_port_info ahci_brcm_port_info = {
>   	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
> -	.link_flags	= ATA_LFLAG_NO_DEBOUNCE_DELAY,
>   	.pio_mask	= ATA_PIO4,
>   	.udma_mask	= ATA_UDMA6,
>   	.port_ops	= &ahci_brcm_platform_ops,
> diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
> index 20a32e4d501d..f02c824b26e6 100644
> --- a/drivers/ata/ata_generic.c
> +++ b/drivers/ata/ata_generic.c
> @@ -165,6 +165,7 @@ static int ata_generic_init_one(struct pci_dev *dev, const struct pci_device_id
>   	u16 command;
>   	static const struct ata_port_info info = {
>   		.flags = ATA_FLAG_SLAVE_POSS,
> +		.link_flags = ATA_LFLAG_DEBOUNCE_DELAY,
>   		.pio_mask = ATA_PIO4,
>   		.mwdma_mask = ATA_MWDMA2,
>   		.udma_mask = ATA_UDMA5,
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index ade5e894563b..dcfcfb5d8a05 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -1112,6 +1112,7 @@ static struct ata_port_info piix_port_info[] = {
>   	[piix_pata_mwdma] =	/* PIIX3 MWDMA only */
>   	{
>   		.flags		= PIIX_PATA_FLAGS,
> +		.link_flags	= ATA_LFLAG_DEBOUNCE_DELAY,
>   		.pio_mask	= ATA_PIO4,
>   		.mwdma_mask	= ATA_MWDMA12_ONLY, /* mwdma1-2 ?? CHECK 0 should be ok but slow */
>   		.port_ops	= &piix_pata_ops,
> @@ -1120,6 +1121,7 @@ static struct ata_port_info piix_port_info[] = {
>   	[piix_pata_33] =	/* PIIX4 at 33MHz */
>   	{
>   		.flags		= PIIX_PATA_FLAGS,
> +		.link_flags	= ATA_LFLAG_DEBOUNCE_DELAY,
>   		.pio_mask	= ATA_PIO4,
>   		.mwdma_mask	= ATA_MWDMA12_ONLY, /* mwdma1-2 ?? CHECK 0 should be ok but slow */
>   		.udma_mask	= ATA_UDMA2,
> @@ -1129,6 +1131,7 @@ static struct ata_port_info piix_port_info[] = {
>   	[ich_pata_33] =		/* ICH0 - ICH at 33Mhz*/
>   	{
>   		.flags		= PIIX_PATA_FLAGS,
> +		.link_flags	= ATA_LFLAG_DEBOUNCE_DELAY,
>   		.pio_mask	= ATA_PIO4,
>   		.mwdma_mask	= ATA_MWDMA12_ONLY, /* Check: maybe MWDMA0 is ok  */
>   		.udma_mask	= ATA_UDMA2,
> @@ -1138,6 +1141,7 @@ static struct ata_port_info piix_port_info[] = {
>   	[ich_pata_66] =		/* ICH controllers up to 66MHz */
>   	{
>   		.flags		= PIIX_PATA_FLAGS,
> +		.link_flags	= ATA_LFLAG_DEBOUNCE_DELAY,
>   		.pio_mask	= ATA_PIO4,
>   		.mwdma_mask	= ATA_MWDMA12_ONLY, /* MWDMA0 is broken on chip */
>   		.udma_mask	= ATA_UDMA4,
> @@ -1147,6 +1151,7 @@ static struct ata_port_info piix_port_info[] = {
>   	[ich_pata_100] =
>   	{
>   		.flags		= PIIX_PATA_FLAGS | PIIX_FLAG_CHECKINTR,
> +		.link_flags	= ATA_LFLAG_DEBOUNCE_DELAY,
>   		.pio_mask	= ATA_PIO4,
>   		.mwdma_mask	= ATA_MWDMA12_ONLY,
>   		.udma_mask	= ATA_UDMA5,
> @@ -1156,6 +1161,7 @@ static struct ata_port_info piix_port_info[] = {
>   	[ich_pata_100_nomwdma1] =
>   	{
>   		.flags		= PIIX_PATA_FLAGS | PIIX_FLAG_CHECKINTR,
> +		.link_flags	= ATA_LFLAG_DEBOUNCE_DELAY,
>   		.pio_mask	= ATA_PIO4,
>   		.mwdma_mask	= ATA_MWDMA2_ONLY,
>   		.udma_mask	= ATA_UDMA5,
> @@ -1165,6 +1171,7 @@ static struct ata_port_info piix_port_info[] = {
>   	[ich5_sata] =
>   	{
>   		.flags		= PIIX_SATA_FLAGS,
> +		.link_flags	= ATA_LFLAG_DEBOUNCE_DELAY,
>   		.pio_mask	= ATA_PIO4,
>   		.mwdma_mask	= ATA_MWDMA2,
>   		.udma_mask	= ATA_UDMA6,
> @@ -1174,6 +1181,7 @@ static struct ata_port_info piix_port_info[] = {
>   	[ich6_sata] =
>   	{
>   		.flags		= PIIX_SATA_FLAGS,
> +		.link_flags	= ATA_LFLAG_DEBOUNCE_DELAY,
>   		.pio_mask	= ATA_PIO4,
>   		.mwdma_mask	= ATA_MWDMA2,
>   		.udma_mask	= ATA_UDMA6,
> @@ -1183,6 +1191,7 @@ static struct ata_port_info piix_port_info[] = {
>   	[ich6m_sata] =
>   	{
>   		.flags		= PIIX_SATA_FLAGS,
> +		.link_flags	= ATA_LFLAG_DEBOUNCE_DELAY,
>   		.pio_mask	= ATA_PIO4,
>   		.mwdma_mask	= ATA_MWDMA2,
>   		.udma_mask	= ATA_UDMA6,
> @@ -1192,6 +1201,7 @@ static struct ata_port_info piix_port_info[] = {
>   	[ich8_sata] =
>   	{
>   		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SIDPR,
> +		.link_flags	= ATA_LFLAG_DEBOUNCE_DELAY,
>   		.pio_mask	= ATA_PIO4,
>   		.mwdma_mask	= ATA_MWDMA2,
>   		.udma_mask	= ATA_UDMA6,
> @@ -1201,6 +1211,7 @@ static struct ata_port_info piix_port_info[] = {
>   	[ich8_2port_sata] =
>   	{
>   		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SIDPR,
> +		.link_flags	= ATA_LFLAG_DEBOUNCE_DELAY,
>   		.pio_mask	= ATA_PIO4,
>   		.mwdma_mask	= ATA_MWDMA2,
>   		.udma_mask	= ATA_UDMA6,
> @@ -1210,6 +1221,7 @@ static struct ata_port_info piix_port_info[] = {
>   	[tolapai_sata] =
>   	{
>   		.flags		= PIIX_SATA_FLAGS,
> +		.link_flags	= ATA_LFLAG_DEBOUNCE_DELAY,
>   		.pio_mask	= ATA_PIO4,
>   		.mwdma_mask	= ATA_MWDMA2,
>   		.udma_mask	= ATA_UDMA6,
> @@ -1219,6 +1231,7 @@ static struct ata_port_info piix_port_info[] = {
>   	[ich8m_apple_sata] =
>   	{
>   		.flags		= PIIX_SATA_FLAGS,
> +		.link_flags	= ATA_LFLAG_DEBOUNCE_DELAY,
>   		.pio_mask	= ATA_PIO4,
>   		.mwdma_mask	= ATA_MWDMA2,
>   		.udma_mask	= ATA_UDMA6,
> @@ -1228,6 +1241,7 @@ static struct ata_port_info piix_port_info[] = {
>   	[piix_pata_vmw] =
>   	{
>   		.flags		= PIIX_PATA_FLAGS,
> +		.link_flags	= ATA_LFLAG_DEBOUNCE_DELAY,
>   		.pio_mask	= ATA_PIO4,
>   		.mwdma_mask	= ATA_MWDMA12_ONLY, /* mwdma1-2 ?? CHECK 0 should be ok but slow */
>   		.udma_mask	= ATA_UDMA2,
> @@ -1241,6 +1255,7 @@ static struct ata_port_info piix_port_info[] = {
>   	[ich8_sata_snb] =
>   	{
>   		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SIDPR | PIIX_FLAG_PIO16,
> +		.link_flags	= ATA_LFLAG_DEBOUNCE_DELAY,
>   		.pio_mask	= ATA_PIO4,
>   		.mwdma_mask	= ATA_MWDMA2,
>   		.udma_mask	= ATA_UDMA6,
> @@ -1251,6 +1266,7 @@ static struct ata_port_info piix_port_info[] = {
>   	{
>   		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SIDPR
>   					| PIIX_FLAG_PIO16,
> +		.link_flags	= ATA_LFLAG_DEBOUNCE_DELAY,
>   		.pio_mask	= ATA_PIO4,
>   		.mwdma_mask	= ATA_MWDMA2,
>   		.udma_mask	= ATA_UDMA6,
> @@ -1260,6 +1276,7 @@ static struct ata_port_info piix_port_info[] = {
>   	[ich8_2port_sata_byt] =
>   	{
>   		.flags          = PIIX_SATA_FLAGS | PIIX_FLAG_SIDPR | PIIX_FLAG_PIO16,
> +		.link_flags	= ATA_LFLAG_DEBOUNCE_DELAY,
>   		.pio_mask       = ATA_PIO4,
>   		.mwdma_mask     = ATA_MWDMA2,
>   		.udma_mask      = ATA_UDMA6,
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index be46833d77a6..87ad03c2e49f 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -302,9 +302,18 @@ static int __sata_link_resume(struct ata_link *link,
>   			      unsigned long deadline)
>   {
>   	int tries = ATA_LINK_RESUME_TRIES;
> +	unsigned int db_delay = 1;

Also append the unit to the name: db_delay_ms?

The other delays use long, but 64 s where int is 16-bit wide, should be 
enough.

>   	u32 scontrol, serror;
>   	int rc;
>   
> +	/*
> +	 * Some PHYs react badly if SControl is pounded immediately after
> +	 * resuming. For drivers requesting it, delay 200ms before debouncing.
> +	 * Otherwise, only delay by 1ms (arbitrary delay).
> +	 */
> +	if (link->flags & ATA_LFLAG_DEBOUNCE_DELAY)
> +		db_delay = 200;
> +

Use ternary operator?

	db_delay = (link->flags & ATA_LFLAG_DEBOUNCE_DELAY) ? 200 : 1;

>   	if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
>   		return rc;
>   
> @@ -317,13 +326,8 @@ static int __sata_link_resume(struct ata_link *link,
>   		scontrol = (scontrol & 0x0f0) | 0x300;
>   		if ((rc = sata_scr_write(link, SCR_CONTROL, scontrol)))
>   			return rc;
> -		/*
> -		 * Some PHYs react badly if SStatus is pounded
> -		 * immediately after resuming.  Delay 200ms before
> -		 * debouncing.
> -		 */
> -		if (!(link->flags & ATA_LFLAG_NO_DEBOUNCE_DELAY))
> -			ata_msleep(link->ap, 200);
> +
> +		ata_msleep(link->ap, db_delay);
>   
>   		/* is SControl restored correctly? */
>   		if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 166263d9bbc7..cc3a8e9c78b0 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -143,7 +143,7 @@ enum {
>   	ATA_LFLAG_NO_LPM	= (1 << 8), /* disable LPM on this link */
>   	ATA_LFLAG_RST_ONCE	= (1 << 9), /* limit recovery to one reset */
>   	ATA_LFLAG_CHANGED	= (1 << 10), /* LPM state changed on this link */
> -	ATA_LFLAG_NO_DEBOUNCE_DELAY = (1 << 11), /* no debounce delay on link resume */
> +	ATA_LFLAG_DEBOUNCE_DELAY = (1 << 11), /* Debounce delay on link resume */
>   
>   	/* struct ata_port flags */
>   	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */

The rest looks good.


Kind regards,

Paul


[1]: 
https://lore.kernel.org/linux-ide/20220113154635.17581-2-pmenzel@molgen.mpg.de/
