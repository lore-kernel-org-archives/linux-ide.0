Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038FBC54EAA
	for <linux-ide@archiver.kernel.org>; Fri, 27 Jan 2023 05:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjA0FNz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 27 Jan 2023 00:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjA0FNy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jan 2023 00:13:54 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686EE61859
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2023 21:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674796433; x=1706332433;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=L96VIbk2HCEa7P2tAVYA/oiCblHaaDKFvYW/vnHrfiE=;
  b=mf9P+Z2jKnHdRKeY1dMcP1YlmEHLZwsjt/HpzNZcdfDyaawU//Kbc8W2
   d48fwiuJ53IvWrf/cQRkhVCoPT+Gy2fiR9iYxhNrF3N91O9VeAMr1vFwF
   I/+PUObKjxqPCczqOTuGGAnIqaRKzNwwPEUv8H9HiYOgwyO3cjW9LpvD5
   iKj8fhhgXo/nhOaqBBTf3zepY22lArKGOwRvGysAxG/xUsTXBKG2L+XtU
   DoLWaIDbgyrnAXz2beJYG0KsLdSmabTcbl5szrQR01vSEveCmXGZfsDRi
   NjyIDLT6LpWDE4GnaaYILWCM2OLv7mgclPeNJDjrlkqsg4adfx3hX5JBs
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,250,1669046400"; 
   d="scan'208";a="326170982"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2023 13:13:52 +0800
IronPort-SDR: uIwegRX/D+6mUIYaThDb8pgqY2up2sKqHIWB1JEWMDEDwvo1TIswZgMjxtfiQR2yVSCmP8Q+JE
 Gfcu+DZerf8ww4jORhULhH6VSaiww7rYsAr/bsNLtP60IhFTyC3Nl/PnojXvOgMyW8chdkb2y/
 /GyOO2zUoExY0P3a7Ano+HBoDxE5Kg3B5XqpVvtSvF5LHzkfadrskiPTb+PA82HCZ5KFDc33S+
 LJWJEf8JY8sk0iHpUztJc2Xl6SIrSfePwNOURrus2WlWXe9lJKC2Luj5YVW+B/7lRIMVJ0Iosx
 SyM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jan 2023 20:25:38 -0800
IronPort-SDR: gu61Z9y/UTDaqoko0lpaNSncGgKQUuulzhUTF9HkDhostg4aQ60KFWkj+s8LgXe4+y4o2Lfee1
 jR4YvW+bP7dznDxWHtVS2LHCJk7JJqyxbfHFT4BnFv4hLv12QX5GPC7ecEv2qm/KYh9rhem7Tm
 MwcRChJFY41D7FI2yaRlG8HGf0+7VPaBGsLr+rErASvdVYKYdNg88wKlYuYi3XjXlTwKYZPg2X
 MVapxio72ouSS3Vwy9HVGasoQ6H2jBtpiftdMTLsNI7wRUpacLijKZOe9dIo1JXKbQ/W1rcQzE
 CE4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jan 2023 21:13:53 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P35Mh37Qgz1RvTp
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2023 21:13:52 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:content-language:references:to:subject
        :from:user-agent:mime-version:date:message-id; s=dkim; t=
        1674796432; x=1677388433; bh=L96VIbk2HCEa7P2tAVYA/oiCblHaaDKFvYW
        /vnHrfiE=; b=Vp7on0Na5rVLbhTc78t4e6A5fszTTYfmmOPBkbYsbLfH4fHmFB7
        bCvQW4rd6iAwRpsDZG4RXHjD/bHdOo1qW7JeZzrak33SN82IinNr8qBKa5nsO021
        FqR10GgD2IvNt5/N+AN2/Ws5RrIvy4BRU7k/z7QCibgr9kR5bYM1gS0ePhG/lzcO
        9sxYFQGTipNOXExA4/6NPbeIBGf9BVmExv7+NsIqHzWfeuibjEGdCZ352f3mPk8/
        FtuvJMNuzsVULHo/gdKCR1sxPuuqMCqTflf+4UrgDAiCzaW32c3MoGww6aXUvEbg
        Q6N73x+8aRAzTFJTet+XfL7g0sreLJtLjEQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 44VHYEGk7dea for <linux-ide@vger.kernel.org>;
        Thu, 26 Jan 2023 21:13:52 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P35Mg4pp9z1RvLy;
        Thu, 26 Jan 2023 21:13:51 -0800 (PST)
