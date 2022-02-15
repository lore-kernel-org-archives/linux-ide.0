Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C97C433F5
	for <linux-ide@archiver.kernel.org>; Tue, 15 Feb 2022 12:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238003AbiBOMzU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 15 Feb 2022 07:55:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237997AbiBOMzU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 15 Feb 2022 07:55:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF22643EFE
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2022 04:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644929709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UWpCV1vCh9SyEpjVGJpL1I8KMkGXWc7WBvjuBLVAcTE=;
        b=BBuG8GIq4t0phujm6rWWjbCQ6AHX3hQ4pWIIzs1o3fzwhX76SbSjk6W463mQb5jnG4TNwx
        rKU0Zop+xpR/lY5Q/W/Qwpjk8tqhbNYpf9SQ1zPlWIZnYGOGBWVdNLxCh+bMl9157z7mRX
        dDyK7SCnsskn6cShMQNtq7vYgGAK3Gc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-7frxvwrMNF-Y4bISuyIEOQ-1; Tue, 15 Feb 2022 07:55:06 -0500
X-MC-Unique: 7frxvwrMNF-Y4bISuyIEOQ-1
Received: by mail-ed1-f69.google.com with SMTP id l3-20020a50cbc3000000b0041083c11173so6978738edi.4
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2022 04:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UWpCV1vCh9SyEpjVGJpL1I8KMkGXWc7WBvjuBLVAcTE=;
        b=N/MG0Z5W91vElq1RpRui/PBBi8aVxl336Jh2K+5BQOjK2ypZ8NZXOVgH99MASvtJO+
         ZYs4n9WZvpx6mV7OXJXKHri+loh3ToDRx3H+fY/9xJmQlO+3DCtrtmib7+Rt8+AxRDcY
         ffbiFJXsJUt759WvMawpnO32+t6crgslB9dTUTihrIrR8REjre2AOIafzybjyw3/cUCs
         a5J/FE7j6Z1MbW+YtuvbyeSzGD4bSnYiS6gISjWcUpiigmfSJem7rUB0C2Itwz+kEJ37
         t5MH59gMRV+a3b7+eZhYXsdYLMgC1i/P5AsIOp2LO7APXyDbINdEM6nI+iTP7RlOXfoX
         KNlw==
X-Gm-Message-State: AOAM531MpjiD0QQuoycoB4pQc7oKlgLACiPiuIPB9SGhRuAzQB//8GZp
        4Xv5pAz+QExyqEpgwrCjJMiPZhA6prZH/TYZ3GwVd9i1vI4ITntFWYr5WzjuHnTcxEJq3fFqeta
        CnETsnJe+IosqSk6LJDKm
X-Received: by 2002:aa7:cb8c:: with SMTP id r12mr3828834edt.174.1644929704741;
        Tue, 15 Feb 2022 04:55:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyp6YTfQVw9KzaZMgPXaH6ERIpB6ODZ9z4zJX6n5Pmg5Gr1u4KT4YHHDwsx57rgWb1vcWmEcQ==
X-Received: by 2002:aa7:cb8c:: with SMTP id r12mr3828814edt.174.1644929704515;
        Tue, 15 Feb 2022 04:55:04 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id r11sm8033894ejc.212.2022.02.15.04.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 04:55:04 -0800 (PST)
Message-ID: <48698051-ad31-3b42-046e-4d204b180d80@redhat.com>
Date:   Tue, 15 Feb 2022 13:55:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/2] ahci: Add Green Sardine vendor ID as
 board_ahci_mobile
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
References: <20211112201539.17377-1-mario.limonciello@amd.com>
 <960946b8-8f73-9f81-735a-64e5cc555a9c@molgen.mpg.de>
 <DM4PR12MB516853204C9D7E7EAAFBC91FE2339@DM4PR12MB5168.namprd12.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <DM4PR12MB516853204C9D7E7EAAFBC91FE2339@DM4PR12MB5168.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 2/14/22 17:07, Limonciello, Mario wrote:
> [Public]
> 
> +Hans
> 
>> (For the records, is part of Linux since 5.16-rc2 (commit 1527f69204fe).)
>>
>> Am 12.11.21 um 21:15 schrieb Mario Limonciello:
>>> AMD requires that the SATA controller be configured for devsleep in order
>>> for S0i3 entry to work properly.
>>>
>>> commit b1a9585cc396 ("ata: ahci: Enable DEVSLP by default on x86 with
>>> SLP_S0") sets up a kernel policy to enable devsleep on Intel mobile
>>> platforms that are using s0ix.  Add the PCI ID for the SATA controller in
>>> Green Sardine platforms to extend this policy by default for AMD based
>>> systems using s0i3 as well.
>>>
>>> Cc: Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
>>> BugLink:
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugz
>> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D214091&amp;data=04%7C01%7Cm
>> ario.limonciello%40amd.com%7Ca32a202d437544cd2cbb08d9ef9112c0%7C3d
>> d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637804228648002522%7CU
>> nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
>> 6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=CbfImBnwc8uV1L5QRBuV
>> PLkP72wpS9yif1UbUwykhNI%3D&amp;reserved=0
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/ata/ahci.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>> index d60f34718b5d..1e1167e725a4 100644
>>> --- a/drivers/ata/ahci.c
>>> +++ b/drivers/ata/ahci.c
>>> @@ -438,6 +438,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>>>   	/* AMD */
>>>   	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
>>>   	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>>> +	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green
>> Sardine */
>>
>> Aren't 0x7900 and 0x7901 the same device only in different modes? I
>> wonder, why different boards and different comments are used.
> 
> No they aren't the same device in different modes.
> 
> Reference:
> https://www.amd.com/en/support/tech-docs/processor-programming-reference-ppr-for-amd-family-19h-model-51h-revision-a1
> Page 33 has a table.
> 
>>
>> Additionally, the device 0x7901 is also present in desktop systems like
>> Dell OptiPlex 5055 and MSI B350 MORTAR. Is `board_ahci_mobile` the right
>> board then? Or should the flag `AHCI_HFLAG_IS_MOBILE` be renamed to
>> avoid confusion?
> 
> Are you having a problem or just want clarity in the enum definition?
> 
> This was introduced by Hans in commit ebb82e3c79d2a to set LPM policy properly
> for a number of mobile devices.
> 
> My opinion here is that the policy being for "mobile" devices only is short sighted as power
> consumption policy on desktops is also relevant as OEMs ship desktops that need to meet
> various power regulations for those too.
> 
> So I would be in the camp for renaming the flags.

I have no objection against renaming the flags, maybe rename "mobile" to
"enable_lpm_by_default" ? That is a bit long, but it is what it is all
about. Alternatively we could go with "low_power" but that feels much less
descriptive.

Regards,

Hans

