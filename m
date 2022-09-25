Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B121EC04A95
	for <linux-ide@archiver.kernel.org>; Sun, 25 Sep 2022 23:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiIYXLl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 25 Sep 2022 19:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiIYXLl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 25 Sep 2022 19:11:41 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194912870E
        for <linux-ide@vger.kernel.org>; Sun, 25 Sep 2022 16:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664147499; x=1695683499;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BRAraElOhQdBZIK3AbcnjLtE1KkoT/5KzBFqlzM9ZzE=;
  b=MrhPfCIqWdDkvfVEhIlmxOpHlAZv3wjeilslgtsh1+0zHUeNhTrftN+j
   uW57X9ZIGWv8SgMlRHr3k2PxiiH6TaBR8dwtCwKd8mmC9h/q8PvyUGPUL
   eTtJSEX934S7My5dJaUrzyfXeHGgruVnGn7lZWlorrEgA3q/AXmkjFMz/
   nIXyP/1RkUfqOSCe/g2V3G2RG4+TvFJ8a89yltPgSJkOxgf5TvNzLfTwU
   Oru0q4qETslKrgby94Ja+9+Fkq1GCpimSbT7lqRuIDnHnm6HpCMcnFxjV
   eqMjlCW1qrwb4yJWWDuAePG7fR4jKk6M//rOu1U/w8dUBoHQlcZDZ/sEw
   g==;
X-IronPort-AV: E=Sophos;i="5.93,345,1654531200"; 
   d="scan'208";a="212658175"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2022 07:11:39 +0800
IronPort-SDR: ZS7ASpdzhYrh4U0VFE1toisUqW2OP8+0PAtjoztmhFQoyT2fsgTyfhsZQ930ddcpDlL02nO/3+
 4k2rQn16eECU5EcuJT8Q2cqavAz58JAtsJfaj9vjysGofZOE4LlTDBPHo3etSe9x/rxsA0g8cO
 EBUkvCL2EvOmLLlOwabdLr3wmPUfA+CZLLiEmx/JaZSgyCR7V75L9QPcev/H6Y/gt/xpJGpCVa
 X62iUUW3E9Z7waxtW9Wff8Pwnxow10WCqbev/nS99+JNP9rOZUIVc7SShVR3pvaf7JTJlnEP+I
 CGiNzabJ/tf+ousjPRABQLvN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2022 15:31:38 -0700
IronPort-SDR: 6+JR2iukSzIxmn3qbxePtM2qG7wxnTg2H65EDUSV5ASeBF5104iiDfBSJgwRAcHjTBAmHvN5oD
 M22yoh/BnWVaokwwDJjiYlDayCqBCRn9awDiuMjOzjMCQkjpX5EYbQ0ybNieQiaZktvllVzh64
 od/wCTzUi8TKrsb21xE+leYY1ysjHvD9IrzcLu4JO9jL/FNLKZY86S9DIgv1r5tBk2sC1HCTwF
 QBdzQK/rcFgz7LsvTp4Vh271EE2AAXGuqSOHiWVt2Ae6KRQrES37J6fqJ7PYeIVgtfZtnZ9J6o
 IHI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2022 16:11:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MbM8W00nXz1RvTp
        for <linux-ide@vger.kernel.org>; Sun, 25 Sep 2022 16:11:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664147498; x=1666739499; bh=BRAraElOhQdBZIK3AbcnjLtE1KkoT/5KzBF
        qlzM9ZzE=; b=oAs2qXZ+xtzWWkumCffd5lHzTeMrZD89jAcsyyrnRpxsDKYZKrw
        FIsqdKSwSaL9SmmQc3pOMd5BL9QLuNFX5cO33s56NGlN3W3aV7E5MXRDYPkBUk2O
        aTPGu2Wq7SvIDzmhLH9r+R0CVvGHA8QzDOfClcnaf4IbTTFUz8iuivx/qUGoeaxu
        PplX/WnToQ5igiIi+YaiNZNjhkzpWRnoXHEBvGfPkUN3eVwCZ4aZZHSn0clKesm4
        veK+fW4XrZ3f5Ax+OqWxgs3Rbv5V58U07Dgp9LmEuNo8UNgw6naYxYS1ZHmQUr5H
        NElYk7lRaaLbfVcMmkR89r3j5L2ze8OsEQA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2H0wjD5qVOoY for <linux-ide@vger.kernel.org>;
        Sun, 25 Sep 2022 16:11:38 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MbM8T6Wv0z1RvLy;
        Sun, 25 Sep 2022 16:11:37 -0700 (PDT)