Message-ID: <009822d6-24b8-739d-e7ee-13adc1c7d548@opensource.wdc.com>
Date:   Fri, 27 Jan 2023 14:13:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: Bug report for ahci-mvebu driver
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <f4d558fd-343a-8cb5-605d-574af42ad3db@opensource.wdc.com>
 <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
 <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
 <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
 <29aff79be06b7dacb97c13cbff07fabb@psihoexpert.ro>
 <97af1ef9ed605800e6ad43b7b3518800@psihoexpert.ro>
 <aa61bc53-34e2-4f19-962f-888e9daabbb4@opensource.wdc.com>
 <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
 <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
 <1b74a7e40419b6f99870c21ca3be7834@psihoexpert.ro>
 <77b389a080646567b9f9d44caa42d547@psihoexpert.ro>
 <da1d366a494469a46eb066b167613e21@psihoexpert.ro>
 <d42ddd29171c69e9a6628bfc2b100aca@psihoexpert.ro>
 <44527e2f8583a8ce51b1241bf9e56595@psihoexpert.ro>
 <45337bf4a17c9c879f9439c1138bc443@psihoexpert.ro>
 <7fe0b96f30bf787d339ba656d5d2df01@psihoexpert.ro>
 <db3fa398d4a1dcadb9df02d1001a61c6@psihoexpert.ro>
 <c7e1b214fca6c2a08dbce60006442dd8@psihoexpert.ro>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <c7e1b214fca6c2a08dbce60006442dd8@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/25/23 02:02, marius@psihoexpert.ro wrote:
> January 24, 2023 11:54 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.com> wrote:
> 
>> OK. Good. But from the trace below, it looks like you have the previous
>> patch still applied. Can you try only the above patch ?
> 
> Done:
> [ 15.135173][ T113] hardreset, Online=>Offline
> [ 15.135182][ T113] sata_set_spd_needed, scontrol=0x300
> [ 15.139656][ T113] __sata_set_spd_needed, initial limit=0xFFFFFFFF
> [ 15.144934][ T113] __sata_set_spd_needed, corrected limit=0xFFFFFFFF
> [ 15.151235][ T113] __sata_set_spd_needed, target=0x0
> [ 15.157725][ T113] __sata_set_spd_needed, spd=0x0
> [ 15.162805][ T113] __sata_set_spd_needed, final *scontrol=0x300
> [ 15.168708][ T113] resume, do loop
> [ 15.403902][ T113] resume, after do loop
> [ 15.463901][ T113] debounce, SCR=0x100

[...]

> [ 16.413901][ T113] debounce, SCR=0x0
> [ 16.473901][ T113] debounce, SCR=0x100
> [ 16.477586][ T113] resume, return at end of function
> [ 16.481446][ T113] hardreset, ata_phys_link_offline check failed
> [ 16.486550][ T113] ata2: SATA link down (SStatus 100 SControl 300)
> [ 16.499019][ T113] sata_down_spd_limit: limit 0x1, cur spd 0x0, saved limit 0xffffffff, hw limit
> 0xffffffff
> [ 16.508914][ T113] ata2: limiting SATA link speed to 1.5 Gbps

Marius,

Thanks again for testing.
Could you try a new variation of the fix shown below ? This newer fix
should avoid uselessly going down to 1.5 Gbps as shown above.
Thanks !

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 884ae73b11ea..04938db566e5 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3085,10 +3085,31 @@ int sata_down_spd_limit(struct ata_link *link, u32
spd_limit)
         * If not, use cached value in link->sata_spd.
         */
        rc = sata_scr_read(link, SCR_STATUS, &sstatus);
-       if (rc == 0 && ata_sstatus_online(sstatus))
+       if (rc == 0 && ata_sstatus_online(sstatus)) {
                spd = (sstatus >> 4) & 0xf;
-       else
+       } else {
+               /*
+                * If we reach here, the device is still offline or not
+                * reporting a current speed yet. If we do not have a recorded
+                * speed either, it means that probing the drive is failing,
+                * most likely because problem with link speed autonegotiation
+                * (e.g. reported case with mvebu adapter with a port multiplier
+                * device). In this case, assume that probing was done at Gen3
+                * speed and set the recorded speed to lower Gen2. With this,
+                * the next probe retry will be done after sata_set_spd()
+                * explicitly lowers the link speed. If the device then
+                * responds, the actual maximum speed will be set once
+                * libata-eh finishes the device revalidation.
+                */
+               if (!link->sata_spd) {
+                       link->sata_spd = 2;
+                       ata_link_warn(link,
+                                     "No reported link speed. Assuming %s\n",
+                                     sata_spd_string(link->sata_spd));
+                       return;
+               }
                spd = link->sata_spd;
+       }

        mask = link->sata_spd_limit;
        if (mask <= 1)

-- 
Damien Le Moal
Western Digital Research

