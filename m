Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DA3C4167B
	for <linux-ide@archiver.kernel.org>; Fri,  9 Dec 2022 09:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiLIJ2j (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 9 Dec 2022 04:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLIJ2h (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Dec 2022 04:28:37 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC1645A3D
        for <linux-ide@vger.kernel.org>; Fri,  9 Dec 2022 01:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670578115; x=1702114115;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6rV/yaBckrShvjgCVMQKnJxSG7/+yvjjxk0PnZLihio=;
  b=E+SZ2oNSezR4SsCa2uFPyqusG9Q1A1mGCvOA/U/4jTROEgsEqij+bvFM
   eHJfyMczEBVXREdT/Gmdhozjhb6xqOFt1AYVFaW6zSXPxTUi4lcWl37Ir
   Z9OCCt0+0+8cABRaIbP4ZY/+OHuM4t6qIe8OfBxUNU3YfsgTNGjr0/hOB
   Y118P4yzadYmpjKjjup3SiP9ikyOUKDbFsD7s3rzs0FLb2Vdiw3ssfq3Z
   QRam3Oin85GMEduAKUyVB+z00wGOo9E1vcyzJ6L0IivFb9NqH0qEGqY17
   b1Y7QGXO8z8ZmsT5ogKqnkLIBP5R1teyjpexOlwMOA6ElQUWHKWfOh593
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,230,1665417600"; 
   d="scan'208";a="216478722"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2022 17:28:34 +0800
IronPort-SDR: LDSFuEpx+ZuDwIwysk7KI240cy8ww7qkQQF1b6CzfEjWlMaVUnyjpeuh5VORyoPsvNsZ84tIRK
 HkmBAzv3lcibqclfGsHG0xydZvfXkzMM/lK08kpdDl5U+h4YU4I9x9j4WDbM9xea1Z5/LBxU98
 KlreN1qDefVkGDi8uW4l1LuMUNHuM+mgV38/bttd0FGCg1RMDL0dCZVid8yVccTXEw4DNySQEQ
 EH0COLA0RVVdyMNs6GeYPKXLLyn3uHJCAtg2zNKwT6oZXIEtCTI7qCya5JmwNfy+cH2rdxGFHq
 9pc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Dec 2022 00:47:02 -0800
IronPort-SDR: wJywrMKD479F/+0i2qHpHYKnpGTgi+/XUV9u18xU3Wa2OQYRCpjyul1gYE7A3f4bTzbLKTbzgx
 nON1irMRGnN69KepP5j9v97bGeCRF7RFjb3k9D8D/Ozo3DoUVs3qLiBpvzjBIsrCg3+uLkl3wF
 0aiEDS5u2gSu6IIBFpHjKQpmtbAdP4TV0pnVgGEk5mwPUbawbSerhU82WLnofxjhCFxgfGJHpu
 KKdYOP99VduRvkn3ecA56kdBowtV6fh1STjMZnY0FdMgXd2iCteWxn5JntuKOkiyQ9ZOYoIj2Z
 9To=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Dec 2022 01:28:35 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NT5LB3D3Qz1RvTp
        for <linux-ide@vger.kernel.org>; Fri,  9 Dec 2022 01:28:34 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670578113; x=1673170114; bh=6rV/yaBckrShvjgCVMQKnJxSG7/+yvjjxk0
        PnZLihio=; b=EHWJPBZDIjNVvzujLVCdN5nTIRRGjps86shXTnJeGEdshPl7tE/
        KQYwITTqI2DTetM2xUoRRLzFAglHoH4MUE5cVUXwPj68c4slFC8a+mti+cHoOwgE
        g0jABdcmq7Iboy+KX7PadD9rcKy8VoNeScjbo3/gmPMPQ84ETi8yCpl2CoPXi3tZ
        p8V1SDQxbsU7o12f0ihcUzncZ2E824jGZYw3dNNb3pe1LOjARXHsm7DflogGVHql
        1Ks2ROw1DU+3mBjNKJj/V6tE18P553MJUvosDkhvCI99YtKUGmxhjyJfcuSd/EwL
        rjeAX/FWgo6j+8lDap7dlSHvglkCxVZZWCQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eVFiC7MqI_sL for <linux-ide@vger.kernel.org>;
        Fri,  9 Dec 2022 01:28:33 -0800 (PST)
Received: from [10.225.163.85] (unknown [10.225.163.85])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NT5L93k0Gz1RvLy;
        Fri,  9 Dec 2022 01:28:33 -0800 (PST)
Message-ID: <7521d86e-a83e-7972-a4cc-55dd7155fa43@opensource.wdc.com>
Date:   Fri, 9 Dec 2022 18:28:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <1b1f8ab0-9a2d-93e3-66f0-18597e80b790@opensource.wdc.com>
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <da1d366a494469a46eb066b167613e21@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/9/22 16:31, marius@psihoexpert.ro wrote:
> December 9, 2022 4:58 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.com> wrote:
> 
>> On 12/9/22 03:06, marius@psihoexpert.ro wrote:
>>
>> Checking the specs for the SoC again, it does say:
>>
>> Gen3 Serial ATA PHY (6 Gbps) with speed negotiation to Gen1, Gen2
>>
>> So with your gen2 (3gbps) pmp box, clearly, the speed negotiation is not
>> working but limiting it to 1.5gbps seems ok. Could you add the following
>> print to see what the HW is saying it supports ?
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 884ae73b11ea..b3925239b8b0 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -5271,6 +5271,9 @@ int sata_link_init_spd(struct ata_link *link)
>> if (rc)
>> return rc;
>>
>> + ata_link_info(link, "SCR_CONTROL = 0x%x\n",
>> + link->saved_scontrol);
>> +
>> spd = (link->saved_scontrol >> 4) & 0xf;
>> if (spd)
>> link->hw_sata_spd_limit &= (1 << spd) - 1;
>>
>> --
>> Damien Le Moal
>> Western Digital Research
> 
> 
> Without libata.force=2:1.5Gbps, the extra debug message appears only during boot.
> Cable connected or not - doesn't matter - the messages are the same.
> 
> [    4.480888][    T1] scsi host1: ahci-mvebu
> [    4.485149][    T1] device: 'host1': device_add
> [    4.489728][    T1] bus: 'scsi': add device host1
> [    4.494544][    T1] device: 'host1': device_add
> [    4.499589][    T1] ata1: SCR_CONTROL = 0x0

OK. So the HW is saying that it has no restrictions on the link speed.
From AHCI specs, bits 07:04 of SCR CONTROL (SControl) mean:

0h	No speed negotiation restrictions
1h	Limit speed negotiation to Generation 1 communication rate
2h	Limit speed negotiation to a rate not greater than Generation 2
communication rate
3h	Limit speed negotiation to a rate not greater than Generation 3
communication rate

> [    4.503822][    T1] ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] port 0x100 irq 42
> [    4.512480][    T1] ata2: SCR_CONTROL = 0x0
> [    4.516704][    T1] ata2: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] port 0x180 irq 42
> [    4.525443][    T1] driver: 'ahci-mvebu': driver_bound: bound to device 'f10a8000.sata'
> [    4.533599][    T1] bus: 'platform': really_probe: bound device f10a8000.sata to driver ahci-mvebu
> 
> 
> With libata.force=2:1.5Gbps, the same message appears during boot, but then, when the device is detected:

