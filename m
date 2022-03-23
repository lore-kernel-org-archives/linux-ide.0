Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D78BC433EF
	for <linux-ide@archiver.kernel.org>; Wed, 23 Mar 2022 08:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbiCWIqm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 04:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240366AbiCWIqk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 04:46:40 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B0D4B1F2
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 01:45:10 -0700 (PDT)
Received: from [192.168.0.7] (ip5f5ae903.dynamic.kabel-deutschland.de [95.90.233.3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 809D861E6478B;
        Wed, 23 Mar 2022 09:45:09 +0100 (CET)
Message-ID: <6211e521-0688-c263-91de-07c0fe401814@molgen.mpg.de>
Date:   Wed, 23 Mar 2022 09:45:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/4] Remove link debounce delays by default
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
References: <20220323081740.540006-1-damien.lemoal@opensource.wdc.com>
 <faf15c10-88f4-b530-ce6f-95209e4d5daf@molgen.mpg.de>
In-Reply-To: <faf15c10-88f4-b530-ce6f-95209e4d5daf@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

[Use Mario’s current address]

Am 23.03.22 um 09:43 schrieb Paul Menzel:
> Dear Damien,
> 
> 
> Thank you for sending these patches.
> 
> Am 23.03.22 um 09:17 schrieb Damien Le Moal:
>> This series removes the long link debounce delays by default for all
>> adapters, except for those known to require these delays
>> (e.g. ata_piix).
> 
> Is it know, or just a theory?
> 
>> The first 2 patches are code cleanup improving the interface of several
>> functions handling delays.
>>
>> Patch 3 removes the long delay in sata_link_resume() and reverses the
>> link flag ATA_LFLAG_NO_DEBOUNCE_DELAY to ATA_LFLAG_DEBOUNCE_DELAY for
>> adapters to request the delay if needed.
>>
>> Patch 4 improves sata_link_debounce() by shortening the link stability
>> test, unless the link has the ATA_LFLAG_DEBOUNCE_DELAY flag set.
>>
>> This series was tested on a machine with 2 AHCI adapters (Intel and
>> Marvell) with a port-multiplier box attached to cover that case too.
> 
> It’d be great if you gave an example benchmark.
> 
>> Comments and lots of testing are welcome !
>>
>> Damien Le Moal (4):
>>    ata: libata-sata: Simplify sata_link_resume() interface
>>    ata: libata-sata: Introduce struct sata_deb_timing
>>    ata: libata-sata: Remove debounce delay by default
>>    ata: libata-sata: Improve sata_link_debounce()
> 
> […]
> 
> I am wondering how sure we can be, there won’t be any regressions? Not 
> having the boot disk detected is quite a serious issue/regression, and 
> it should be made easy for users to fix that without having to rebuild 
> the Linux kernel. A Linux kernel CLI parameter to enable the delay would 
> be helpful for effected users.
> 
> 
> Kind regards,
> 
> Paul
