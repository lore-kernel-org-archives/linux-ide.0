Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494AFC05027
	for <linux-ide@archiver.kernel.org>; Mon, 30 Jan 2023 01:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjA3BQe (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 29 Jan 2023 20:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbjA3BQc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jan 2023 20:16:32 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EFF16316
        for <linux-ide@vger.kernel.org>; Sun, 29 Jan 2023 17:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675041387; x=1706577387;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+KGeFztFKxxZ/VEoN1a5y50gV7TmqCaN3+bx0j9Y4JM=;
  b=OtKlGjHuq2maHxaMhrrUNrEvbTeGdYBLoD62H4J0A7w+aKsdnC6xp348
   mqLnUdGXfUgJIA641liZsUg9uZ2A6a7WAOzg4TknfEV5Moqk2baGAf4bJ
   TigvgSJIDWq5JAHMaLZSm2oferXlRLp55dIVYH0eaHFVwvGuY9brQY9Y+
   K2CKsIqJDHPkFgD3h6Ca4kbgeHCIW4dIIrJOlGlVehghwtfyPWip14RlZ
   xZ6Ye5TEHFMsvCMYnCug8LtQmSl2UmpBXLprOAHN+hy6WPQ7pYCmUrOmC
   kqKfSAFU7/4/2rk+KDCStzLrBa/RLYwkR4oPhnnxXbVWrlmvwkSfjqutu
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,256,1669046400"; 
   d="scan'208";a="227005790"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2023 09:16:27 +0800
IronPort-SDR: ysqz+Fnm0TBOjTFF3dyvbYC1gfDzYS04yeXFHTk1NEoRwuJr/n7CVcYrLbM/AOZ8vhnmCqS32u
 Jhz6xkoROeJ0mRO8M5atr7DwXCHCSKaIHFEVgw6emSeKzi6SQ3NOpzAEJGVHxE5a7V0DRXr48U
 kPpRyH76ihdC4xPfywacU5hUZWmfCKckCWupzH8T8Nw6ZskHN2nRkH8/Dshvgr8Frja8mXbx68
 ewDygiCd654Dj/6FnUIgz1uRVntvCnaK1V72fod9nPMHloFAhrp6ep6joJv4lrlMVO5MEkAlGQ
 OeI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jan 2023 16:28:09 -0800
IronPort-SDR: NwuRBpHF1bfR3Y6JYbCeHSvolkLfAxu6DP7SO/lkUZuOZUU1+bGbM3GopL6sp334n4AiTEzGrS
 i+MZJQuZJi9oRskejnucgsd5ODLQ4KIv0qKLL8luVeIUkF8R4ZQmJ6T931q6kGdEtPmlzDp1dQ
 QnRAX46TixgdXwLlWpP55X0KMP5NymDB0Ar8ygsxn6ofrLER9MT1ggOK5hfx0T7YcPZlecUQQf
 gtSD1Bvc29gNsRJOzxQhwwF9DsbWlWidMG9NorKyNOkHhAYeoYisOn/xrJHdn0bV1NYuNdIhMI
 0AM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jan 2023 17:16:27 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P4qyM0b2Cz1RvTp
        for <linux-ide@vger.kernel.org>; Sun, 29 Jan 2023 17:16:27 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675041386; x=1677633387; bh=+KGeFztFKxxZ/VEoN1a5y50gV7TmqCaN3+b
        x0j9Y4JM=; b=J9O6/KSjWSJrq/a/4aahGM7hxkorfB8QdwmmnNJvR3xocWoLlon
        5HEvY55aSTBhbzNJqurkmu3bCGlFRcOKqeaJVNsWDhbaOyHvUYo25lxdUlSpcUAY
        ZNKSVNHF3OL/bB58+Rem3bP/VrdcjpF+VtLF/jSVcv8FkMK2kapAHu3/jwryNvKM
        zP1Gw/BdVw+ekESJUXyXyC4dvaY2xCteo+lASGpbuAOGuLlUDlRZ78kRxXWKK1vu
        frrHbHJC1ZydNSVF6vMmqmQebi1YSd1x7GqW+RrpaYhbh0G3j8I8HcnBo6wTl5PF
        VxI3dhFBMUHjudLpTCNUqME9/bYEjt1NL8g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nSnc9ysSAAjw for <linux-ide@vger.kernel.org>;
        Sun, 29 Jan 2023 17:16:26 -0800 (PST)
Received: from [10.89.81.41] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.81.41])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P4qyL1TD6z1RvLy;
        Sun, 29 Jan 2023 17:16:26 -0800 (PST)