Message-ID: <c6feae77-1fe1-820c-a8aa-fea2ab7190e8@opensource.wdc.com>
Date:   Mon, 26 Sep 2022 08:11:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] ata: libata-eh: avoid needless hard reset when
 revalidating link
Content-Language: en-US
To:     Niklas Cassel <niklas.cassel@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20220921155753.231770-1-niklas.cassel@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220921155753.231770-1-niklas.cassel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/22/22 00:57, Niklas Cassel wrote:
> Performing a revalidation on a AHCI controller supporting LPM,
> while using a lpm mode of e.g. med_power_with_dip (hipm + dipm) or
> medium_power (hipm), will currently always lead to a hard reset.
> 
> The expected behavior is that a hard reset is only performed when
> revalidate fails, because the properties of the drive has changed.
> 
> A revalidate performed after e.g. a NCQ error, or such a simple thing
> as disabling write-caching (hdparm -W 0 /dev/sda), should succeed on
> the first try (and should therefore not cause the link to be reset).
> 
> This unwarranted hard reset happens because ata_phys_link_offline()
> returns true for a link that is in deep sleep. Thus the call to
> ata_phys_link_offline() in ata_eh_revalidate_and_attach() will cause
> the revalidation to fail, which causes ata_eh_handle_dev_fail() to be
> called, which will set ehc->i.action |= ATA_EH_RESET, such that the
> link is reset before retrying revalidation.
> 
> When the link is reset, the link is reestablished, so when
> ata_eh_revalidate_and_attach() is called the second time, directly
> after the link has been reset, ata_phys_link_offline() will return
> false, and the revalidation will succeed.
> 
> Looking at "8.3.1.3 HBA Initiated" in the AHCI 1.3.1 specification,
> it is clear the when host software writes a new command to memory,
> by setting a bit in the PxCI/PxSACT HBA port registers, the HBA will
> automatically bring back the link before sending out the Command FIS.
> 
> However, simply reading a SCR (like ata_phys_link_offline() does),
> will not cause the HBA to automatically bring back the link.
> 
> As long as hipm is enabled, the HBA will put an idle link into deep
> sleep. Avoid this needless hard reset on revalidation by temporarily
> disabling hipm, by setting the LPM mode to ATA_LPM_MAX_POWER.
> 
> After revalidation is complete, ata_eh_recover() will restore the link
> policy by setting the LPM mode to ap->target_lpm_policy.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

Applied to for-6.1. Thanks !

> ---
>  drivers/ata/libata-eh.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 7c128c89b454..1f83ae8690ee 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -151,6 +151,8 @@ ata_eh_cmd_timeout_table[ATA_EH_CMD_TIMEOUT_TABLE_SIZE] = {
>  #undef CMDS
>  
>  static void __ata_port_freeze(struct ata_port *ap);
> +static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
> +			  struct ata_device **r_failed_dev);
>  #ifdef CONFIG_PM
>  static void ata_eh_handle_port_suspend(struct ata_port *ap);
>  static void ata_eh_handle_port_resume(struct ata_port *ap);
> @@ -2940,6 +2942,23 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
>  		if ((action & ATA_EH_REVALIDATE) && ata_dev_enabled(dev)) {
>  			WARN_ON(dev->class == ATA_DEV_PMP);
>  
> +			/*
> +			 * The link may be in a deep sleep, wake it up.
> +			 *
> +			 * If the link is in deep sleep, ata_phys_link_offline()
> +			 * will return true, causing the revalidation to fail,
> +			 * which leads to a (potentially) needless hard reset.
> +			 *
> +			 * ata_eh_recover() will later restore the link policy
> +			 * to ap->target_lpm_policy after revalidation is done.
> +			 */
> +			if (link->lpm_policy > ATA_LPM_MAX_POWER) {
> +				rc = ata_eh_set_lpm(link, ATA_LPM_MAX_POWER,
> +						    r_failed_dev);
> +				if (rc)
> +					goto err;
> +			}
> +
>  			if (ata_phys_link_offline(ata_dev_phys_link(dev))) {
>  				rc = -EIO;
>  				goto err;

-- 
Damien Le Moal
Western Digital Research

