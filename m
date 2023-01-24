Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD1DC25B4E
	for <linux-ide@archiver.kernel.org>; Tue, 24 Jan 2023 09:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbjAXJyJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 24 Jan 2023 04:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjAXJyJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2023 04:54:09 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAAB3E603
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2023 01:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674554042; x=1706090042;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OxAdlr5vKCGlKAgvRbqDlCnO25gAY1hdV8U56XtrzxQ=;
  b=MtryVIvPBY8nE42ilywS7ICKoYYLs4LeOH9hm1HpqqvkvLTzhkxmIRYQ
   lAxGSIjFdHWJ1OZQPnZU2IRIjGuCS/zlE069XTmVMUMMbzl3VDdDbXosb
   J0GIgPMfidb88pX75SYz9LAOb5i2tZin2jQKAYJa/pMoJ+7wu9IPQQBiL
   avwfCm19uzoPEc7g7yQ4WkaDUjjpVThPsRZQrH1QjcB8hJwPg6+GMWYv+
   QC+cUHZWXkHc50SQ5Kul9DgpToh21P5cjC+jnzY52QPfUbkoW5eyyzDOP
   GOF6jC3TdMmb3I8lqm9mvH75MudSd5pkRXbuTzydKjSy21k6CRSVphsOM
   w==;
X-IronPort-AV: E=Sophos;i="5.97,242,1669046400"; 
   d="scan'208";a="221434874"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2023 17:54:01 +0800
IronPort-SDR: Ql4rJVne+KH1Ymw1skWeXh4nn2QwFo5A+6BgDS4cTHxlXVlXD7LwLAr4/92rYk0hV+QrTecpZW
 5n9VEeB9Ya/h+Bp8tLCkSD442LLdXA5n74SUyCSdsjb3PCSHR6bNxqHU+Ic+beF3fji8FhmUPr
 ArmHhUR6jm9EimqdDEow+ra1qUBVi0qxQE6lz8QEfi/p+Ms0JEtSD9L0j8Bw58mn2k1dhbkxL2
 z4iU1C0niS2XHiLESEtoH9whk+g9dFtzk5e2w0RDSJeSFvwyB808d20BIjy6FySfBNl4fGaZzQ
 Y2g=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2023 01:11:34 -0800
IronPort-SDR: 5xb+FdlG2m8KMnCXgPht7b2I8FPDj3qHtD6mG2QEG0ZRcfG78hqmh1U8TZJs1PwOxT0BXBS/jK
 Sr4VoQ5VsN8VAW/6LdDZ1I/wWtmhd4YBpxQhFWQ4rXvT6BtGz5efvoOtkDP1uVYcoyrx7hjGO9
 FSG6uYSsKTgwR+9x+zJT3mogmfthy//cm3QwHKj+JlHW4CFVoE/UleBwSYKtv1crjSpt1kU4hp
 usqe13ghTiwYkBvgnk7f6iwQp0oiEJi/Az3CBaX1q6pTodHYqIeF76kp8KWQtp77JVTj8zUFIX
 YEA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2023 01:54:02 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P1MkK1gxXz1RvTp
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2023 01:54:01 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674554040; x=1677146041; bh=OxAdlr5vKCGlKAgvRbqDlCnO25gAY1hdV8U
        56XtrzxQ=; b=haoltc6OhUgZ+THvU16OpQ4uVTA54Ys5lXe9krrhJtNOMCmV+I2
        P9VVHeRhTl44hwvyDeIyv99GERVHYDxpOhRmTaeA9mBxkX2pZKSKKPAurcY1vXQQ
        3lDDL4YzaxrsbClx+Ze6ZfP5izp3NflpqgBzk6ODQnAPaHgu6q/LNOWoG3CzHcYO
        yNVAyfB3+isMTuhXGJA7S0TR8G9fWSTLqnwlLRwvOVNrj5rR8uDck36Kjar8DcY/
        VSbm0XtMKdTDEH6rUc/L4YA/C4sXR0IgpC28k5hKdTSnDai5xzJTmq7K04ejd8ef
        +P0ZObE2YTrpG0ET84+i9WlfCDdrmzFlRuw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pS7-OLfRWx3P for <linux-ide@vger.kernel.org>;
        Tue, 24 Jan 2023 01:54:00 -0800 (PST)
