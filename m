Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9151C352A1
	for <linux-ide@archiver.kernel.org>; Tue,  6 Dec 2022 06:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiLFGIj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 6 Dec 2022 01:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiLFGIi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 6 Dec 2022 01:08:38 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D7E23162
        for <linux-ide@vger.kernel.org>; Mon,  5 Dec 2022 22:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670306917; x=1701842917;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FaaIIHvrTuir+bzh2Pjaha2LsNiLZK5KDmiNQn16lyQ=;
  b=EUnWdUtYGtBhRhhC8Fb88Th+eFOfyePg6DlW+LWxAIFEBgVcDSCVCCHh
   mFlL1hGTbZm6EU3lt6NZCSlXaTKG7RDIy+d0sYhf6D+GLzIaYTkLcjTRn
   xXMngAFJFcGdmMaiP+9br5l89gunYLV2bLkn/lGq2fL6xKRONpqrVufe8
   AvD0M5S8M5t2PbE/wBlHPuDs1QuRInyceO1UYs5SsosB2ly57aE234TyZ
   gWEFHeRFFypfITMQ5SWRedvrdS6z6QqzOws2OUV0IJlOmZm/qH0zYFlXx
   z119GvOnIHOJBoRJa34iEz7ex7i2+2jvayR7TcH1HsQcdc4X48Ya3yF7/
   g==;
X-IronPort-AV: E=Sophos;i="5.96,220,1665417600"; 
   d="scan'208";a="217977862"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2022 14:08:36 +0800
IronPort-SDR: 2xNr/vTq06k2C/FY/3Gr27YfaUwy0pHPwtfdAweE8TxWPysTl0DZ/4FxxluFLOMBJWfIPdU32z
 oz8cufEdYVpcv5ecJhGt6gZh4AyQINoSQpUKryQhr43wUdaxN7ncYqxZ+wd55sYSjzx0fOVHxg
 SAMjF3/nSWL7b/LpUkSPlZkuo4T9yCfDQLByNpfh6fotQxbgoLEo8OWG9XFfvw83qkYe0aEylF
 iZjehwHjXj3Ax+V8GlMcH4VzvezGnFDbbkZE3qiTeR3KiJcFhH+zYCoHC+qb6ckByeF7/9UR8p
 s8g=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2022 21:21:24 -0800
IronPort-SDR: GVXzTRpQ6eJRO3dymNY8pFdU+Zl8yMKMsEvOcdb6Sdx7EMDdQhdNByaOkJNp8po/yy5aah43Dy
 lubjDjjwla0HyXaqX+DkCSkEBpHC+sZyhHV2ISHRrMnQCjTuvnLn7JNnZp1pInN5wQ6Q238+xv
 wdbXkZ+8uzTRNnXrWGbCZupuVmcI6pcFg8U5+9Ygiynzx3huC0GqqX4Xtfd9bttNMWeRNxKB72
 KV1BCtWz/hsb8cyE0gXqeNUtUJ51aetZ2oJ0orj/OpbUpl7JV2oCJsSAYXXWWskSVgpbouiXox
 COk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2022 22:08:36 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NR92r2R8jz1RvTp
        for <linux-ide@vger.kernel.org>; Mon,  5 Dec 2022 22:08:36 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670306915; x=1672898916; bh=FaaIIHvrTuir+bzh2Pjaha2LsNiLZK5KDmi
        NQn16lyQ=; b=o6/cIRN6gmeisqcsoAwxUUfXAq+UF8papDU7OXgTLSQnTPvrL0i
        eWhBQi8G0Xi0M45o7R6jOexYKjPVL7Lr6rJrKIvh9rERXGTst65v6KTXQL4uV8bx
        WP8vi/iUGvOmmaauPG3DpxDiRjmHovMbv9Il0bYkp/s2o2QD5L9YucXKwAouVqSC
        cwsq+4oMDdGvgX6pLvJJDbR8ATmXEUj4CDTBwxsSt/J1qJ19pPvyZxkS6KXdX8uL
        aq/niCePWw9tjDd80cKmiCSTIffTsQuBxYqfDz2LGhKKSv+HiP5kdaghQdQyBEZq
        /uz4NtWWtI0WA3kh5q68eMSMVyjwmAh+cGw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rIxrzNrz4M1a for <linux-ide@vger.kernel.org>;
        Mon,  5 Dec 2022 22:08:35 -0800 (PST)
Received: from [10.225.163.74] (unknown [10.225.163.74])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NR92q2wgYz1RvLy;
        Mon,  5 Dec 2022 22:08:35 -0800 (PST)
