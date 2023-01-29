Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BD7C61D97
	for <linux-ide@archiver.kernel.org>; Sun, 29 Jan 2023 02:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjA2CXy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 28 Jan 2023 21:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjA2CXx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 28 Jan 2023 21:23:53 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A8123339
        for <linux-ide@vger.kernel.org>; Sat, 28 Jan 2023 18:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674959032; x=1706495032;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rQJ31pWsYeqtZ2jAr/niJYsKrrYNyGGkxeaOIYM8NPU=;
  b=GIqb1Nr15Jx7+u1JK5Isk3dha1QMX/viMF3teAcRDrnuueD8xzOgvGI4
   d80snJTJ7NbnPwTJTMR3Ngwivv4Zvr51IQiW8uOCQfoVW2911Khc2Hdd4
   yM7zaIYVCsdDPf9CBQxticnKwhzi7ioEF2psUodbemCweRV5+MHynzi6I
   lEISgpNUTyoRFCeuaD+VMbGjncA9Xk76vj8Kn+D8mYmBD/M+CN6xQsV7C
   yaJuow17DFsB0pBPnEBOLeJmBkyMWyl8626GMX0HKHjfeguU37lWpQ7af
   PE2hsUCduUCbWUOLrNFnPsM9exPA0eKGqcIEdx04pL2PfMlRkcWOW3H0t
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,254,1669046400"; 
   d="scan'208";a="221793107"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2023 10:23:51 +0800
IronPort-SDR: JYRgac7guJIfIch/6HpMFOS0FQ+vDAOxwwi4Ts9IP1zPQSYqMERmJaTJxf6uRHhplNhc6I0ciq
 dToui7nwehZxs1+fdBubU5ugrelaWuz7ebvgpbIlZkrYkbCrC8PjnQjoJvMzZbikTaABc+42kV
 GnyfrKcgh0SJuICdQri7o6Tfij4CjGFQDQwdtIfAh0AHOCM0Fxa+EIF8/580JUXq/1na3DDfTB
 0unzd9UsN5Ww7K4qHyoXtvVu8jx2+4ZKqc04F9lsin9u6vvOSU5USJCuvsgi5MNBYEDzEYJMsr
 hrc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jan 2023 17:41:19 -0800
IronPort-SDR: fKam9tHTbhC3UPk3IOWvEEqcBsPmqIoZfaL8pg0JyS1GShgPvvecScQ4qlqfzcqBTKwQ0y7tTc
 i4yaseXvYBhjI0Uo6ig9c7sqJNxUwuBU0Y2GABzy7PCJZvEaIO167NnAg2vLhe9KPVsH8kZlDA
 pdj0mhyZNqM5+Otfyi9NUUvJgoSSlIBuIpHAuTzp+TTnEgMFlUqg2AF5axpuE350+hjhE7Mj5w
 fLe/uaEiYEdh/1c0XJLDtnFUgvPHjFc3S0Zssk0/BWZbxrxFOm7PwG5MEf4EBcvPe5D722OdWR
 ypc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jan 2023 18:23:51 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P4FVb4zFmz1RvTp
        for <linux-ide@vger.kernel.org>; Sat, 28 Jan 2023 18:23:51 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674959031; x=1677551032; bh=rQJ31pWsYeqtZ2jAr/niJYsKrrYNyGGkxea
        OIYM8NPU=; b=WVuk9RyWeTnV9X4Y9w+VQR5c6WHx2f5Tlsc3cpOXPlcf+vIq3sw
        MEmcuJJLWEFeO6mim+A0NSBIf+MDSiVXuW/LBcd4gi1ftrJdzTVgULcRR5hqK1qQ
        Zu66bHcRw6a8OzG9R0z7v3Cb8DT0vX0rXkdryro2DMyR+JDaOhxOhQwYOgJTXJh3
        ooM0bWjc4nWVh0eAs4Gatn+XZQQIq7bH9gxfUXe17DAdhP3zlYXJY70NIVigbnBD
        toRDGn4QntiLQrfHUis7NxCC6bgxLQ2JdzMaM6LjR8eh6snmU+8OmifWe6yq6TY8
        V6zVCulZaQWHBMHD5Fq0/U7QyxUrRwAacBA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ioG_Pnoo6h9A for <linux-ide@vger.kernel.org>;
        Sat, 28 Jan 2023 18:23:51 -0800 (PST)
Received: from [10.225.163.66] (unknown [10.225.163.66])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P4FVZ5xhRz1RvLy;
        Sat, 28 Jan 2023 18:23:50 -0800 (PST)
Message-ID: <ceb87cfa-b9f9-525b-bd85-9728833e8687@opensource.wdc.com>
Date:   Sun, 29 Jan 2023 11:23:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <fbbbad64-482e-93eb-14e7-01b54a92d2b3@opensource.wdc.com>
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
 <009822d6-24b8-739d-e7ee-13adc1c7d548@opensource.wdc.com>
 <55834657003f5a4579b326ee61fe1e80@psihoexpert.ro>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <55834657003f5a4579b326ee61fe1e80@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/29/23 02:08, marius@psihoexpert.ro wrote:
