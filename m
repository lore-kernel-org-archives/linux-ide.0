Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95DAC25B08
	for <linux-ide@archiver.kernel.org>; Mon, 15 Aug 2022 21:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347465AbiHOV5o (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 15 Aug 2022 17:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350731AbiHOV4y (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 15 Aug 2022 17:56:54 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5974910A757
        for <linux-ide@vger.kernel.org>; Mon, 15 Aug 2022 12:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660592070; x=1692128070;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8l9WQWslt8DfpzB9gqIrTVEgk83Iu5rOvreMLqeGBsI=;
  b=dJAwLYpFGSK9XVbb0GlLLlBZVz9bobbLf6RE7/6Om3dcSl4Pt1CF2RKc
   9LFxhb6HMkZqlMVW/m1+QaxN2NCfxF3ImrPsj1ZdZ8Qrs4Hi/3Ph0hNNR
   +q7UEqePtW/ltugUor2v6G3TTP4eLmOygCeFFxBqVgEQbx9R158JHDTRP
   cUXgCQgfE4/txjj7X1EJdcEu1/uoaZSi2Y4bRLQY95QjUoRfH6TLva/It
   L5m3IVtT2Q4Kihh4f4++4Evs1208Kwb0YTxmVnC0s+/CwZlGC1K073ZQy
   tjxBEGTicFDacqQvad3kkCbH6MzHyqKh3Y/lpH9K9eQgyjkDRshkZv/Om
   g==;
X-IronPort-AV: E=Sophos;i="5.93,239,1654531200"; 
   d="scan'208";a="213822826"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2022 03:34:19 +0800
IronPort-SDR: vRMNumksxIMwmI15h+vW9K2dDySTtukFM1VVcMBVq9gFb5FSlJWPg2Mkq8qnV9z0Jbg+TFl5H8
 rdt9U9w5/Cfy+ngUjijGxbQ97s6n4Kz/+XUbexGJ8lHR1vk2YgX9upKp9/qLwX6Up6bvGEXynu
 XoJog+zGvIJnd1kgWuKEXGTJ1TdDRXi7Ffor2+Ym82I+JcE/MdAbbKQxjS3RB5bUhAKBSfRwNW
 yeY0UpwjfZRALQJOnOmct1gn32fKEr9TrOiqSrERf1af03eYpJLnPZeWCOpowVySqEUyf4uzO0
 O09jnJZoDO6MCO8SPPx6MUGQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Aug 2022 11:55:08 -0700
IronPort-SDR: UU9fQ+/oWXduMFX9Y1hWsAp4xPMN61tbEYO887vevN5FLaNydvPgEQ1lqLTxH9wJTtOwU2OHn7
 PRfbfZK/Vo0B3MOA8xutmvGswYgTgkzgcOpCNDkg42M81wQ3HKvIBm6Jo0aN/dJhnt2el8uC+u
 DWb8rlHUy7Yr4y6kO7kTHAszqBPFxYYT4JwJ2ClD7Kh7v7eI19AyDFOVxv7w5nk4XFNoMziksA
 q8gbptsKlI4OMHy+hMizW+2WWrWL1N24t3a5zMvsPYP1JMgZysUi8qNNbXll7nm5MBuLSmeHt9
 sIY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Aug 2022 12:34:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M64Gg1V3Dz1Rw4L
        for <linux-ide@vger.kernel.org>; Mon, 15 Aug 2022 12:34:19 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660592058; x=1663184059; bh=8l9WQWslt8DfpzB9gqIrTVEgk83Iu5rOvre
        MLqeGBsI=; b=C3//ZoMhVHNPWMWgK4V6jLWdB2KXrduXMomcnsEMZa2imejW5qa
        V5A5tD5w28vtmmFFS9ETrX9z0F/f66i69YCkMj8aHCU6Fk4saFNS9Glhfo4AV9jV
        Xm2N9XO+M57o+dE0dmm8iYs1RAYPzFX9mS+sMEzSJrWFtIqXOsAUD2xDtfB3/sYZ
        x0v+W4fyZV3YTrz/zIGac9o7bdkwbw2kpiePLzbBnGkjRA7JccwkthT36Racq3fR
        0H+KJPA6T8RaOfGsh9pDTgLrQC+5K0z1cuNE3eywpJPfAvftkmIHu7vQdxHHBeak
        y+HUNDia1kT4F1PwdE84g5m3ECZJ0YXpM0g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Zk4ExH1mXHnA for <linux-ide@vger.kernel.org>;
        Mon, 15 Aug 2022 12:34:18 -0700 (PDT)
Received: from [10.11.46.122] (c02drav6md6t.sdcorp.global.sandisk.com [10.11.46.122])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M64Gf5BpMz1RtVk;
        Mon, 15 Aug 2022 12:34:18 -0700 (PDT)
Message-ID: <2b0bcbf8-97d6-10aa-c9f6-12840e73e868@opensource.wdc.com>
Date:   Mon, 15 Aug 2022 12:34:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH] ata: libata-core: improve parameter names for
 ata_dev_set_feature()
Content-Language: en-US
To:     Niklas Cassel <niklas.cassel@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20220815141704.1178489-1-niklas.cassel@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220815141704.1178489-1-niklas.cassel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/08/15 7:17, Niklas Cassel wrote:
> ata_dev_set_feature() is currently used for enabling/disabling any ATA
> feature, e.g. SETFEATURES_SPINUP and SETFEATURE_SENSE_DATA, i.e. it is
> not only used to enable/disable SATA specific features.
> 
> For most features, the enable/disable bit is specified in the subcommand
> specific field "count".
> It is only for the specific subcommands "Enable SATA feature" (0x10) and
> "Disable SATA feature" (0x90) where the field "count" is used to specify
> a feature instead of enable/disable. The parameter names for this
> function are thus quite misleading.
> 
> Rename the parameter names to be more generic and in line with ACS-5,
> and remove the references to "SATA FEATURES" in the kernel-doc.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  drivers/ata/libata-core.c | 19 +++++++++----------
>  drivers/ata/libata.h      |  2 +-
>  2 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 826d41f341e4..f737d32ceb82 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4324,13 +4324,12 @@ static unsigned int ata_dev_set_xfermode(struct ata_device *dev)
>  }
>  
>  /**
> - *	ata_dev_set_feature - Issue SET FEATURES - SATA FEATURES
> + *	ata_dev_set_feature - Issue SET FEATURES
>   *	@dev: Device to which command will be sent
> - *	@enable: Whether to enable or disable the feature
> - *	@feature: The sector count represents the feature to set
> + *	@subcmd: The SET FEATURES subcommand to be sent
> + *	@count: The sector count represents a subcommand specific action

Why not call this one "action" ? Better have the API parameter name represent
the meaning of the value rather than the cdb field used to pack it.

>   *
> - *	Issue SET FEATURES - SATA FEATURES command to device @dev
> - *	on port @ap with sector count
> + *	Issue SET FEATURES command to device @dev on port @ap with sector count
>   *
>   *	LOCKING:
>   *	PCI/etc. bus probe sem.
> @@ -4338,23 +4337,23 @@ static unsigned int ata_dev_set_xfermode(struct ata_device *dev)
>   *	RETURNS:
>   *	0 on success, AC_ERR_* mask otherwise.
>   */
> -unsigned int ata_dev_set_feature(struct ata_device *dev, u8 enable, u8 feature)
> +unsigned int ata_dev_set_feature(struct ata_device *dev, u8 subcmd, u8 count)
>  {
>  	struct ata_taskfile tf;
>  	unsigned int err_mask;
>  	unsigned int timeout = 0;
>  
>  	/* set up set-features taskfile */
> -	ata_dev_dbg(dev, "set features - SATA features\n");
> +	ata_dev_dbg(dev, "set features\n");
>  
>  	ata_tf_init(dev, &tf);
>  	tf.command = ATA_CMD_SET_FEATURES;
> -	tf.feature = enable;
> +	tf.feature = subcmd;
>  	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
>  	tf.protocol = ATA_PROT_NODATA;
> -	tf.nsect = feature;
> +	tf.nsect = count;
>  
> -	if (enable == SETFEATURES_SPINUP)
> +	if (subcmd == SETFEATURES_SPINUP)
>  		timeout = ata_probe_timeout ?
>  			  ata_probe_timeout * 1000 : SETFEATURES_SPINUP_TIMEOUT;
>  	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, timeout);
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index 98bc8649c63f..ccc8ba037cb1 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -64,7 +64,7 @@ extern int ata_dev_configure(struct ata_device *dev);
>  extern int sata_down_spd_limit(struct ata_link *link, u32 spd_limit);
>  extern int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel);
>  extern unsigned int ata_dev_set_feature(struct ata_device *dev,
> -					u8 enable, u8 feature);
> +					u8 subcmd, u8 count);
>  extern void ata_qc_free(struct ata_queued_cmd *qc);
>  extern void ata_qc_issue(struct ata_queued_cmd *qc);
>  extern void __ata_qc_complete(struct ata_queued_cmd *qc);


-- 
Damien Le Moal
Western Digital Research