Received: from [10.225.163.51] (unknown [10.225.163.51])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P1MkJ0vSNz1RvLy;
        Tue, 24 Jan 2023 01:53:59 -0800 (PST)
Message-ID: <f4d558fd-343a-8cb5-605d-574af42ad3db@opensource.wdc.com>
Date:   Tue, 24 Jan 2023 18:53:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <fa7f7eea-7b43-f2d7-18e5-f253ed316919@opensource.wdc.com>
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
 <44527e2f8583a8ce51b1241bf9e56595@psihoexpert.ro>
 <45337bf4a17c9c879f9439c1138bc443@psihoexpert.ro>
 <7fe0b96f30bf787d339ba656d5d2df01@psihoexpert.ro>
 <db3fa398d4a1dcadb9df02d1001a61c6@psihoexpert.ro>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <db3fa398d4a1dcadb9df02d1001a61c6@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/24/23 17:04, marius@psihoexpert.ro wrote:
> January 24, 2023 1:00 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.com> wrote:
> 
>>> I think that the old behaviour (before commit
>>> 2dc0b46b5ea30f169b0b272253ea846a5a281731) of slowing down sata speed
>>> when a connection can't be established is in fact the right thing to
>>> do. Maybe a longer delay before reducing the link speed would satisfy
>>> the random cases that the commit author reported. Maybe he was just
>>> having a loose connector issue - especially since he only reported one
>>> case.
>>
>> I do not think that a longer delay will change anything in your case since
>> the device presence cannot be established when starting speed negotiation
>> without a limit: see the "debounce, SCR=0x100" messages in your debug,
>> while the 1.5gbps link speed forcing leads to an immediate device presence
>> detected (debounce, SCR=0x113 message).
> 
> I was referring to the original "bug" the commit author (David Milburn) was trying to fix.
> 
>> Can you please try this one:
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 884ae73b11ea..a4e2a93af0e5 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -3085,10 +3085,17 @@ int sata_down_spd_limit(struct ata_link *link, u32
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
>> + * Device is not reporting a speed yet. Use the last recorded
>> + * speed. If we do not have that either, start with Gen3
>> speed.
>> + */
>> + if (!link->sata_spd)
>> + link->sata_spd = 3;
>> spd = link->sata_spd;
>> + }
>>
>> mask = link->sata_spd_limit;
>> if (mask <= 1)
> 
> It works.

OK. Good. But from the trace below, it looks like you have the previous
patch still applied. Can you try only the above patch ?

