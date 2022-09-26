Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDEEC07E9D
	for <linux-ide@archiver.kernel.org>; Mon, 26 Sep 2022 23:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiIZXYq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 26 Sep 2022 19:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiIZXYQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Sep 2022 19:24:16 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE8C1198CA
        for <linux-ide@vger.kernel.org>; Mon, 26 Sep 2022 16:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664234554; x=1695770554;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IRHeXZ/NpwwH/OredQ5SvJnDZr+RKdF2QXW8lGQc/q8=;
  b=VITeFsiQKRrpHXWca+3b7r5M87H8Wr8d6fuQRI8Z3ewtRydvXDliRpMM
   CwqDuh8bT4u4XLCVwT1+50+kKwe3ccqLWPnoy54gntWfVi20ILQcPgg7R
   eUDc7KciIK0Bs57+D2cXLISS2mlkzWFDP5HpG8e/vGeyDgluBGYwy/EY2
   eEb78AHp1/pZ/g242/FxGIDlDKYmXKg8OuL4ODIsnjcuCC/gsA05A22SF
   KzoKx3WFVP7vajkadtGYBtshpzGYGrdoKucjvtBB0tjEYQX51LS4VYq2i
   +MF6JVhuTQwgxj19ScC+r8X8qZ49d8DBflHobAdq0yMsD0kqmC5rRvcSr
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,347,1654531200"; 
   d="scan'208";a="212747236"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2022 07:22:32 +0800
IronPort-SDR: c0KK3xX8JjQK+bK7BJ/igLZbfx8W0FkIBpAF3Sft8+Gi2R2GL5Ov3yztidipgY/qqYLS70tgZ2
 3r4PCT00lTbryILjh3FUyeuWcphjYt/GAKg7fcYO89Lst7gkJKQl9bSohjWMEK5SzD7SfQ9ftQ
 DBY1wEcZT7sY7DM8X0gCQoUbASLkoHqGPnWvEe3H1NMD4tf7grN0ozq3zcN8hnHMoU7ePdoxcS
 Atekx9HMAG9fw6L0WdQBAq+OvCkXoGlxv/b5EP/SIGUvOLTUwywrxFffqyTlIFvUhjbbLStE5q
 kxkFmNGcfIP4xEUKM3FKOtqp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 15:42:30 -0700
IronPort-SDR: fB9limYuo59vjvBnpuS+Go4voRP76F+IXzHBcjxGjfQKIG28EHwWMrViwgIYcaAMZzr0/ilwT/
 DpJu0xeFF+7XAVq6g59kJCrjxpNl/BwO2OatcRd5o+upm+OrVDOH8rMc2O8mSZO+Ju/WXNUfho
 vMNpT4Xwb0IQR5l2G1Hfbog1iA9bJpDI149zcXKQzT+c9Js8CY3OvVCFJ2J7/n54ALgypKrozl
 UsUg8GjZjoYppDj7EDe6f+PWYve0B7SnJnFcAERvI/xU8xxrviH6CHZmWtiuMBpakbdX+oJN9+
 D2I=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 16:22:33 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MbzLc58Znz1Rwrq
        for <linux-ide@vger.kernel.org>; Mon, 26 Sep 2022 16:22:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664234552; x=1666826553; bh=IRHeXZ/NpwwH/OredQ5SvJnDZr+RKdF2QXW
        8lGQc/q8=; b=TzDu22YWhtfg64q5OgmXoDyiZIprAxcGTbqRLD1MjXCAQEXJeOT
        1ZAOmICx47uwJy5dmR2eJceLhEA/VvT9RWZ5M5CMk+cN4NLV4j/qNj3E7JOOui/f
        lmXDxoPve5CHOj8SvfKHLBf0zJ60P6bVHctcHQ9EdaNL1hDQUDysNT4CiNDCa8si
        FyhHghmCiXNTk5EU75iQqMiGO5QDaMDLjQ1QPyNs8di9luoyGhPXLOH3g87/5J5X
        uq/RrIH/k5mQtF65L60/vjILl93HaQDUwCxlnIYBE+LxNDIeteaBjpJXDhrU9ov4
        Sbzcfpw1YJFrFSgqDRBvh0+9ZAzq6+EEAJg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rzG-zT8lcm6k for <linux-ide@vger.kernel.org>;
        Mon, 26 Sep 2022 16:22:32 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MbzLb2vf6z1RvLy;
        Mon, 26 Sep 2022 16:22:31 -0700 (PDT)
Message-ID: <225a669c-4907-0473-08ff-30a71813384c@opensource.wdc.com>
Date:   Tue, 27 Sep 2022 08:22:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] libata: add ATA_HORKAGE_NOLPM for Pioneer BDR-207M and
 BDR-205
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jaap Berkhout <j.j.berkhout@staalenberk.nl>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20220926183718.480950-1-Niklas.Cassel@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220926183718.480950-1-Niklas.Cassel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/27/22 03:38, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Commit 1527f69204fe ("ata: ahci: Add Green Sardine vendor ID as
> board_ahci_mobile") added an explicit entry for AMD Green Sardine
> AHCI controller using the board_ahci_mobile configuration (this
> configuration has later been renamed to board_ahci_low_power).
> 
> The board_ahci_low_power configuration enables support for low power
> modes.
> 
> This explicit entry takes precedence over the generic AHCI controller
> entry, which does not enable support for low power modes.
> 
> Therefore, when commit 1527f69204fe ("ata: ahci: Add Green Sardine
> vendor ID as board_ahci_mobile") was backported to stable kernels,
> it make some Pioneer optical drives, which was working perfectly fine
> before the commit was backported, stop working.
> 
> The real problem is that the Pioneer optical drives do not handle low
> power modes correctly. If these optical drives would have been tested
> on another AHCI controller using the board_ahci_low_power configuration,
> this issue would have been detected earlier.
> 
> Unfortunately, the board_ahci_low_power configuration is only used in
> less than 15% of the total AHCI controller entries, so many devices
> have never been tested with an AHCI controller with low power modes.
> 
> Fixes: 1527f69204fe ("ata: ahci: Add Green Sardine vendor ID as board_ahci_mobile")
> Cc: stable@vger.kernel.org
> Reported-by: Jaap Berkhout <j.j.berkhout@staalenberk.nl>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

Applied to for-6.0-fixes. Thanks !

> ---
>  drivers/ata/libata-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 826d41f341e4..c9a9aa607b62 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3988,6 +3988,10 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	{ "PIONEER DVD-RW  DVR-212D",	NULL,	ATA_HORKAGE_NOSETXFER },
>  	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
>  
> +	/* These specific Pioneer models have LPM issues */
> +	{ "PIONEER BD-RW   BDR-207M",	NULL,	ATA_HORKAGE_NOLPM },
> +	{ "PIONEER BD-RW   BDR-205",	NULL,	ATA_HORKAGE_NOLPM },
> +
>  	/* Crucial BX100 SSD 500GB has broken LPM support */
>  	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
>  

-- 
Damien Le Moal
Western Digital Research

