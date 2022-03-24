Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ACEC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 24 Mar 2022 06:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiCXGhG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Mar 2022 02:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbiCXGhF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2022 02:37:05 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE6D972CF
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 23:35:33 -0700 (PDT)
Received: from [192.168.0.3] (ip5f5ae8e8.dynamic.kabel-deutschland.de [95.90.232.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id EC82461E64846;
        Thu, 24 Mar 2022 07:35:31 +0100 (CET)
Message-ID: <262f35db-71bb-2e3d-58e6-79b241b34c23@molgen.mpg.de>
Date:   Thu, 24 Mar 2022 07:35:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/4] Remove link debounce delays by default
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
References: <20220323081740.540006-1-damien.lemoal@opensource.wdc.com>
 <faf15c10-88f4-b530-ce6f-95209e4d5daf@molgen.mpg.de>
 <e272c885-58f8-b046-a951-9069601afba8@opensource.wdc.com>
 <c1aaaaac-aacb-5e71-9dc9-db235e469a3d@molgen.mpg.de>
 <f755d95a-83e5-1d3c-9255-f0111ac4d273@opensource.wdc.com>
 <fb5c4bc7-3ee4-851d-08f5-e8c17ed81e18@molgen.mpg.de>
 <9b59a933-b5fc-732f-c3d5-650fe5125cab@opensource.wdc.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <9b59a933-b5fc-732f-c3d5-650fe5125cab@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Dear Damien,


Am 24.03.22 um 07:15 schrieb Damien Le Moal:
> On 3/24/22 14:30, Paul Menzel wrote:

>> Am 24.03.22 um 00:58 schrieb Damien Le Moal:
>>> On 3/23/22 19:59, Paul Menzel wrote:
>>>>>> It’d be great if you gave an example benchmark.
>>>>>
>>>>> No need for a benchmark. This is not hot path stuff. This code runs only
>>>>> during device discovery on boot and on resume after suspend.
>>>>> So apply the patches and reboot, check dmesg if you see errors or not and
>>>>> if your disks are all there. Same after a suspend+resume.
>>>>
>>>> Yes, I know what I need to check. I meant, that you write without this
>>>> patchset my system with HBA controller X and 32 [vendor/model] disks
>>>> attached reaches the message Y in Z1 seconds, and with the series Z2
>>>> seconds.
>>>
>>> There is going to be too much variation from machine to machine as that
>>> depends on the adapter & devices used for testing. The only sensible thing
>>> to do is to compare timing before patching with timing after patching and
>>> see if there are some gains. On my test rig, I have so many drives and
>>> various HBAs connected that the boot time gains overall are nil. But I do
>>> see faster per-ata drive scan times.
>>
>> And for one of these it’d be great to have exact numbers. ;-)
>>
>>>>>>> Comments and lots of testing are welcome !
>>>>>>>
>>>>>>> Damien Le Moal (4):
>>>>>>>       ata: libata-sata: Simplify sata_link_resume() interface
>>>>>>>       ata: libata-sata: Introduce struct sata_deb_timing
>>>>>>>       ata: libata-sata: Remove debounce delay by default
>>>>>>>       ata: libata-sata: Improve sata_link_debounce()
>>>>>>
>>>>>> […]
>>>>>>
>>>>>> I am wondering how sure we can be, there won’t be any regressions? Not
>>>>>> having the boot disk detected is quite a serious issue/regression, and
>>>>>> it should be made easy for users to fix that without having to rebuild
>>>>>> the Linux kernel. A Linux kernel CLI parameter to enable the delay would
>>>>>> be helpful for effected users.
>>>>>
>>>>> I am working on another series for that. The patches will allow
>>>>> controlling most horkage and link flags on/off using libata.force kernel
>>>>> boot parameter. That will allow figuring out problems without patching in
>>>>> the field, for patches to be later added.
>>>>
>>>> Sounds good. But this needs to be available before the changes at hand,
>>>> doesn’t it?
>>>
>>> Not really. For now, we need to check if these patches break anything,
>>> regardless of the libata.force changes. I consider libata.force for field
>>> debugging. A user should not have to use it to get a system running. The
>>> kernel should have sensible defaults for that and things should run out of
>>> the box without the need for additional kernel boot parameters.
>>
>> Sorry, I have the feeling we misunderstand each other. Just to be clear,
>> you are saying before shipping this to users, we can be 100 % certain
>> that these changes won’t break any systems out there?
> 
> The patches are only an improvement for what can be controlled using the
> libata.force boot parameter. No other change. So nothing will break with
> these patches.

Still we are misunderstanding each other? I am talking about the testing 
and possible regressions of the debounce delay patches, and not the 
“libata.force/horkage patches”.

> See Documentation/admin-guide/kernel-parameters.txt and compare the list
> of possible arguments that libata.force can take to the number of
> ATA_HORKAGE and ATA_LFLAGS defined... There are many that cannot be
> tweaked using libata.force, which is a pain when debugging a problem in
> the field. With more arguments for libata.force, we can test adding by
> default horkages/lflags for a device without having to patch and recompile
> a kernel, tasks that many end user do not know how to do.

Yes, I agree, that the “libata.force/horkage patches” are going to be safe.


Kind regards,

Paul