Message-ID: <c403c1dd-6478-09a3-f8b4-98026eb16c99@opensource.wdc.com>
Date:   Tue, 6 Dec 2022 15:08:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     marius@psihoexpert.ro,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     linux-ide@vger.kernel.org
References: <5b5d7816-5e43-88e8-1337-769cce825f78@opensource.wdc.com>
 <125bd8a6-7a1c-cd08-b5ee-da5a24f79f21@opensource.wdc.com>
 <dc9f74bd-91d7-cda1-8182-11d400e6bc3f@opensource.wdc.com>
 <a1b3b74b-1548-44d9-7d72-8eb428fa1788@opensource.wdc.com>
 <0ba8ebf7-6e6c-e63d-32c4-44d97898be1d@opensource.wdc.com>
 <126ce7f2-3de2-9e75-7920-09d78c224d76@opensource.wdc.com>
 <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
 <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
 <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
 <29aff79be06b7dacb97c13cbff07fabb@psihoexpert.ro>
 <97af1ef9ed605800e6ad43b7b3518800@psihoexpert.ro>
 <aa61bc53-34e2-4f19-962f-888e9daabbb4@opensource.wdc.com>
 <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
 <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/4/22 10:41, marius@psihoexpert.ro wrote:
> November 24, 2022 4:40 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.com> wrote:
> 
>> So the hardware is failing to detect the device presence. No clue why.
>> Only an ATA bus trace could tell us more here (do you have an ATA bus
>> analyzer around ?).
> 
> No. :-)
> 
>> So options are:
>> 1) Involve the router vendor and/or SoC vendor to see if they can help.
>> 2) Use UDB connection between your router & drive box ? (if you can)
>>
>> Another thing is: Did you try earlier kernel versions ? Any earlier kernel
>> working ? (I forgot if that is the case). If yes, then we should be able
>> to figure out the change that broke the driver (which may be something
>> changed in the SoC support rather than the mvebu driver itself).
>> gi-bisect will likely not be of any help given that you are not getting a
>> crash. So you will need to try out different kernel versions, starting
>> with LTS kernels, and refine (use Linus tags, including RCs, to find the
>> last working kernel). That may take some time, but will likely narrow down
>> the search for fixing this (if that is possible given the hardware setup
>> you have).
> 
> Sorry for the late reply, but I really really hate bisecting, especially manually, and especially if the test must be run on another machine.
> You are correct. It initially worked, but it was broken by this commit:
> 
> 
> commit 2dc0b46b5ea30f169b0b272253ea846a5a281731
> Author: David Milburn <dmilburn@redhat.com>
> Date:   Tue Nov 14 16:17:25 2017 -0600
> 
>     libata: sata_down_spd_limit should return if driver has not recorded sstatus speed
>     
>     During hotplug, it is possible for 6Gbps link speed to be limited all
>     the way down to 1.5 Gbps which may lead to a slower link speed when
>     drive is re-connected.
>     
>     This behavior has been seen on a Intel Lewisburg SATA controller
>     (8086:a1d2) with HGST HUH728080ALE600 drive where SATA link speed was
>     limited to 1.5 Gbps and when re-connected the link came up 3.0 Gbps.
>     
>     This patch was retested on above configuration and showed the
>     hotplugged link to come back online at max speed (6Gbps). I did not
>     see the downgrade when testing on Intel C600/X79, but retested patched
>     linux-4.14-rc5 kernel and didn't see any side effects from this
>     change. Also, successfully retested hotplug on port multiplier 3Gbps
>     link.
>     
>     tj: Minor comment updates.
>     
>     Signed-off-by: David Milburn <dmilburn@redhat.com>
>     Signed-off-by: Tejun Heo <tj@kernel.org>
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 2a882929de4a..8193b38a1cae 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3082,13 +3082,19 @@ int sata_down_spd_limit(struct ata_link *link, u32 spd_limit)
>  	bit = fls(mask) - 1;
>  	mask &= ~(1 << bit);
>  
> -	/* Mask off all speeds higher than or equal to the current
> -	 * one.  Force 1.5Gbps if current SPD is not available.
> +	/*
> +	 * Mask off all speeds higher than or equal to the current one.  At
> +	 * this point, if current SPD is not available and we previously
> +	 * recorded the link speed from SStatus, the driver has already
> +	 * masked off the highest bit so mask should already be 1 or 0.
> +	 * Otherwise, we should not force 1.5Gbps on a link where we have
> +	 * not previously recorded speed from SStatus.  Just return in this
> +	 * case.
>  	 */
>  	if (spd > 1)
>  		mask &= (1 << (spd - 1)) - 1;
>  	else
> -		mask &= 1;
> +		return -EINVAL;
>  
>  	/* were we already at the bottom? */
>  	if (!mask)

Without reverting the above patch, could you please try the following patch ?


diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index 22ecc4f3ae79..396aacc3fbd1 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -203,8 +203,6 @@ static int ahci_mvebu_probe(struct platform_device *pdev)
        if (rc)
                return rc;

-       hpriv->stop_engine = ahci_mvebu_stop_engine;
-
        rc = pdata->plat_config(hpriv);
        if (rc)
                goto disable_resources;


This essentially disables the use of ahci_mvebu_stop_engine() function for
your adapter, that is, it assumes that your newer adapter is not subject
to errata Ref#226. If this helps, then we can have a cleaner fix using the
compatible string for the adapter/SoC.

Otherwise, we will need to add a quirk for this adapter to have a behavior
for it that is the same as if patch 2dc0b46b5ea3 is reverted.

By the way, what is the maximum speed of you pmp box ? Is it really 1.5
Gbps (sata gen 1) ?


-- 
Damien Le Moal
Western Digital Research

