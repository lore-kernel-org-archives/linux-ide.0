Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D973C433F5
	for <linux-ide@archiver.kernel.org>; Sat, 26 Feb 2022 11:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiBZLXn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 26 Feb 2022 06:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiBZLXm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 26 Feb 2022 06:23:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A94EB23AD
        for <linux-ide@vger.kernel.org>; Sat, 26 Feb 2022 03:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645874586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x+IuamfionJsCAWkaO5i4D2ZqLfIRaCl1AlxS4yAGFk=;
        b=QCoF5IomwpKx0qpcQMT8skWAohe+Hu//D7t9aR3MgME4B12H7tLTTYU1cNYSEJzVQsIsUC
        +/PXSLdSWwoRvrlm0wk1ns8VDUhcB6daHumeuq08xOuYiUcbQFFzcmP05/8soBMg7gvLI1
        tLMtXLEyWQ1uoBp+vlty6NBYITpdIHo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-7sxKsRphMJ-Y50nnXVVnlQ-1; Sat, 26 Feb 2022 06:23:04 -0500
X-MC-Unique: 7sxKsRphMJ-Y50nnXVVnlQ-1
Received: by mail-ej1-f72.google.com with SMTP id h22-20020a1709060f5600b006b11a2d3dcfso3934555ejj.4
        for <linux-ide@vger.kernel.org>; Sat, 26 Feb 2022 03:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x+IuamfionJsCAWkaO5i4D2ZqLfIRaCl1AlxS4yAGFk=;
        b=Mgzo0Tl6bkzrQA9PLFJTZSqUqe3mENS5OQTr2x9VJCUjvV8Ceq7VBEqgithMEZL+OI
         DB5+TcD9iW9xL+nsD/UENii9QPjD/Fn6QVLB0n1hMsOac4PSDe/csnmze3cl8BkfmfDj
         8QhwwyQBAwGwoHCaAUDHy5QkMh+JNo2NsLNyiclck80fddymmBij0g/4OSIt2lM9H40e
         HaSaElij0c/AH7UVqptinTGIeQ+YNkWVnjzkZoLgk/fox+ckcjIJdnQHwJek+vdvBqbo
         HjegfjMNaEYwUmYkqMq+t2CcA1gjcHACWsge8GgY7eOMKIYTFQ/TwQUqkc33ma08rNSC
         bWHQ==
X-Gm-Message-State: AOAM531oo4kZAguWiKeAL6rIvt/6VmU+cm8mD2tfLY+AM9iM1QgDVCAT
        DK0rzbZ5jqpw0fg5f+iZ1zjs0mwPtXomvUDbErhcLTKbIxdUkn2+sGa0Eo/YHUDMrgvwzAtNDzp
        aUXd6DFtBDwOzqdeS3TJ3
X-Received: by 2002:a17:906:9256:b0:6a9:dfca:78d8 with SMTP id c22-20020a170906925600b006a9dfca78d8mr9543624ejx.330.1645874583408;
        Sat, 26 Feb 2022 03:23:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGlnOwREffcqEUPlYPOBueuAuK8YRoN++aVAp89eAHDRdCFOq0EolVIqEqkoamcjE8zTLIAw==
X-Received: by 2002:a17:906:9256:b0:6a9:dfca:78d8 with SMTP id c22-20020a170906925600b006a9dfca78d8mr9543617ejx.330.1645874583229;
        Sat, 26 Feb 2022 03:23:03 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id js24-20020a170906ca9800b006c8aeca8fe8sm2128900ejb.58.2022.02.26.03.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Feb 2022 03:23:02 -0800 (PST)
Message-ID: <7cfa7a1f-e413-cbc9-308c-bf8bfe6ac2a7@redhat.com>
Date:   Sat, 26 Feb 2022 12:23:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC 2/2] ata: ahci: Protect users from setting policies their
 drives don't support
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220225181030.980223-1-mario.limonciello@amd.com>
 <20220225181030.980223-2-mario.limonciello@amd.com>
 <7381d145-ac6f-60f4-296a-7b191296964a@redhat.com>
 <BL1PR12MB5157C0A33DC4484B6E5E6E91E23E9@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <BL1PR12MB5157C0A33DC4484B6E5E6E91E23E9@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 2/25/22 22:24, Limonciello, Mario wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Hans de Goede <hdegoede@redhat.com>
>> Sent: Friday, February 25, 2022 15:20
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Damien Le Moal
>> <damien.lemoal@opensource.wdc.com>
>> Cc: open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers) <linux-
>> ide@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
>> Subject: Re: [RFC 2/2] ata: ahci: Protect users from setting policies their
>> drives don't support
>>
>> Hi,
>>
>> On 2/25/22 19:10, Mario Limonciello wrote:
>>> As the default low power policy applies to more chipsets and drives, it's
>>> important to make sure that drives actually support the policy that a user
>>> selected in their kernel configuration.
>>>
>>> If the drive doesn't support slumber, don't let the default policy for the
>>> ATA port be `min_power` or `min_power_with_partial`.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>  drivers/ata/ahci.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>> index 17d757ad7111..af8999453084 100644
>>> --- a/drivers/ata/ahci.c
>>> +++ b/drivers/ata/ahci.c
>>> @@ -1584,8 +1584,16 @@ static int ahci_init_msi(struct pci_dev *pdev,
>> unsigned int n_ports,
>>>  static void ahci_update_initial_lpm_policy(struct ata_port *ap,
>>>  					   struct ahci_host_priv *hpriv)
>>>  {
>>> +	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>>>  	int policy = CONFIG_SATA_LPM_POLICY;
>>>
>>> +	if (policy >= ATA_LPM_MIN_POWER_WITH_PARTIAL &&
>>> +	   !(hpriv->cap & HOST_CAP_SSC)) {
>>> +		dev_warn(&pdev->dev,
>>> +			 "This drive doesn't support slumber; ignoring default
>> SATA policy\n");
>>> +		return;
>>> +	}
>>> +
>>
>> Don't the capabilties get checked later when the policy gets applied ?
>>
>> At least I think they do get checked later, but I have not looked
>> at this code for years  ...  ?
> 
> There's a bunch of layers of indirection so I might have missed something,
> but I didn't see anything in sata_link_scr_lpm or anywhere else for that
> matter that actually checked HOST_CAP_SSC.

Hmm, ok. Note that the user can still change the policy with an echo
to sysfs. So I think it would be better to do a fix where HOST_CAP_SSC
gets checked when the features are actually being enabled. Or at least
also at a HOST_CAP_SSC check to the sysfs write functions.

Regards,

Hans


>>>  	/* user modified policy via module param */
>>>  	if (mobile_lpm_policy != -1) {
>>>  		policy = mobile_lpm_policy;

