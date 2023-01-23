Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A58C25B50
	for <linux-ide@archiver.kernel.org>; Mon, 23 Jan 2023 23:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjAWXBp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 Jan 2023 18:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjAWXBn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jan 2023 18:01:43 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6039039CE8
        for <linux-ide@vger.kernel.org>; Mon, 23 Jan 2023 15:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674514864; x=1706050864;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KufYWEyLsA8PF1XLfdu0QpTRamASiWEVeNBjlp7vZjk=;
  b=pqzkjeR84aYBRDVZDXb6T4UkpG0K35ai60GL2J/ZnnkME+MKfhVsC1rJ
   M/oKwzopWpd6eSD8ePk288rEFV3NBvr/gej/BSIn4CQ5EWOlBj/tuJDvk
   rZO9PBIQiZnSnVwQLjan9MHZYePc4bHTydKLSVY/GThCu40+WIhSIrsmd
   4eRiDrk3Rbagk7ckdp3L1tjK2m/yEftp7atBE4IWv0Rf3L9u0K7cVJuly
   V6yOh5heMnzPg/SCRiIRcf7pe5T3npjhoMp3VmdtDKbur7M40Z+sbc6Az
   X02NwadlYj49qPdUZq08tPyA92Ui0VvomTl8xUwbXlfbVdMDpSS0zAzTK
   g==;
X-IronPort-AV: E=Sophos;i="5.97,240,1669046400"; 
   d="scan'208";a="226570846"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2023 07:00:09 +0800
IronPort-SDR: wU2AXdJWbUgRsGEDQYzSd94ngHfFvJBLnkTNIpHYVFGpRaUNT1S5tdQ5zRSMTQ86yxtx7ftTfG
 +LelYVI4JCO0as7tnIx+BC2B0KF39qJUw45/FxZGvkc1gMacFFcGTCB3Op2Tnyscg1HC16Cxk3
 DFAF8qmQqA0JCeOE1JvcUNtkk7qcFe0hFsJORX206NFEC8Z0J6PdaTt6ifQ74Y7h9sz+M49n7X
 Z7J1mKY8Ixh7nTouFCoVtKD5VU2dukq6nSOU/TjTlVBF5eMYzn2Yd4Jk+W4AE1z+DZcivn733V
 7+o=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2023 14:11:58 -0800
IronPort-SDR: nRUQPVlnJHKR1V0OHjW3fvKZ/YPUwG2slq+dDUvrIVCWfJ6n+PTMg3GySmamDA4OWWNOoFgP5H
 Wa2X3ltP6WEWDU8Wlf95e8pf0Fx8jXdSAPFXRhqTyawmHh9c2IyHcrOHwrt2b1okMevTbTZP+G
 IE3IJkibYwPJSUL8zUeUWwYLSM7REheQ2I4pwTqsXhdVuzjsZLq53PiCbS0aSwRho3cfPQOa9F
 lbbPxMrTkTdh1WSFb05ZD28wA/hIS2nL67E0G2MTCBd7zuiyLi2HaFcZ7L4WpP02VC7xOJVnJN
 2nI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2023 15:00:09 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P15Cs2xk6z1RvTp
        for <linux-ide@vger.kernel.org>; Mon, 23 Jan 2023 15:00:09 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674514809; x=1677106810; bh=KufYWEyLsA8PF1XLfdu0QpTRamASiWEVeNB
        jlp7vZjk=; b=Ya0geGGNpay+SlO2DsjgOkAMWAjJJuM/EbrrLX/zvmUJVv4MoNI
        fPFu9H1EAe2N1KteD/9luDm5gJgxrf64raNedOZkcsi3HRGJKuG44gY+7vFEbmlL
        SkzEpHQ0dtskoQXQQEv3+IuDSaeaLCUXrEnsPCZXwAbYwD87oAz+DZ9+b/EUQ7u4
        /ZVdb0O49Z4YdaYE9T4LL+BnDvG0n0Bhy1tlBg4t1q75yueukQaIYf44+/BkZUp3
        /jHJpeaHeEWHT4AoXbwlpuOUE7Tk8+paviFgy3gnhqKjUWZoWs01xNGPE5LCQuhw
        k+oHjMXViA7Pc6M3G4LJIwGPJZefiTxg0Bw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id F0T3plpjFmIu for <linux-ide@vger.kernel.org>;
        Mon, 23 Jan 2023 15:00:09 -0800 (PST)