> January 27, 2023 8:28 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.com> wrote:
> 
>> On 1/27/23 14:13, Damien Le Moal wrote:
>>
>>> Marius,
>>>
>>> Thanks again for testing.
>>> Could you try a new variation of the fix shown below ? This newer fix
>>> should avoid uselessly going down to 1.5 Gbps as shown above.
>>> Thanks !
>>>
>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>> index 884ae73b11ea..04938db566e5 100644
>>> --- a/drivers/ata/libata-core.c
>>> +++ b/drivers/ata/libata-core.c
>>> @@ -3085,10 +3085,31 @@ int sata_down_spd_limit(struct ata_link *link, u32
>>> spd_limit)
>>> * If not, use cached value in link->sata_spd.
>>> */
>>> rc = sata_scr_read(link, SCR_STATUS, &sstatus);
>>> - if (rc == 0 && ata_sstatus_online(sstatus))
>>> + if (rc == 0 && ata_sstatus_online(sstatus)) {
>>> spd = (sstatus >> 4) & 0xf;
>>> - else
>>> + } else {
>>> + /*
>>> + * If we reach here, the device is still offline or not
>>> + * reporting a current speed yet. If we do not have a recorded
>>> + * speed either, it means that probing the drive is failing,
>>> + * most likely because problem with link speed autonegotiation
>>> + * (e.g. reported case with mvebu adapter with a port multiplier
>>> + * device). In this case, assume that probing was done at Gen3
>>> + * speed and set the recorded speed to lower Gen2. With this,
>>> + * the next probe retry will be done after sata_set_spd()
>>> + * explicitly lowers the link speed. If the device then
>>> + * responds, the actual maximum speed will be set once
>>> + * libata-eh finishes the device revalidation.
>>> + */
>>> + if (!link->sata_spd) {
>>> + link->sata_spd = 2;
>>> + ata_link_warn(link,
>>> + "No reported link speed. Assuming %s\n",
>>> + sata_spd_string(link->sata_spd));
>>> + return;
>>
>> Oops. My bad. This should be "return 0;" of course.
>>
>>> + }
>>> spd = link->sata_spd;
>>> + }
>>>
>>> mask = link->sata_spd_limit;
>>> if (mask <= 1)
>>
>> --
>> Damien Le Moal
>> Western Digital Research
> 
> 
> It doesn't work.
> 
> [   15.145150][  T113] hardreset, Online=>Offline
> [   15.145159][  T113] sata_set_spd_needed, scontrol=0x300
> [   15.149632][  T113] __sata_set_spd_needed, initial limit=0xFFFFFFFF
> [   15.154910][  T113] __sata_set_spd_needed, corrected limit=0xFFFFFFFF
> [   15.161211][  T113] __sata_set_spd_needed, target=0x0
> [   15.167700][  T113] __sata_set_spd_needed, spd=0x0
> [   15.172781][  T113] __sata_set_spd_needed, final *scontrol=0x300
> [   15.178685][  T113] resume, do loop
> [   15.413909][  T113] resume, after do loop
> [   15.473909][  T113] debounce, SCR=0x100
> ..
> [   16.553930][  T113] debounce, SCR=0x100
> [   16.557791][  T113] resume, return at end of function
> [   16.561650][  T113] hardreset, ata_phys_link_offline check failed
> [   16.566754][  T113] ata2: SATA link down (SStatus 101 SControl 300)
> [   16.579222][  T113] sata_down_spd_limit: limit 0x1, cur spd 0x0, saved limit 0xffffffff, hw limit 0xffffffff
> [   16.589115][  T113] ata2: No reported link speed. Assuming 3.0 Gbps
> [   16.595436][  T113] hardreset, Online=>Offline
> [   16.595442][  T113] sata_set_spd_needed, scontrol=0x300
> [   16.599911][  T113] __sata_set_spd_needed, initial limit=0xFFFFFFFF
> [   16.605178][  T113] __sata_set_spd_needed, corrected limit=0xFFFFFFFF
> [   16.611479][  T113] __sata_set_spd_needed, target=0x0
> [   16.617975][  T113] __sata_set_spd_needed, spd=0x0
> [   16.623055][  T113] __sata_set_spd_needed, final *scontrol=0x300

OK. That is because the limit is not being changed with the added "return 0".
What about this version:

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 884ae73b11ea..f404e2c2869e 100644
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
+                * speed and set the speed limit to the lower Gen2 speed.
+                * With this, the next probe retry will be done after
+                * sata_set_spd() explicitly lowers the link speed. If the
+                * device then responds, the actual maximum speed will be set
+                * once libata-eh finishes the device revalidation.
+                */
+               if (!link->sata_spd && link->sata_spd_limit == UINT_MAX) {
+                       link->sata_spd_limit = 2;
+                       ata_link_warn(link,
+                                     "No reported SATA link speed. Limiting to
%s\n",
+                                     sata_spd_string(link->sata_spd_limit));
+                       return 0;
+               }
                spd = link->sata_spd;
+       }

        mask = link->sata_spd_limit;
        if (mask <= 1)

Does this work ?

-- 
Damien Le Moal
Western Digital Research

