Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24051C433EF
	for <linux-ide@archiver.kernel.org>; Fri,  1 Jul 2022 05:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiGAFGY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 1 Jul 2022 01:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGAFGX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 1 Jul 2022 01:06:23 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B8D61D4D
        for <linux-ide@vger.kernel.org>; Thu, 30 Jun 2022 22:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656651981; x=1688187981;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SvxleXnvLLu2HAHqskkysVjHRspI2rZmxKBEUNqOG3g=;
  b=K6zObYdKiTg49Um2OXBNTIDXPnNNuSrKy71KiZPKUM65Vb4JU9+vBKVc
   d797pRehYmN7+BW0+hrs+dnn8ty92qsSYwzK+fGe2BNNj0SSOPj6YP9yq
   3q2hx9yiNmR2RobPsF47OZ+8eoJV8SD56rOiXpxD4xBSFVFzhLeN4FrWr
   0ERePZeX7AwRRaYVI9oXA/HVb8Y3TT41L1sEUUM7ggtNC5FpFGKrLtHYJ
   NEH0ukzOAD43bcD3wueYxvLmWzgKRUAUsyMFCCr/aS0iFjNgiO6uOOIFt
   kCmtrJkWxBBaq41eyw5ou2EDBp+OF1fmpgBRqsHUvS/vecW7/JzLsuoDJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,236,1650902400"; 
   d="scan'208";a="316670746"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2022 13:06:21 +0800
IronPort-SDR: 2sx85l4pBWVrgF1BXBqGgbAWu/njrZVIG7iLkNu2Ez9bKh3g3XOMxB+KaZi1PQGg19yX8DxJm3
 fJnjKoesg9P8ox85jPNjGqWrGouWXuMuZzfJiHbi0mIvfC6d9LJE/NAyvf/VM0qnOaKeDNxUDI
 i8dHHEpSdtCV4vZAXnCxC4gx3MzP0h/Qdv+tcoi7gZLl7CrtuYjEzjiBzPoNSfJX0bYuEUZ3Lc
 xYZddl9M3ouQvtwRzmrq/9AnUck5Vnm6pVNVMS9ZmxozrU2enOZRwAwg4HsjhIs8hXDaUO1Oi8
 A7hXXkguPheaI6ejYfIZRn/p
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 21:23:51 -0700
IronPort-SDR: 5icrcxWiHlgNAsXmd6tNqlS9cnPafhV7BOrCXYjrw4+8STW4Ltuw0TbkQbGmIkLJFC8oaSug1g
 JPyRIMVaj+ke04PzPSMJndGiJaouwAjW3NXtuJsqjFLZcOtqp3jrZF5fCvjBXcrrzEvkGz/w+d
 XlRxDODP6rBz4iCJJt4Px/dS7u6vLqN6couveFQNFkmjXZMAAYq/tsJuq2pFW3sCjimvQl/eCe
 zA/dJk7fQZUztMEGEXSQ+mF30/uByvt3ZznjpbsxoT/MKgmEp6z5+atefqiSpn9bum+oVohlhU
 55c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 22:06:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LZ37x12rCz1Rw4L
        for <linux-ide@vger.kernel.org>; Thu, 30 Jun 2022 22:06:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656651980; x=1659243981; bh=SvxleXnvLLu2HAHqskkysVjHRspI2rZmxKB
        EUNqOG3g=; b=EmrS2gTUseTPly7tzkn5i4i42v8gT5n5mRrMsDJEjbCUmpLGtbV
        lcbFsEOQyuRuFxezy/eGfLqnI00kAsHK0r58wtfN62aG0zukPe+Xn4Gui8dF0wKg
        pa8m0WoU6c/0T9XMerV2uSjIJhX0d5RgeMvuhUuKLfaaZr5YCGpaSjmYplnCp+ad
        95hGHgo/ftS0spQH4SyHoZHeOPsQw6V53x7HQV8ZN7MkV066KhO49l5+jj5H940t
        QRN1ErqRp1F2QtjB7O58RL7TA1qWTR26o5iZeD8pMshtYn8B965KeOuF4QBQgJn4
        0kzOodBGTQ4neQHv02wS9hm1O1hjr0Nk66Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id flaZZ6E2ahfP for <linux-ide@vger.kernel.org>;
        Thu, 30 Jun 2022 22:06:20 -0700 (PDT)
Received: from [10.225.163.102] (unknown [10.225.163.102])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LZ37v6Hz4z1RtVk;
        Thu, 30 Jun 2022 22:06:19 -0700 (PDT)
Message-ID: <4e0783ac-b9f5-24ff-f7c6-7b64549b8f9c@opensource.wdc.com>
Date:   Fri, 1 Jul 2022 14:06:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 04/10] ata: ahci: Use `pm_suspend_preferred_s2idle`
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220701023328.2783-1-mario.limonciello@amd.com>
 <20220701023328.2783-4-mario.limonciello@amd.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220701023328.2783-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/1/22 11:33, Mario Limonciello wrote:
> Drop the direct check from the FADT and use the helper instead.

Where is this helper defined ? Seeing that this is patch 4/10, I have no
context for this patch. Please send the whole series next time.

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/ata/ahci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index c1eca72b4575..3f79b732dd00 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1611,7 +1611,7 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap,
>  
>  #ifdef CONFIG_ACPI
>  	if (policy > ATA_LPM_MED_POWER &&
> -	    (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
> +	    pm_suspend_preferred_s2idle()) {
>  		if (hpriv->cap & HOST_CAP_PART)
>  			policy = ATA_LPM_MIN_POWER_WITH_PARTIAL;
>  		else if (hpriv->cap & HOST_CAP_SSC)


-- 
Damien Le Moal
Western Digital Research