First of all, understand how PMP works: the adapter must first detect that
it is dealing with a port multiplier box, not an actual device. But on
startup, it does not know that yet and so link speed negotiation is done
with the box. Once that is done and a "PMP" device type detected, the link
speed may be changed to the lowest speed of all the devices in the box so
that the adapter can communicate with all of them over the same link.

> [   17.624417][  T113] hardreset, Online=>Offline
> [   17.625498][  T113] resume, do loop
> [   17.853273][  T113] resume, after do loop
> [   17.913272][  T113] debounce, SCR=0x113
> [   17.973271][  T113] debounce, SCR=0x113
> [   18.033271][  T113] debounce, SCR=0x113
> [   18.093271][  T113] debounce, SCR=0x113
> [   18.153271][  T113] debounce, SCR=0x113
> [   18.213270][  T113] debounce, SCR=0x113
> [   18.273270][  T113] debounce, SCR=0x113
> [   18.333270][  T113] debounce, SCR=0x113
> [   18.393271][  T113] debounce, SCR=0x113
> [   18.397130][  T113] resume, return at end of function
> [   18.400987][  T113] hardreset, Offline=>Online
> [   18.410547][  T113] hardreset, sata_pmp_supported, before check_ready
> [   18.583275][  T113] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [   18.597005][  T113] ata2.15: Port Multiplier 1.2, 0x197b:0x0325 r193, 8 ports, feat 0xf/0x1f

OK. So by limiting to 1.5gbps, detection works and the adapter detects the
PMP device. The driver then goes on to probe all ports present on the PMP.

[...]

