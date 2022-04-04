Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49BAC433EF
	for <linux-ide@archiver.kernel.org>; Mon,  4 Apr 2022 23:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiDDXce (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 4 Apr 2022 19:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiDDXce (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 4 Apr 2022 19:32:34 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B9C49C82
        for <linux-ide@vger.kernel.org>; Mon,  4 Apr 2022 16:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649115036; x=1680651036;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rfSRzuuOMCPWQIReuJhUJvddgNa1gMHj4PdD7IOpeIk=;
  b=cBONnZIaUE7gYQckjcpvlNXozof8nDkfl5eqPq5sRvlzgDimZCTiKEYP
   58/QKKBF2UYn2Ua8ylPvVW8MTHu9j9dQj/Blps5jQSyDniShT3qmq6iIx
   0oG670vJ+sGjn6mRx69byLWaLPkNg+G4UcBOkbkv9+HEUrIO/lK+INIPW
   shEK9YwUrp4rVSydtvopW30989urf2SAEByfeNquIQuuSdKwF/Rbquu1c
   371UPLpakX5I8Hlwz2sH8Ad0jqF1MN5YFgBegK0KWOlVc8IDRP47IhDKb
   YhsZmbtI/WCfhhb6oCBT1iRFqDyivkpLPzyd+kfUmZc1jq2Xewj86tTWD
   w==;
X-IronPort-AV: E=Sophos;i="5.90,235,1643644800"; 
   d="scan'208";a="197083762"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Apr 2022 07:30:33 +0800
IronPort-SDR: nGbXdpk7uAM/lEUifK//5oNj7uk3PqsSGvtqBRxjIUC4LeC7n/F20DZCVmYJPL0mBDHIpokN/k
 IIBqQH34nNk8ytPSXXe8ljncDPBV9JOG8BLh4uQWkxxh78msy1PHX3S4lhUeYNpKYiPVwVvq/l
 ClSIwZ8O8iYwjan2AmTZT0ceqcd0QUdrNi3ORbCFyze5M5XgXriDz0ZSICvxtTfAvsp01KGz08
 bVioAh+bCDomFCxYiji8Zr8tN7OygLNbO3R4Y7W41L/0yZkhlSY9uxQleVf7fhTZQF/lDyy7/7
 VWpdtBJb8ktmXc7P5a+0NjUV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2022 16:02:08 -0700
IronPort-SDR: l+iY5mxGKhcKzYlWdgK7Cyu+8mTB++J8WCV/XT41UbwpjYKOHZblX2ZTYuxqGwqcJnEp9lhdnI
 cGLUgreGN0gyhAGheLrZ4lgkPgJuHjQIol9Fdtu+zvKB1ytbQexWCl7uoWwigshULY1qD67A4e
 FleBXq5Gvzeov4ouQ2asJJrQAxeen+gFRta+WBSQhleQxKw4kaGc4DkpRZOwoxzSD4XwXpuwED
 A2U8f3glwV8aqVWORDeWjFH30Xb3zvoT+ex642ra/BxDtmRXYpr9hKYAYWqMa8u1DpfIydiZi9
 6iI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2022 16:30:35 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KXRpf0RWPz1SHwl
        for <linux-ide@vger.kernel.org>; Mon,  4 Apr 2022 16:30:34 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649115033; x=1651707034; bh=rfSRzuuOMCPWQIReuJhUJvddgNa1gMHj4Pd
        D7IOpeIk=; b=MHsLUaVp9zJKMa8HCkY10WpYYu5qCjblWtp40bDtx1W7E/C2SI9
        w5dlxdweXC5QgGXiv1lbNNarzHkaI8e9dignB//e/V7gveloF7OdhzSIAFoLtNCR
        RaviI2xOEkaJZnJX3dUq1vyLkPJeTya2alQOTIF70eBbemCWOrdlt1bQg8eipJhT
        432j3U7gyRkioVXIDMJAkFRSQtS16nhhRP4j/4ptUETJCQiCDahu1TndeheTZlGK
        HT6UYFxJ6are0LR6dN6hXrrKoWK3/ABc+DNc/lgCiw1Dej98JJJ33+Fv2HjbX4yF
        m1K84iEgZNLXmz8zS+YseOEandPz2zLZhrQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id w5nfJVY0SW0L for <linux-ide@vger.kernel.org>;
        Mon,  4 Apr 2022 16:30:33 -0700 (PDT)
Received: from [10.225.163.2] (unknown [10.225.163.2])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KXRpc63KMz1Rvlx;
        Mon,  4 Apr 2022 16:30:32 -0700 (PDT)
Message-ID: <fa0ade52-5d7b-88ae-5c68-c53c2968b852@opensource.wdc.com>
Date:   Tue, 5 Apr 2022 08:30:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] ata: ahci: Protect users from setting policies
 their drives don't support
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
References: <20220303034912.3615390-1-mario.limonciello@amd.com>
 <20220303034912.3615390-2-mario.limonciello@amd.com>
 <a6a17a22-0cde-9c46-0cd7-127be2cd2792@opensource.wdc.com>
 <BL1PR12MB51570E1C17A122179CCB0625E2E59@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <BL1PR12MB51570E1C17A122179CCB0625E2E59@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/5/22 04:39, Limonciello, Mario wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Sent: Sunday, April 3, 2022 20:11
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Cc: open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers) <linux-
>> ide@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>;
>> hdegoede@redhat.com
>> Subject: Re: [PATCH v2 2/2] ata: ahci: Protect users from setting policies their
>> drives don't support
>>
>> On 3/3/22 12:49, Mario Limonciello wrote:
>>> As the default low power policy applies to more chipsets and drives, it's
>>> important to make sure that drives actually support the policy that a user
>>> selected in their kernel configuration.
>>>
>>> If the drive doesn't support slumber, don't let the default policies
>>> dependent upon slumber (`min_power` or `min_power_with_partial`) affect
>> the
>>> disk.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Mario,
>>
>> Can you resend a rebased version of this, on top of libata for-5.19 branch ?
> 
> 
> OK.
> 
>>
>>> ---
>>> Changes from v1->v2:
>>> * Move deeper into codepaths
>>> * Reset to MED_POWER rather than ignore
>>>   drivers/ata/libata-sata.c | 11 +++++++++++
>>>   1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
>>> index 071158c0c44c..0dc03888c62b 100644
>>> --- a/drivers/ata/libata-sata.c
>>> +++ b/drivers/ata/libata-sata.c
>>> @@ -13,6 +13,7 @@
>>>   #include <scsi/scsi_device.h>
>>>   #include <linux/libata.h>
>>>
>>> +#include "ahci.h"
>>>   #include "libata.h"
>>>   #include "libata-transport.h"
>>>
>>> @@ -368,10 +369,20 @@ int sata_link_scr_lpm(struct ata_link *link, enum
>> ata_lpm_policy policy,
>>>   		      bool spm_wakeup)
>>>   {
>>>   	struct ata_eh_context *ehc = &link->eh_context;
>>> +	struct ata_port *ap = link->ap;
>>> +	struct ahci_host_priv *hpriv;
>>>   	bool woken_up = false;
>>>   	u32 scontrol;
>>>   	int rc;
>>>
>>> +	hpriv = ap->host->private_data;
>>> +	if (policy >= ATA_LPM_MIN_POWER_WITH_PARTIAL &&
>>> +	  !(hpriv->cap & HOST_CAP_SSC)) {
>>> +		dev_warn(ap->host->dev,
>>> +			"This drive doesn't support slumber; restting policy to
>> MED_POWER\n");
>>
>> Typo here: s/restting/resetting. Also, s/doesn't/does not.
>>
>>> +		policy = ATA_LPM_MED_POWER;
>>
>> Here, shouldn't we use the default policy defined by
>> CONFIG_SATA_LPM_POLICY ?
> 
> If they set it too aggressively we still don't want to honor it if the drive
> can't do slumber I would expect.

True. But if the default is set to a higher performance mode, we should
not fall back to the med-power mode.

We should either (1) fallback to the closest higher performance policy
supported, or (2) not change the current policy at all. no ?

See what ahci_update_initial_lpm_policy() does to check the possible
"initial" (the default ?) policy.



> 
>>
>>> +	}
>>> +
>>>   	rc = sata_scr_read(link, SCR_CONTROL, &scontrol);
>>>   	if (rc)
>>>   		return rc;
>>
>>
>> --
>> Damien Le Moal
>> Western Digital Research


-- 
Damien Le Moal
Western Digital Research
