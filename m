Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EDFEDE983
	for <linux-ide@archiver.kernel.org>; Thu, 14 Sep 2023 06:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbjINGHh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 14 Sep 2023 02:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjINGHg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 14 Sep 2023 02:07:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008D2E3
        for <linux-ide@vger.kernel.org>; Wed, 13 Sep 2023 23:07:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7527C433C8;
        Thu, 14 Sep 2023 06:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694671652;
        bh=y7cdEa2Scju2u5bxOrqMNFtJ4i2pXcs6joim1UatdG0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tJDwWodW+ffKznHkASVvGGZk6Pnp6kxAjoBjbixl1morKdgcUY3VsRELD/3jXbkpp
         5rpgO/GDqJJz1LLfIO++ztSOn0QUMBGbVDPYhg/sVjsdXaGMRnnX9XSr0P4zsIj7Hc
         ryMikJbKV7nhQA3s3O6ArL9s5kTuC3CU13joj/Q8tHtRfozdexg6PRgY+DJCbWB4dI
         naDaXPBjCK6HstNiP1+UUNY4PiK8+X8g2GNPkzARZtTBUmanHcwPwlBcMUcbG4psTm
         UzM4hd7GkNI3l6Uc8NymD0Aa9TGlwK27yLD5grbNZ5H92tzGLuiK8/Oo8lodoZXEhs
         D2TAoAZZdwpEA==
Message-ID: <86331db5-1204-0cae-6206-500ff759de49@kernel.org>
Date:   Thu, 14 Sep 2023 15:07:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata: libata-core: fetch sense data for successful
 commands iff CDL enabled
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, Niklas Cassel <nks@flawful.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        patenteng <dimitar@daskalov.co.uk>, linux-ide@vger.kernel.org,
        Niklas Cassel <niklas.cassel@wdc.com>
References: <20230913150443.1200790-1-nks@flawful.org>
 <9fb73646-ced8-4270-a047-d522d20f95e8@suse.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <9fb73646-ced8-4270-a047-d522d20f95e8@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/14/23 15:01, Hannes Reinecke wrote:
> On 9/13/23 17:04, Niklas Cassel wrote:
>> From: Niklas Cassel <niklas.cassel@wdc.com>
>>
>> Currently, we fetch sense data for a _successful_ command if either:
>> 1) Command was NCQ and ATA_DFLAG_CDL_ENABLED flag set (flag
>>     ATA_DFLAG_CDL_ENABLED will only be set if the Successful NCQ command
>>     sense data supported bit is set); or
>> 2) Command was non-NCQ and regular sense data reporting is enabled.
>>
>> This means that case 2) will trigger for a non-NCQ command which has
>> ATA_SENSE bit set, regardless if CDL is enabled or not.
>>
>> This decision was by design. If the device reports that it has sense data
>> available, it makes sense to fetch that sense data, since the sk/asc/ascq
>> could be important information regardless if CDL is enabled or not.
>>
>> However, the fetching of sense data for a successful command is done via
>> ATA EH. Considering how intricate the ATA EH is, we really do not want to
>> invoke ATA EH unless absolutely needed.
>>
>> Before commit 18bd7718b5c4 ("scsi: ata: libata: Handle completion of CDL
>> commands using policy 0xD") we never fetched sense data for successful
>> non-NCQ commands.
>>
>> In order to not invoke the ATA EH unless absolutely necessary, even if the
>> device claims support for sense data reporting, only fetch sense data for
>> successful (NCQ and non-NCQ commands) if CDL is supported and enabled.
>>
> Errm. We need sense data for zoned devices, do we not?

Any SATA device that supports sense reporting feature, including ZAC devices,
can still get sense data for failed commands.

This case is for the weird CDL aborts with policy 0xD which will fail a command
that exceeds its limits with a success status and sense data available bit set
in the SDB (which translate to ATA_SENSE flag). So for commands using CDL,
getting a success with ATA_SENSE set most likely means that the command was
aborted by the drive.

So this is not the regular error case. We still use EH to get that sense data
from the "sense data for successful NCQ command log" though, because otherwise
we can run into problems if we do not have a free tag.

> 
> Cheers,
> 
> Hannes

-- 
Damien Le Moal
Western Digital Research