> [   18.920044][  T113] ata2.00: FORCE: PHY spd limit set to 1.5Gbps
> [   18.926149][  T113] ata2.01: SCR_CONTROL = 0x300
> [   18.930795][  T113] ata2.01: FORCE: PHY spd limit set to 1.5Gbps
> [   18.936889][  T113] ata2.02: SCR_CONTROL = 0x300
> [   18.941533][  T113] ata2.02: FORCE: PHY spd limit set to 1.5Gbps
> [   18.947634][  T113] ata2.03: SCR_CONTROL = 0x300
> [   18.952277][  T113] ata2.03: FORCE: PHY spd limit set to 1.5Gbps
> [   18.958371][  T113] ata2.04: SCR_CONTROL = 0x300
> [   18.963015][  T113] ata2.04: FORCE: PHY spd limit set to 1.5Gbps
> [   18.969111][  T113] ata2.05: SCR_CONTROL = 0x300
> [   18.973775][  T113] ata2.05: FORCE: PHY spd limit set to 1.5Gbps
> [   18.979846][  T113] ata2.06: SCR_CONTROL = 0x300
> [   18.984515][  T113] ata2.06: FORCE: PHY spd limit set to 1.5Gbps
> [   18.990586][  T113] ata2.07: SCR_CONTROL = 0x300
> [   18.995251][  T113] ata2.07: FORCE: PHY spd limit set to 1.5Gbps

Here, the speed is limited to 1.5gbps for all ports because the kernel
option limited the link to that speed. SCR control == 0x300 means
"Transitions to both Partial and Slumber states disabled"... Hmm. May be
this is what we need: no LPM.

> [   19.001401][  T113] ata2.00: hard resetting link
> [   19.006066][  T113] hardreset, Online=>Offline

Not sure why it resets again here... Might be the COMRESET needed for PMP
before probing the ports.

> [   19.006105][  T113] Reconfig spd

Which function did you add this message to ?

> [   19.011857][  T113] resume, do loop
> [   19.243309][  T113] resume, after do loop
> [   19.251950][  T113] debounce, SCR=0x123
> [   19.261104][  T113] debounce, SCR=0x123
> [   19.270082][  T113] debounce, SCR=0x123
> [   19.279059][  T113] debounce, SCR=0x123
> [   19.288018][  T113] debounce, SCR=0x123
> [   19.296978][  T113] debounce, SCR=0x123
> [   19.305937][  T113] debounce, SCR=0x123
> [   19.314896][  T113] debounce, SCR=0x123
> [   19.323855][  T113] debounce, SCR=0x123
> [   19.332813][  T113] debounce, SCR=0x123
> [   19.341790][  T113] debounce, SCR=0x123
> [   19.350768][  T113] debounce, SCR=0x123
> [   19.354706][  T113] resume, return at end of function
> [   19.358595][  T113] hardreset, Offline=>Online
> [   19.368155][  T113] hardreset, after check_ready
> [   19.368372][  T113] ata2.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)

So now the PMP box speed is negotiated at 3gbps at it should have in the
first place. Weird. The option should still force limit it to 1.5gbps...

> [   19.380239][  T113] ata2.01: hard resetting link
> [   19.384903][  T113] hardreset, Online=>Offline
> [   19.384940][  T113] Reconfig spd
> [   19.390688][  T113] resume, do loop
> [   19.623306][  T113] resume, after do loop
> [   19.631947][  T113] debounce, SCR=0x123
> [   19.641098][  T113] debounce, SCR=0x123
> [   19.650075][  T113] debounce, SCR=0x123
> [   19.659053][  T113] debounce, SCR=0x123
> [   19.668011][  T113] debounce, SCR=0x123
> [   19.676970][  T113] debounce, SCR=0x123
> [   19.685929][  T113] debounce, SCR=0x123
> [   19.694889][  T113] debounce, SCR=0x123
> [   19.703847][  T113] debounce, SCR=0x123
> [   19.712805][  T113] debounce, SCR=0x123
> [   19.721782][  T113] debounce, SCR=0x123
> [   19.730760][  T113] debounce, SCR=0x123
> [   19.734699][  T113] resume, return at end of function
> [   19.738587][  T113] hardreset, Offline=>Online
> [   19.748146][  T113] hardreset, after check_ready
> [   19.748363][  T113] ata2.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)

And the first port gets 3gbps too.

> ...
> 
> 
> I had the impression that speed always starts low and is negociated up (1.5 -> 3 -> 6), not starting high and decreased. How would negociation work if the speed is too high and one of the devices can't communicate?

The speed will start at the highest auto-negotiated speed, at the HW
level. The ahci driver will however lower it if it sees errors during
probe and try probe again with the lower speed.

What I do not understand here is why after the second reset we get 3gbps.
The libata.force parameter seems to be ignored and auto-negociation
working, detecting the pmp at 3gbps. Need to dig into that...

In the mean time, can you try this kernel boot option:

libata.force=2:nolpm

without the "2:1.5Gbps" option.

> 
> I tried the pmp box on other computers. ATI/AMD AHCI, Jmicron PATA/SATA combo card, Intel ICH7. None of these have any errors in the log.
> 
> Marius Dinu
> 

-- 
Damien Le Moal
Western Digital Research

