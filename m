Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B591DC04AA5
	for <linux-ide@archiver.kernel.org>; Thu, 25 Aug 2022 00:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiHYANn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 24 Aug 2022 20:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiHYANm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 24 Aug 2022 20:13:42 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D93279A5D
        for <linux-ide@vger.kernel.org>; Wed, 24 Aug 2022 17:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661386420; x=1692922420;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZxFoJwFCqkeM4fdVl9Td19awIMtIqaYzS3bftceHRAU=;
  b=WJUiV99GnEQTn9bpUR+II+RZSHTLS/eCHgOgJu8EC8xZShPuwQsl+34C
   cu/V1IuyZ6qajba8vtoNI7H8JX+mwaWdNAk4fUzGNs8I6puS42HhxdxR/
   D85F+yj+tRUZhyUA2ERkcVLrECQcNQr3tjokmGLrH0lk7tiozUFLF6wid
   GHzJYfmzaOBVvRtuSzCDq3g4HeSSJ6V88WUKeDCP48+mSa5cljbMHJnPb
   ZmQYLVIcOo0KstRUYpqtsUFwAF1dgBlug7Qb688O4rhs5zbRDuoGOt3RP
   6rsYINzxHv28tLUgGCg6JR/5wbNR8f4Ydq04pZqlvqlt7pig8XFCqaV/Q
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,261,1654531200"; 
   d="scan'208";a="214736158"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2022 08:13:39 +0800
IronPort-SDR: o3F95RwK63qegF1fn6P3ckTGUrbyCYCFXodbNLttIQiLEp8wPVpdEuVUI2sVGy83GhrD/Q4HBG
 x+EPsWrfHyyRqeWmAF+QWIHHUlT1SdGGK8iB01lf4hVyKaLkBsmad+zthHXN+n3JFDu1Qn9rR4
 Z5dWUTMdb1e/onAJi+T21zu+DrEUPBdX0d+oIGfWEqK6uD83j0U5JQzPvUn+sjO4e7n/bZgJJD
 HesY2rD31U9PL2NiCSHZsi1yl596n9dgOr71ZJ/I6gmuu9q7nSsWy5bD3lwrhkaQfBlaMjfvN2
 jg2HGxVZ3/AXpxq5o29T8GBa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2022 16:28:55 -0700
IronPort-SDR: FSB248AN8aJQUyaafKTN6xcNRV5hvokaOcZdmTo+1rK5LShG0ntJEd440HVBgEosX6sgpzBxZ7
 Jm7km/Hry9jzhFyF7rm5WzO19t1F4K+DX62zdiJkL76UucFY4ha4viXb2AyngT+98q1IJt7VRc
 xzbvnU5ba5uxvFpFOVWUQeX7TZfoHCmNnKpuHFo5WMCC2ZGytvB7OX+Xd61X3yr6Oug+XXoTLy
 +S7l9ZIE5lAlUOYXwJRzqFTEgmxBPthotXdvkTrwFDWbDvW5iJlM5acSaOE6CLjGUMCyNgL8pA
 QL8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2022 17:13:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MCk2q5Ywrz1RwqM
        for <linux-ide@vger.kernel.org>; Wed, 24 Aug 2022 17:13:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1661386418; x=1663978419; bh=ZxFoJwFCqkeM4fdVl9Td19awIMtIqaYzS3b
        ftceHRAU=; b=WWOMyHZ15SN4LXUX1Fqz8+FW0JbsUukS9VgmrAzlA1AQ+A//PDg
        UmetpVDU31ijxhykte7VTwF7JW9wOe1wWkT4nA5R9ikcyCUeqORsXOaT9Diez0wm
        bzg3yyWMRoGkGpHKvEVFypZdeFOUx4ZQSaxHtc9YpYyHqBieg5wtnK90Yo3cXbcD
        Rlyd74UpuUl7bwVQR6Ethy0FPLvCX1OQ5AHQoznhIi2PvRXv/PEg2TRXtBvFECMH
        eorlTJ3+/xF0FELcz8FQyLcNpmTpevx0yWTThWwIeZ+HK4qXtWfT7hh5sauL3hZb
        DlPyiNQvzMHp42H24pZun1M7FOvQwZLUPyg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KNnPDSbgZqoE for <linux-ide@vger.kernel.org>;
        Wed, 24 Aug 2022 17:13:38 -0700 (PDT)
Received: from [10.89.82.240] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.82.240])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MCk2n6nSZz1RtVk;
        Wed, 24 Aug 2022 17:13:37 -0700 (PDT)
Message-ID: <5b7fe985-6e5a-1d26-dc48-ac5000929e94@opensource.wdc.com>
Date:   Wed, 24 Aug 2022 17:13:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH] ATA: ACPI: Do not check ACPI_FADT_LOW_POWER_S0
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-ide@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <4426478.LvFx2qVVIh@kreacher>
 <9c479bb6-bb57-9b5a-2fa5-7b4d1b840245@opensource.wdc.com>
 <0b70fc12-6217-147f-c663-a1035738cf7d@amd.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <0b70fc12-6217-147f-c663-a1035738cf7d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/08/24 16:55, Mario Limonciello wrote:
> On 8/24/22 18:54, Damien Le Moal wrote:
>> On 2022/08/24 10:29, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> The patch title should be "ata: ahci: ..."
>>
>>>
>>> The ACPI_FADT_LOW_POWER_S0 flag merely means that it is better to
>>> use low-power S0 idle on the given platform than S3 (provided that
>>> the latter is supported) and it doesn't preclude using either of
>>> them (which of them will be used depends on the choices made by user
>>> space).
>>>
>>> For this reason, there is no benefit from checking that flag in
>>> ahci_update_initial_lpm_policy().
>>>
>>> First off, it cannot be a bug to do S3 with policy set to either
>>> ATA_LPM_MIN_POWER_WITH_PARTIAL or ATA_LPM_MIN_POWER, because S3 can be
>>> used on systems with ACPI_FADT_LOW_POWER_S0 set and it must work if
>>> really supported, so the ACPI_FADT_LOW_POWER_S0 check is not needed to
>>> protect the S3-capable systems from failing.
>>>
>>> Second, suspend-to-idle can be carried out on a system with
>>> ACPI_FADT_LOW_POWER_S0 unset and it is expected to work, so if setting
>>> policy to either ATA_LPM_MIN_POWER_WITH_PARTIAL or ATA_LPM_MIN_POWER is
>>> needed to handle that case correctly, it should be done regardless of
>>> the ACPI_FADT_LOW_POWER_S0 value.
>>>
>>> Accordingly, drop the ACPI_FADT_LOW_POWER_S0 check from
>>> ahci_update_initial_lpm_policy().
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>   drivers/ata/ahci.c |    3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> Index: linux-pm/drivers/ata/ahci.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/ata/ahci.c
>>> +++ linux-pm/drivers/ata/ahci.c
>>> @@ -1610,8 +1610,7 @@ static void ahci_update_initial_lpm_poli
>>>   	}
>>>   
>>>   #ifdef CONFIG_ACPI
>>> -	if (policy > ATA_LPM_MED_POWER &&
>>> -	    (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
>>> +	if (policy > ATA_LPM_MED_POWER) {
> 
> If making this change, perhaps the #ifdef CONFIG_ACPI can drop too.

Indeed.

> 
>>>   		if (hpriv->cap & HOST_CAP_PART)
>>>   			policy = ATA_LPM_MIN_POWER_WITH_PARTIAL;
>>>   		else if (hpriv->cap & HOST_CAP_SSC)
>>>
>>>
>>>
>>
>>
> 


-- 
Damien Le Moal
Western Digital Research
