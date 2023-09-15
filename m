Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA320EE3F2F
	for <linux-ide@archiver.kernel.org>; Fri, 15 Sep 2023 06:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjIOGc6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 15 Sep 2023 02:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjIOGc5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 15 Sep 2023 02:32:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEB5CCD
        for <linux-ide@vger.kernel.org>; Thu, 14 Sep 2023 23:32:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAB3C433C8;
        Fri, 15 Sep 2023 06:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694759572;
        bh=h7cfZPMYhlPN0RrMtyJscrBfq/a3hAOJA+6MhPD0P84=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sLjBj6Wllf1p0sWrhBa7Osg/73+P3YTAXSfK11iB5N5KPFDGEGrGffP3tudx+0EW6
         gFYWByOIUOOL9iTJQhmxMiZCucIn35BoiZEayuQH3nnwP5bWObRgMA67cNlUMNvBOQ
         fsGIGZt6LHrLlYMSuRbWDX+F36gNECi33TVdw8NvtlKVANxzVeVutdKqbJ6/Cc6Nxd
         Qq/hivLB8sQ+dqwnZ3SZJF9wL1JAhors/Rm/Hc/Lef5cN6gACkbwKdZl92yseLRTUk
         vACCVwKIytccfywUA8jpIYMDoC01zD21XP+LtnoR2cItw/TP/2skkUeBAPK8dD0SzS
         JiMThvHA7H3Fw==
Message-ID: <e6fd1980-cbc2-65a1-770b-af745c89a787@kernel.org>
Date:   Fri, 15 Sep 2023 15:32:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata: libata-core: fetch sense data for successful
 commands iff CDL enabled
Content-Language: en-US
To:     Niklas Cassel <nks@flawful.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        patenteng <dimitar@daskalov.co.uk>, linux-ide@vger.kernel.org,
        Niklas Cassel <niklas.cassel@wdc.com>
References: <20230913150443.1200790-1-nks@flawful.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230913150443.1200790-1-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/14/23 00:04, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Currently, we fetch sense data for a _successful_ command if either:
> 1) Command was NCQ and ATA_DFLAG_CDL_ENABLED flag set (flag
>    ATA_DFLAG_CDL_ENABLED will only be set if the Successful NCQ command
>    sense data supported bit is set); or
> 2) Command was non-NCQ and regular sense data reporting is enabled.
> 
> This means that case 2) will trigger for a non-NCQ command which has
> ATA_SENSE bit set, regardless if CDL is enabled or not.
> 
> This decision was by design. If the device reports that it has sense data
> available, it makes sense to fetch that sense data, since the sk/asc/ascq
> could be important information regardless if CDL is enabled or not.
> 
> However, the fetching of sense data for a successful command is done via
> ATA EH. Considering how intricate the ATA EH is, we really do not want to
> invoke ATA EH unless absolutely needed.
> 
> Before commit 18bd7718b5c4 ("scsi: ata: libata: Handle completion of CDL
> commands using policy 0xD") we never fetched sense data for successful
> non-NCQ commands.
> 
> In order to not invoke the ATA EH unless absolutely necessary, even if the
> device claims support for sense data reporting, only fetch sense data for
> successful (NCQ and non-NCQ commands) if CDL is supported and enabled.
> 
> Fixes: 3ac873c76d79 ("ata: libata-core: fix when to fetch sense data for successful commands")
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  drivers/ata/libata-core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 74314311295f..2f7f72994cd7 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4784,10 +4784,7 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
>  	 * 0xD. For these commands, invoke EH to get the command sense data.
>  	 */
>  	if (qc->result_tf.status & ATA_SENSE &&
> -	    ((ata_is_ncq(qc->tf.protocol) &&
> -	      dev->flags & ATA_DFLAG_CDL_ENABLED) ||
> -	     (!ata_is_ncq(qc->tf.protocol) &&
> -	      ata_id_sense_reporting_enabled(dev->id)))) {
> +	    dev->flags & ATA_DFLAG_CDL_ENABLED) {

Applied to for-6.6-fixes with a tweak:

	if (qc->flags & ATA_QCFLAG_HAS_CDL &&
	    qc->result_tf.status & ATA_SENSE) {

is the test I tweaked. This allows ignoring command that do not use CDL. And
seeing ATA_QCFLAG_HAS_CDL set implies that dev->flags & ATA_DFLAG_CDL_ENABLED is
true. So this is better I think.

>  		/*
>  		 * Tell SCSI EH to not overwrite scmd->result even if this
>  		 * command is finished with result SAM_STAT_GOOD.

-- 
Damien Le Moal
Western Digital Research