> 
> [   19.408712][  T113] hardreset, Online=>Offline
> [   19.408721][  T113] sata_set_spd_needed, scontrol=0x330
> [   19.413195][  T113] __sata_set_spd_needed, initial limit=0xFFFFFFFF
> [   19.418473][  T113] __sata_set_spd_needed, corrected limit=0xFFFFFFFF
> [   19.424789][  T113] __sata_set_spd_needed, target=0x3
> [   19.431265][  T113] __sata_set_spd_needed, spd=0x3
> [   19.436358][  T113] __sata_set_spd_needed, final *scontrol=0x330
> [   19.442248][  T113] resume, do loop
> [   19.673966][  T113] resume, after do loop
> [   19.733966][  T113] debounce, SCR=0x100
> [   19.793965][  T113] debounce, SCR=0x100
> [   19.853965][  T113] debounce, SCR=0x100
> [   19.913966][  T113] debounce, SCR=0x100
> [   19.973965][  T113] debounce, SCR=0x100
> [   20.033966][  T113] debounce, SCR=0x100
> [   20.093966][  T113] debounce, SCR=0x100
> [   20.153965][  T113] debounce, SCR=0x0
> [   20.213987][  T113] debounce, SCR=0x0
> [   20.217673][  T113] resume, return at end of function
> [   20.221358][  T113] hardreset, ata_phys_link_offline check failed
> [   20.226462][  T113] ata2: SATA link down (SStatus 0 SControl 330)
> [   20.321504][  T113] sata_down_spd_limit: limit 0x1, cur spd 0x0, saved limit 0xffffffff, hw limit 0xffffffff
> [   20.331407][  T113] ata2: limiting SATA link speed to 1.5 Gbps
> [   20.337294][  T113] hardreset, Online=>Offline
> [   20.337300][  T113] sata_set_spd_needed, scontrol=0x330
> [   20.341770][  T113] __sata_set_spd_needed, initial limit=0x1
> [   20.347037][  T113] __sata_set_spd_needed, corrected limit=0x1
> [   20.352728][  T113] __sata_set_spd_needed, target=0x1
> [   20.358605][  T113] __sata_set_spd_needed, spd=0x3
> [   20.363684][  T113] __sata_set_spd_needed, final *scontrol=0x310
> [   20.368515][  T113] __sata_set_spd_needed, initial limit=0x1
> [   20.374576][  T113] __sata_set_spd_needed, corrected limit=0x1
> [   20.380267][  T113] __sata_set_spd_needed, target=0x1
> [   20.386144][  T113] __sata_set_spd_needed, spd=0x3
> [   20.391223][  T113] __sata_set_spd_needed, final *scontrol=0x314
> [   20.397127][  T113] resume, do loop
> [   20.623966][  T113] resume, after do loop
> [   20.683966][  T113] debounce, SCR=0x113
> [   20.733987][  T113] debounce, SCR=0x113
> [   20.793966][  T113] debounce, SCR=0x113
> [   20.853965][  T113] debounce, SCR=0x113
> [   20.913966][  T113] debounce, SCR=0x113
> [   20.973965][  T113] debounce, SCR=0x113
> [   21.033966][  T113] debounce, SCR=0x113
> [   21.093966][  T113] debounce, SCR=0x113
> [   21.153965][  T113] debounce, SCR=0x113
> [   21.157826][  T113] resume, return at end of function
> [   21.161684][  T113] hardreset, Offline=>Online
> [   21.171249][  T113] hardreset, sata_pmp_supported, before check_ready
> [   21.343968][  T113] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [   21.357696][  T113] ata2.15: Port Multiplier 1.2, 0x197b:0x0325 r193, 8 ports, feat 0xf/0x1f
> [   21.366318][  T113] device: 'link2.0': device_add
> [   21.371124][  T113] device: 'link2.0': device_add
> [   21.376120][  T113] device: 'dev2.0.0': device_add
> [   21.380966][  T113] device: 'dev2.0.0': device_add
> [   21.385953][  T113] device: 'link2.1': device_add
> [   21.390711][  T113] device: 'link2.1': device_add
> [   21.395569][  T113] device: 'dev2.1.0': device_add
> [   21.400437][  T113] device: 'dev2.1.0': device_add
> [   21.405469][  T113] device: 'link2.2': device_add
> [   21.410232][  T113] device: 'link2.2': device_add
> [   21.415086][  T113] device: 'dev2.2.0': device_add
> [   21.419937][  T113] device: 'dev2.2.0': device_add
> [   21.424910][  T113] device: 'link2.3': device_add
> [   21.429669][  T113] device: 'link2.3': device_add
> [   21.434528][  T113] device: 'dev2.3.0': device_add
> [   21.439374][  T113] device: 'dev2.3.0': device_add
> ...
> [   21.640403][  T113] device: 'link2.14': device_add
> [   21.645287][  T113] device: 'link2.14': device_add
> [   21.650234][  T113] device: 'dev2.14.0': device_add
> [   21.655197][  T113] device: 'dev2.14.0': device_add
> [   21.660252][  T113] ahci-mvebu f10a8000.sata: FBS is enabled
> [   21.666005][  T113] ata2.00: SCR_CONTROL = 0x300
> [   21.670684][  T113] ata2.01: SCR_CONTROL = 0x300
> [   21.675389][  T113] ata2.02: SCR_CONTROL = 0x300
> [   21.680066][  T113] ata2.03: SCR_CONTROL = 0x300
> [   21.684774][  T113] ata2.04: SCR_CONTROL = 0x300
> [   21.689452][  T113] ata2.05: SCR_CONTROL = 0x300
> [   21.694194][  T113] ata2.06: SCR_CONTROL = 0x300
> [   21.698871][  T113] ata2.07: SCR_CONTROL = 0x300
> [   21.703624][  T113] ata2.00: hard resetting link
> [   21.708304][  T113] hardreset, Online=>Offline
> [   21.708343][  T113] sata_set_spd_needed, scontrol=0x300
> [   21.712815][  T113] __sata_set_spd_needed, initial limit=0xFFFFFFFF
> [   21.718093][  T113] __sata_set_spd_needed, corrected limit=0x1
> [   21.724409][  T113] __sata_set_spd_needed, target=0x1
> [   21.730274][  T113] __sata_set_spd_needed, spd=0x0
> [   21.735366][  T113] __sata_set_spd_needed, final *scontrol=0x310
> [   21.740280][  T113] __sata_set_spd_needed, initial limit=0xFFFFFFFF
> [   21.746343][  T113] __sata_set_spd_needed, corrected limit=0x1
> [   21.752643][  T113] __sata_set_spd_needed, target=0x1
> [   21.758522][  T113] __sata_set_spd_needed, spd=0x0
> [   21.763602][  T113] __sata_set_spd_needed, final *scontrol=0x310
> [   21.769655][  T113] resume, do loop
> [   22.004001][  T113] resume, after do loop
> [   22.012645][  T113] debounce, SCR=0x123
> [   22.021803][  T113] debounce, SCR=0x123
> [   22.030784][  T113] debounce, SCR=0x123
> [   22.039763][  T113] debounce, SCR=0x123
> [   22.048725][  T113] debounce, SCR=0x123
> [   22.057686][  T113] debounce, SCR=0x123
> [   22.066647][  T113] debounce, SCR=0x123
> [   22.075608][  T113] debounce, SCR=0x123
> [   22.084568][  T113] debounce, SCR=0x123
> [   22.093529][  T113] debounce, SCR=0x123
> [   22.102511][  T113] debounce, SCR=0x123
> [   22.111494][  T113] debounce, SCR=0x123
> [   22.115437][  T113] resume, return at end of function
> [   22.119327][  T113] hardreset, Offline=>Online
> [   22.128892][  T113] hardreset, after check_ready
> [   22.129113][  T113] ata2.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   22.140984][  T113] ata2.01: hard resetting link
> [   22.145653][  T113] hardreset, Online=>Offline
> [   22.145691][  T113] sata_set_spd_needed, scontrol=0x300
> [   22.150161][  T113] __sata_set_spd_needed, initial limit=0xFFFFFFFF
> [   22.155436][  T113] __sata_set_spd_needed, corrected limit=0x1
> [   22.161737][  T113] __sata_set_spd_needed, target=0x1
> [   22.167614][  T113] __sata_set_spd_needed, spd=0x0
> [   22.172695][  T113] __sata_set_spd_needed, final *scontrol=0x310
> [   22.177617][  T113] __sata_set_spd_needed, initial limit=0xFFFFFFFF
> [   22.183657][  T113] __sata_set_spd_needed, corrected limit=0x1
> [   22.189979][  T113] __sata_set_spd_needed, target=0x1
> [   22.195857][  T113] __sata_set_spd_needed, spd=0x0
> [   22.200936][  T113] __sata_set_spd_needed, final *scontrol=0x310
> [   22.206971][  T113] resume, do loop
> [   22.434000][  T113] resume, after do loop
> [   22.442642][  T113] debounce, SCR=0x123
> [   22.451798][  T113] debounce, SCR=0x123
> [   22.460779][  T113] debounce, SCR=0x123
> [   22.469760][  T113] debounce, SCR=0x123
> [   22.478720][  T113] debounce, SCR=0x123
> [   22.487680][  T113] debounce, SCR=0x123
> [   22.496641][  T113] debounce, SCR=0x123
> [   22.505602][  T113] debounce, SCR=0x123
> [   22.514563][  T113] debounce, SCR=0x123
> [   22.523524][  T113] debounce, SCR=0x123
> [   22.532504][  T113] debounce, SCR=0x123
> [   22.541487][  T113] debounce, SCR=0x123
> [   22.545429][  T113] resume, return at end of function
> [   22.549320][  T113] hardreset, Offline=>Online
> [   22.558885][  T113] hardreset, after check_ready
> [   22.559103][  T113] ata2.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   22.570973][  T113] ata2.02: hard resetting link
> [   22.575639][  T113] hardreset, Online=>Offline
> [   22.575677][  T113] sata_set_spd_needed, scontrol=0x300
> [   22.580148][  T113] __sata_set_spd_needed, initial limit=0xFFFFFFFF
> [   22.585423][  T113] __sata_set_spd_needed, corrected limit=0x1
> [   22.591724][  T113] __sata_set_spd_needed, target=0x1
> [   22.597602][  T113] __sata_set_spd_needed, spd=0x0
> [   22.602682][  T113] __sata_set_spd_needed, final *scontrol=0x310
> [   22.607608][  T113] __sata_set_spd_needed, initial limit=0xFFFFFFFF
> [   22.613648][  T113] __sata_set_spd_needed, corrected limit=0x1
> [   22.619968][  T113] __sata_set_spd_needed, target=0x1
> [   22.625847][  T113] __sata_set_spd_needed, spd=0x0
> [   22.630927][  T113] __sata_set_spd_needed, final *scontrol=0x310
> [   22.636959][  T113] resume, do loop
> [   22.864000][  T113] resume, after do loop
> [   22.872642][  T113] debounce, SCR=0x0
> [   22.881798][  T113] debounce, SCR=0x0
> [   22.890603][  T113] debounce, SCR=0x0
> [   22.899408][  T113] debounce, SCR=0x0
> [   22.908194][  T113] debounce, SCR=0x0
> [   22.916979][  T113] debounce, SCR=0x0
> [   22.925766][  T113] debounce, SCR=0x0
> [   22.934553][  T113] debounce, SCR=0x0
> [   22.943339][  T113] debounce, SCR=0x0
> [   22.952146][  T113] debounce, SCR=0x0
> [   22.960953][  T113] debounce, SCR=0x0
> [   22.969761][  T113] debounce, SCR=0x0
> [   22.978547][  T113] debounce, SCR=0x0
> [   22.982295][  T113] resume, return at end of function
> [   22.986033][  T113] hardreset, ata_phys_link_offline check failed
> [   22.991325][  T113] ata2.02: SATA link down (SStatus 0 SControl 300)
> ...
> [   25.191319][  T113] ata2.07: SATA link down (SStatus 0 SControl 300)
> [   25.204010][  T113] ata2.00: ATA-6: WDC WD50ARC-5040-VOL#01, 0100 AX, max UDMA/133
> [   25.211624][  T113] ata2.00: 976773168 sectors, multi 0: LBA48 
> [   25.217741][  T113] ata2.00: configured for UDMA/133
> [   25.222815][  T113] ata2.01: ATA-6: Areca   Archive, 0100 AX, max UDMA/133
> [   25.229751][  T113] ata2.01: 23437498368 sectors, multi 0: LBA48 
> [   25.236026][  T113] ata2.01: configured for UDMA/133
> [   25.241168][  T113] ata2: EH complete
> 
> Marius Dinu
> 

-- 
Damien Le Moal
Western Digital Research

