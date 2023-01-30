Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E202C54EED
	for <linux-ide@archiver.kernel.org>; Mon, 30 Jan 2023 02:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbjA3Cix (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 29 Jan 2023 21:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjA3Ciw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jan 2023 21:38:52 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AAF18AB3
        for <linux-ide@vger.kernel.org>; Sun, 29 Jan 2023 18:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675046330; x=1706582330;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=naGEuIGYV8by41xcQjn1A3CqdTpTHr4n7V+b/ax+p38=;
  b=f+m1eHjFwRS+0h6zwORhUuDBOjHh85iiW/V9gkRsFK5G9odG5dn1HcBI
   Hkk6CJY3kzi+L4sduF7bgvMakNNkbRxMm8Q+RYSv+ppSwuEfQ2kF6JZ9+
   DBfKVUEw8i3apo/ZACEYbXSLBIoC+4H30mDIILK1r7aLSDS1KFN++l2vK
   6HD0wR/t3O42vGEsdn0pzkZfavvrcEeVoNddatPAK1YwSV0Y5OtXfolU6
   XgrVst9yKZqFadCmLIeqi5YCz9PjBgcF1n/KWS71U8cI0vtaFRAWrt23T
   +zgIxDCCTyqyeGIU1uOfWLoJAt4Kh/HuMXG9e7HuK2HEzHs4bD5fdxm+K
   A==;
X-IronPort-AV: E=Sophos;i="5.97,257,1669046400"; 
   d="scan'208";a="222096250"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2023 10:38:50 +0800
IronPort-SDR: TaiEFtvev0wRRrOgpRHssFs2eCvDbKC1aE96xWDj/IuKfSn2TfUnFNNkiLPYJK4ELl5rXmSPm8
 jovRiRlR/qm96C+BCw0V1BXkCaoAmrjubbOH2WbdMNjdH+7PlvXf2P+daUbeiULbeJSVcD9kcQ
 u90UQi2zz9Ujk4lTXHTiZGjTaqmE4mOe+7y0ZIXj1AleLHYM4BIlFC2eKFKJOnStoZl5+HnW4g
 MrIhC1WblMwI8sNDK94whHeTak3AMwJ5Lo0M0z9a43y3RglJcr4X/8RNAgKl6mCXpibEwJX/Ph
 zP4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jan 2023 17:56:16 -0800
IronPort-SDR: y1nDQo7QM0FQfaEPvcRM9slX22QN2g6dvWK2AHk8hOK6QohK9Axd4iiTdd6GkHoAUzNmUOjydn
 OZQBSdOmNOC5LI1VaMVrcfrGwwdgUhy24eC7pMYrGkKc9850aVU9G2SEwaGMbo6ofX4BLgMX/p
 H1sqL5uftTkrbzw/SuLIbbPYULO1gN/9ouUCYLm22xByQeozLWqlSXzS/gOLTqhI23nm02CmgK
 eMegeKmonKU3jiqhtPU9G4PPe8DWNKVg/gRnsYue5GCO64ti3KcENs1VHbjYAxbOA8Y5qpAmBv
 0YM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jan 2023 18:38:49 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P4snP3vzcz1RvTp
        for <linux-ide@vger.kernel.org>; Sun, 29 Jan 2023 18:38:49 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675046329; x=1677638330; bh=naGEuIGYV8by41xcQjn1A3CqdTpTHr4n7V+
        b/ax+p38=; b=ayGr6gEXeTrm07YEa77yqXp/JqLvn6sL7oq6qC8YRtJ7p+IlasN
        7EaJ3Q7Gs9Nr7DPqIjhR+8NU+N7MsV9xYr/05Kjz8Jqw2/zOZUfIl8WJfkiaurry
        m2QCQ73bpq083ovP6LpzoJJxDGsGoFFNJg19bJ1SdBxXnqZ/pC621WxIRXHq2Lcb
        sbjWmalueE0ZDBGacqXNQuAujCDGdVL7jpPwPg7xWl8HBYGsSDe3xxJpodI6hQQX
        Wjv4bC2lc+ogPutAdTpmKe8XY8UMoLyNq8paMfmMxHMv4DgkuHw5GUeoBCnJlVfI
        iCEVkDo+hK1AmEpMPZxl/Yq5u8U0jzmG6lQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oyyRxO8ZF8H3 for <linux-ide@vger.kernel.org>;
        Sun, 29 Jan 2023 18:38:49 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P4snN5kvYz1RvLy;
        Sun, 29 Jan 2023 18:38:48 -0800 (PST)
Message-ID: <3c508c6e-5377-bb2d-64df-407f73a8170a@opensource.wdc.com>
Date:   Mon, 30 Jan 2023 11:38:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Bug report for ahci-mvebu driver
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <ceb87cfa-b9f9-525b-bd85-9728833e8687@opensource.wdc.com>
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
 <009822d6-24b8-739d-e7ee-13adc1c7d548@opensource.wdc.com>
 <55834657003f5a4579b326ee61fe1e80@psihoexpert.ro>
 <8cd8066ac1059ae0fef280a3cf6ab03c@psihoexpert.ro>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <8cd8066ac1059ae0fef280a3cf6ab03c@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/29/23 19:24, marius@psihoexpert.ro wrote:
> January 29, 2023 4:25 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.com> wrote:
>>
>> OK. That is because the limit is not being changed with the added "return 0".
>> What about this version:
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 884ae73b11ea..f404e2c2869e 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -3085,10 +3085,31 @@ int sata_down_spd_limit(struct ata_link *link, u32
>> spd_limit)
>> * If not, use cached value in link->sata_spd.
>> */
>> rc = sata_scr_read(link, SCR_STATUS, &sstatus);
>> - if (rc == 0 && ata_sstatus_online(sstatus))
>> + if (rc == 0 && ata_sstatus_online(sstatus)) {
>> spd = (sstatus >> 4) & 0xf;
>> - else
>> + } else {
>> + /*
>> + * If we reach here, the device is still offline or not
>> + * reporting a current speed yet. If we do not have a recorded
>> + * speed either, it means that probing the drive is failing,
>> + * most likely because problem with link speed autonegotiation
>> + * (e.g. reported case with mvebu adapter with a port multiplier
>> + * device). In this case, assume that probing was done at Gen3
>> + * speed and set the speed limit to the lower Gen2 speed.
>> + * With this, the next probe retry will be done after
>> + * sata_set_spd() explicitly lowers the link speed. If the
>> + * device then responds, the actual maximum speed will be set
>> + * once libata-eh finishes the device revalidation.
>> + */
>> + if (!link->sata_spd && link->sata_spd_limit == UINT_MAX) {
>> + link->sata_spd_limit = 2;
>> + ata_link_warn(link,
>> + "No reported SATA link speed. Limiting to
>> %s\n",
>> + sata_spd_string(link->sata_spd_limit));
>> + return 0;
>> + }
>> spd = link->sata_spd;
>> + }
>>
>> mask = link->sata_spd_limit;
>> if (mask <= 1)
>>
>> Does this work ?
>>
>> --
>> Damien Le Moal
>> Western Digital Research
> 
> 
> No, it doesn't work.

Apologies for asking you to test again, but could you try this simpler
version of the initial tweak:

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 884ae73b11ea..2ea572628b1c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3109,7 +3109,7 @@ int sata_down_spd_limit(struct ata_link *link, u32
spd_limit)
         */
        if (spd > 1)
                mask &= (1 << (spd - 1)) - 1;
-       else
+       else if (link->sata_spd)
                return -EINVAL;

        /* were we already at the bottom? */

This is a partial revert of the commit that created the issue in the
first place. But better check this is OK.


-- 
Damien Le Moal
Western Digital Research