Received: from [10.225.163.51] (unknown [10.225.163.51])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P15Cr4rtKz1RvLy;
        Mon, 23 Jan 2023 15:00:08 -0800 (PST)
Message-ID: <fa7f7eea-7b43-f2d7-18e5-f253ed316919@opensource.wdc.com>
Date:   Tue, 24 Jan 2023 08:00:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Bug report for ahci-mvebu driver
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <cf5d33e3-995f-4346-b02a-b203ed94d9e3@opensource.wdc.com>
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
 <44527e2f8583a8ce51b1241bf9e56595@psihoexpert.ro>
 <45337bf4a17c9c879f9439c1138bc443@psihoexpert.ro>
 <7fe0b96f30bf787d339ba656d5d2df01@psihoexpert.ro>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <7fe0b96f30bf787d339ba656d5d2df01@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 1/24/23 05:00, marius@psihoexpert.ro wrote:
> January 23, 2023 9:02 AM, "Damien Le Moal"
> <damien.lemoal@opensource.wdc.com> wrote:
> 
>> But I think I got an idea of what is wrong here. Can you try this
>> patch:
>> 
>> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c 
>> index 18ef14e749a0..cb12054c733f 100644 ---
>> a/drivers/ata/libata-sata.c +++ b/drivers/ata/libata-sata.c @@ -436,7
>> +436,8 @@ static int __sata_set_spd_needed(struct ata_link *link, u32
>> *scontrol) limit &= (1 << host_link->sata_spd) - 1;
>> 
>> if (limit == UINT_MAX) - target = 0; + /* Try highest gen 3 limit */ 
>> + target = 3; else target = fls(limit);
> 
> It doesn't work. I didn't really expect it to work, since manually
> forcing 3Gbps didn't work either - probably a hardware issue like you
> said.

Well, this one was not intended to limit the link speed to anything.
target == 0 written to scontrol means "no autonegociation speed limit",
while target == 3 means "limit autonegotiated speed to gen 3", which are
effectively equivalent since the max speed is gen 3 :) The point was to
force an scontrol write: in your case, spd is 0 and the default code with
target == 0 ends up with __sata_set_spd_needed returning false and so
sata_set_spd() doing nothing. Setting target to 3 forced trying to set the
speed to gen3. Wanted to see what that did.

Given that things are working by forcing 1.5gbps, and you endup with the
correct 3gbps link speed, it seems that this hardware does not like
negotiation starting from the highest speed. The SATA-IO specifications do
clearly mandate that adapters should allow for any initial speed, the
highest or the lowest and be ready for negotiation from any starting
combination of device and adapter speeds. But it seems that the designers
of this adapter and/or of the pmp box missed that chapter :)

> I think that the old behaviour (before commit
> 2dc0b46b5ea30f169b0b272253ea846a5a281731) of slowing down sata speed
> when a connection can't be established is in fact the right thing to
> do. Maybe a longer delay before reducing the link speed would satisfy
> the random cases that the commit author reported. Maybe he was just
> having a loose connector issue - especially since he only reported one
> case.

I do not think that a longer delay will change anything in your case since
the device presence cannot be established when starting speed negotiation
without a limit: see the "debounce, SCR=0x100" messages in your debug,
while the 1.5gbps link speed forcing leads to an immediate device presence
detected (debounce, SCR=0x113 message).

Can you please try this one:

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 884ae73b11ea..a4e2a93af0e5 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3085,10 +3085,17 @@ int sata_down_spd_limit(struct ata_link *link, u32
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
+                * Device is not reporting a speed yet. Use the last recorded
+                * speed. If we do not have that either, start with Gen3
speed.
+                */
+               if (!link->sata_spd)
+                       link->sata_spd = 3;
                spd = link->sata_spd;
+       }

        mask = link->sata_spd_limit;
        if (mask <= 1)

If that does not work, we'll have to handle your case with a HORKAGE flag
for that adapter.

-- 
Damien Le Moal
Western Digital Research

