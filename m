Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679A0C63797
	for <linux-ide@archiver.kernel.org>; Tue, 17 Jan 2023 08:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbjAQI1E (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Jan 2023 03:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbjAQI1C (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jan 2023 03:27:02 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1A81F5D4
        for <linux-ide@vger.kernel.org>; Tue, 17 Jan 2023 00:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673944021; x=1705480021;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ptI7mkYpjHai6ZIelGxqKU169PGSXEAyF5WjQa/lMQ4=;
  b=eEUWliM94NSOc7x/LgxKR/cpX5qOX7hqSJr9l3jA7Oly2LAuL7Ds5ENf
   4oUGHtksEoplzZpsv5RhpVZhkitFgB+lB9T9gWK/65NIJqFMW9owWCey0
   vZjTrGUnXzlFg4B6Co6Oz47yCeGV/KhlSzpdb6mnG/SBsUenp0+Bhn2eo
   dvh1Fdc8nIAhLjegV+irhg1nYXyFlJX8Dglm7UBeo0xR67nk4pRf+eUzk
   EDX9zz8D6Inq0hFOsSiuEgSLHVOa4XJssnpzY8aumuCzLjVRl12avusJJ
   5ZSB2uwOuWRCQaSagrOKTLQupAP3WT0EdKipHKDFoEIiqLAeQfeHOz111
   g==;
X-IronPort-AV: E=Sophos;i="5.97,222,1669046400"; 
   d="scan'208";a="325293592"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2023 16:27:00 +0800
IronPort-SDR: 9oJUWjO92e+4SRpW0j+NaZ5CcbGf6zrLxFs5eRZrplayHkGQBQHYSYKdRogQEKLmRxGXvXT11c
 Ajk8AFVBHU+kdZ7Z5G79CaVUfkgug9RQQEJBiUWCxuVLpGCzWlb3PGWssLS/SuNiEQcIyCLcnm
 0xEefBfvlCuJtvyn01XA2iNDFXSv0MoVv5/kxuXI37GLjgA9PNukP+UhghMar3uGCI+4UPOTwl
 gnstRI/jmA7UMNEdpUgTqVTOE0I2LAXmYvFuWsU5x8U78BJfPa2JoC3GZ6+K2fZdliZDRAJYRK
 Sks=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2023 23:38:58 -0800
IronPort-SDR: kp/3BBfyIMOZ1VOxSBXbCjauadpvdzF5xsDDCQSUgIaCtnwdWniC/cBN4IY0qbS84jaEBRtUhM
 RLDJv6ytS2TsJsNQ3O41ABTEV17xjyD9chr5m1v11aNTutdS1Jp3gyLncepoJe+TwWwwESub2m
 HiS9Iom15SaNX1oaD4QJqdPzMQ3qRaRdoHLKd1+8XS/bLfSUdNVjXsOWrL13R5M9OcB2Oju0Fy
 loSggR6tpe5hfnmFgpcdhKDRoPnrJenRl3W7RnTqI9CC7tBde7kPLxHEic68w+agRXo/xsEFl3
 KRo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jan 2023 00:27:00 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nx2782yyqz1RvTr
        for <linux-ide@vger.kernel.org>; Tue, 17 Jan 2023 00:27:00 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673944020; x=1676536021; bh=ptI7mkYpjHai6ZIelGxqKU169PGSXEAyF5W
        jQa/lMQ4=; b=j71Piu1crC6+v2u2N/YCTvrLiOSks9MiMqGVIdq5ocR2Dpsnrv3
        VKiZlu/xIls83xJRnOwX5l4rLbAaICeMglbE7cKFfU2XrhImDxLswp1vwPK5DjT/
        VaG+fr+WIPlunE1A2bi+0doLlrMsjscYPh/SXyzxLqboRkngVW2T+b+PMevzWX6g
        pGtMsBHu11irCBQ7/PjZ23NELbnmlcA0XmkkaKK+K7PLVB1a6ZAcQ+klMAVEJyTs
        ek1ojKy/k/kDAOaeDSQpiavTCr0WjMaxA/5Q+zPDDCM2sZk8dfBgyQ+UWD9S8skz
        KMJtnop9f8OgQnXUmoJckewkQ6rzCUKkBcw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 99YneGmFwyZi for <linux-ide@vger.kernel.org>;
        Tue, 17 Jan 2023 00:27:00 -0800 (PST)
Received: from [10.225.163.30] (unknown [10.225.163.30])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nx2774VTJz1RvLy;
        Tue, 17 Jan 2023 00:26:59 -0800 (PST)
Message-ID: <41774337-a8d9-a2de-72ea-27b6016ff720@opensource.wdc.com>
Date:   Tue, 17 Jan 2023 17:26:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <b6d818c162b14cc508f5cdb14c6e88a9@psihoexpert.ro>
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
 <1b74a7e40419b6f99870c21ca3be7834@psihoexpert.ro>
 <77b389a080646567b9f9d44caa42d547@psihoexpert.ro>
 <da1d366a494469a46eb066b167613e21@psihoexpert.ro>
 <d42ddd29171c69e9a6628bfc2b100aca@psihoexpert.ro>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d42ddd29171c69e9a6628bfc2b100aca@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/15/23 03:01, marius@psihoexpert.ro wrote:
> Do you need any more tests?
> 
> 
> December 9, 2022 8:30 PM, marius@psihoexpert.ro wrote:
> 
>> December 9, 2022 11:28 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.com> wrote:
>>
>>>> [ 19.006105][ T113] Reconfig spd
>>>
>>> Which function did you add this message to ?
>>
>> sata_link_hardreset(), inside if(sata_set_spd_needed(link)){} condition,
>> but I replaced it with detailed debug inside sata_set_spd_needed() and ___sata_set_spd_needed()

Could you try adding messages in the function sata_down_spd_limit() ?
I recall that during probe, scr status does not give a current speed,
which creates the problem of triggering that "return -EINVAL" in the else
for "if (spd > 1)"...

What I would like you to print is:

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 884ae73b11ea..ad68f86be1c5 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3081,14 +3081,21 @@ int sata_down_spd_limit(struct ata_link *link, u32
spd_limit)
        if (!sata_scr_valid(link))
                return -EOPNOTSUPP;

+       pr_info("sata_down_spd_limit: limit 0x%0x, cur spd 0x%0x, "
+               "saved limit 0x%0x, hw limit 0x%0x\n",
+               spd_limit, link->sata_spd
+               link->sata_spd_limit, link->hw_sata_spd_limit);
+
        /* If SCR can be read, use it to determine the current SPD.
         * If not, use cached value in link->sata_spd.
         */
        rc = sata_scr_read(link, SCR_STATUS, &sstatus);
-       if (rc == 0 && ata_sstatus_online(sstatus))
+       if (rc == 0 && ata_sstatus_online(sstatus)) {
                spd = (sstatus >> 4) & 0xf;
-       else
+               pr_info("spd from STS: 0x%0x\n", spd);
+       } else {
                spd = link->sata_spd;
+       }

        mask = link->sata_spd_limit;
        if (mask <= 1)

Please try printing that in addition to the messages you already have. And
please try with default boot (no ata options) and with the 1.5gbps force
(since that is the only one working).

-- 
Damien Le Moal
Western Digital Research