Message-ID: <949cb9c5-8f38-72d4-e8bb-c367be602347@opensource.wdc.com>
Date:   Mon, 30 Jan 2023 10:16:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
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

On 2023/01/29 19:24, marius@psihoexpert.ro wrote:
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

OK. So it seems that your adapter really wants the initial scan at 1.5 Gbps...
Since the initial tweak worked, I will post the official patch for it. I will CC
you. Please retest to be sure and send a "Tested-by:" tag ! Thanks !

> 
> [   29.743388][  T113] hardreset, Online=>Offline
> [   29.743397][  T113] sata_set_spd_needed, scontrol=0x300
> [   29.747893][  T113] __sata_set_spd_needed, initial limit=0xFFFFFFFF
> [   29.753149][  T113] __sata_set_spd_needed, corrected limit=0xFFFFFFFF
> [   29.759464][  T113] __sata_set_spd_needed, target=0x0
> [   29.765953][  T113] __sata_set_spd_needed, spd=0x0
> [   29.771033][  T113] __sata_set_spd_needed, final *scontrol=0x300
> [   29.776937][  T113] resume, do loop
> [   30.003803][  T113] resume, after do loop
> [   30.063823][  T113] debounce, SCR=0x100
> ...
> [   31.443802][  T113] debounce, SCR=0x100
> [   31.447663][  T113] resume, return at end of function
> [   31.451522][  T113] hardreset, ata_phys_link_offline check failed
> [   31.456625][  T113] ata2: SATA link down (SStatus 100 SControl 300)
> [   31.469093][  T113] sata_down_spd_limit: limit 0x1, cur spd 0x0, saved limit 0xffffffff, hw limit 0xffffffff
> [   31.478986][  T113] ata2: No reported SATA link speed. Limiting to 3.0 Gbps
> [   31.486004][  T113] hardreset, Online=>Offline
> [   31.486010][  T113] sata_set_spd_needed, scontrol=0x300
> [   31.490479][  T113] __sata_set_spd_needed, initial limit=0x2
> [   31.495747][  T113] __sata_set_spd_needed, corrected limit=0x2
> [   31.501437][  T113] __sata_set_spd_needed, target=0x2
> [   31.507321][  T113] __sata_set_spd_needed, spd=0x0
> [   31.512401][  T113] __sata_set_spd_needed, final *scontrol=0x320
> [   31.517233][  T113] __sata_set_spd_needed, initial limit=0x2
> [   31.523272][  T113] __sata_set_spd_needed, corrected limit=0x2
> [   31.528975][  T113] __sata_set_spd_needed, target=0x2
> [   31.534852][  T113] __sata_set_spd_needed, spd=0x0
> [   31.539933][  T113] __sata_set_spd_needed, final *scontrol=0x324
> [   31.545834][  T113] resume, do loop
> [   31.773802][  T113] resume, after do loop
> [   31.833802][  T113] debounce, SCR=0x101
> ...
> [   32.433802][  T113] debounce, SCR=0x100
> [   32.437663][  T113] resume, return at end of function
> [   32.441522][  T113] hardreset, ata_phys_link_offline check failed
> [   32.446624][  T113] ata2: SATA link down (SStatus 100 SControl 320)
> [   32.459090][  T113] sata_down_spd_limit: limit 0x1, cur spd 0x0, saved limit 0xffffffff, hw limit 0xffffffff
> [   32.468982][  T113] ata2: No reported SATA link speed. Limiting to 3.0 Gbps
> [   32.475999][  T113] hardreset, Online=>Offline
> [   32.476005][  T113] sata_set_spd_needed, scontrol=0x320
> [   32.480474][  T113] __sata_set_spd_needed, initial limit=0x2
> [   32.485741][  T113] __sata_set_spd_needed, corrected limit=0x2
> [   32.491432][  T113] __sata_set_spd_needed, target=0x2
> [   32.497315][  T113] __sata_set_spd_needed, spd=0x2
> [   32.502395][  T113] __sata_set_spd_needed, final *scontrol=0x320
> [   32.508296][  T113] resume, do loop
> [   32.743801][  T113] resume, after do loop
> [   32.803802][  T113] debounce, SCR=0x100
> ...
> [   34.423802][  T113] debounce, SCR=0x100
> [   34.427662][  T113] resume, return at end of function
> [   34.431520][  T113] hardreset, ata_phys_link_offline check failed
> [   34.436624][  T113] ata2: SATA link down (SStatus 100 SControl 320)
> [   34.449088][  T113] sata_down_spd_limit: limit 0x1, cur spd 0x0, saved limit 0xffffffff, hw limit 0xffffffff
> [   34.458981][  T113] ata2: No reported SATA link speed. Limiting to 3.0 Gbps
> [   34.465998][  T113] hardreset, Online=>Offline
> [   34.466004][  T113] sata_set_spd_needed, scontrol=0x320
> [   34.470473][  T113] __sata_set_spd_needed, initial limit=0x2
> [   34.475740][  T113] __sata_set_spd_needed, corrected limit=0x2
> [   34.481430][  T113] __sata_set_spd_needed, target=0x2
> [   34.487314][  T113] __sata_set_spd_needed, spd=0x2
> [   34.492393][  T113] __sata_set_spd_needed, final *scontrol=0x320
> [   34.498294][  T113] resume, do loop
> [   34.723823][  T113] resume, after do loop
> [   34.783802][  T113] debounce, SCR=0x101
> ...
> [   36.763802][  T113] debounce, SCR=0x100
> [   36.767662][  T113] debounce, loop end with timeout
> [   36.771521][  T113] hardreset, sata_link_resume check failed
> [   36.776445][  T113] ata2: COMRESET failed (errno=-32)
> [   36.787224][  T113] ata2: reset failed (errno=-32), retrying in 8 secs
> [   44.643801][  T113] sata_down_spd_limit: limit 0x0, cur spd 0x0, saved limit 0x2, hw limit 0xffffffff
> [   44.653073][  T113] hardreset, Online=>Offline
> [   44.653079][  T113] sata_set_spd_needed, scontrol=0x320
> [   44.657569][  T113] __sata_set_spd_needed, initial limit=0x2
> [   44.662823][  T113] __sata_set_spd_needed, corrected limit=0x2
> [   44.668527][  T113] __sata_set_spd_needed, target=0x2
> [   44.674403][  T113] __sata_set_spd_needed, spd=0x2
> [   44.679484][  T113] __sata_set_spd_needed, final *scontrol=0x320
> [   44.685385][  T113] resume, do loop
> [   44.913802][  T113] resume, after do loop
> [   44.973802][  T113] debounce, SCR=0x100
> ...
> [   46.233802][  T113] debounce, SCR=0x100
> [   46.237663][  T113] resume, return at end of function
> [   46.241520][  T113] hardreset, ata_phys_link_offline check failed
> [   46.246622][  T113] ata2: SATA link down (SStatus 100 SControl 320)
> [   46.259088][  T113] sata_down_spd_limit: limit 0x1, cur spd 0x0, saved limit 0xffffffff, hw limit 0xffffffff
> [   46.268981][  T113] ata2: No reported SATA link speed. Limiting to 3.0 Gbps
> [   46.275997][  T113] hardreset, Online=>Offline
> [   46.276003][  T113] sata_set_spd_needed, scontrol=0x320
> [   46.280473][  T113] __sata_set_spd_needed, initial limit=0x2
> [   46.285740][  T113] __sata_set_spd_needed, corrected limit=0x2
> [   46.291430][  T113] __sata_set_spd_needed, target=0x2
> [   46.297314][  T113] __sata_set_spd_needed, spd=0x2
> [   46.302394][  T113] __sata_set_spd_needed, final *scontrol=0x320
> [   46.308296][  T113] resume, do loop
> [   46.543802][  T113] resume, after do loop
> [   46.603802][  T113] debounce, SCR=0x100
> ...
> [   47.683802][  T113] debounce, SCR=0x100
> [   47.687662][  T113] resume, return at end of function
> [   47.691520][  T113] hardreset, ata_phys_link_offline check failed
> [   47.696636][  T113] ata2: SATA link down (SStatus 101 SControl 320)
> [   47.709086][  T113] ata2: EH pending after 5 tries, giving up
> 
> Marius Dinu
> 

-- 
Damien Le Moal
Western Digital Research

