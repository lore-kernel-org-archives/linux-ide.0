Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A38C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 14 Feb 2022 07:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240907AbiBNHKE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 14 Feb 2022 02:10:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiBNHKD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 14 Feb 2022 02:10:03 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7BF583BC
        for <linux-ide@vger.kernel.org>; Sun, 13 Feb 2022 23:09:55 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aebfe.dynamic.kabel-deutschland.de [95.90.235.254])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2D24961EA1924;
        Mon, 14 Feb 2022 08:09:54 +0100 (CET)
Message-ID: <036507f3-91bb-6480-7252-ff100a282ebe@molgen.mpg.de>
Date:   Mon, 14 Feb 2022 08:09:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 0/2][RFC] Make delay before debouncing configurable
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>
References: <20220113154635.17581-1-pmenzel@molgen.mpg.de>
 <85153d62-15b6-e055-00aa-74b728bb0195@opensource.wdc.com>
 <robbat2-20220119T172913-356389698Z@orbis-terrarum.net>
 <5cc9bb8d-e228-c11f-feef-5cfba631057a@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <5cc9bb8d-e228-c11f-feef-5cfba631057a@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Dear Damien, dear Robin,


Am 20.01.22 um 01:14 schrieb Damien Le Moal:
> On 2022/01/20 2:57, Robin H. Johnson wrote:
>> Hi, not originally in the thread, but I've run into hardware where the
>> delay was bumpy before, when I did early porting around SATA PMP code
>> (https://dev.gentoo.org/~robbat2/patches/libata-development/ if you want
>> to see really old patches from 2006)
>>
>> This series esp of a code approach that didn't get merged might be
>> interesting, that implements hotplug by polling:
>> https://dev.gentoo.org/~robbat2/patches/libata-development/2007/00-hp-poll/

Polling and a warning, when polling time exceeds like 10 ms, so users 
can contact the hardware vendor, would indeed be the most flexible solution.

Robin, do you remember, why these patches were not applied? Just lack of 
time and review, or where there issues?

>> On Fri, Jan 14, 2022 at 06:23:26PM +0900, Damien Le Moal wrote:
>>> On 1/14/22 00:46, Paul Menzel wrote:
>>>> The 200 ms delay before debouncing the PHY was introduced for some buggy
>>>> old controllers. To decrease the boot time to come closer do instant
>>>> boot, add a parameter so users can override that delay.
>>>>
>>>> The current implementation has several drawbacks, and is just a proof of
>>>> concept, which some experienced Linux kernel developer can probably
>>>> implement in a better way.
>>> I do not think that a libata module parameter is not the way to go with
>>> this: libata is used by all drivers, so for a system that has multiple
>>> adapters, different delays cannot be specified easily.
>> I think this is a key thing here; and I like that your patch moves to a
>> flag.

Indeed, I did not think of that.

>>> I am really thinking that the way to go about this is to remove the
>>> 200ms delay by default and add it only for drivers that request it with
>>> a link flag. That is, ATA_LFLAG_NO_DEBOUNCE_DELAY needs to become
>>> ATA_LFLAG_DEBOUNCE_DELAY.
>> I agree that removing it by default is right, but I'd like to make one
>> additional request here:
>> Please add a libata.force= flag that lets users enable/disable the delay
>> per adapter/link.
>>
>> I think this would be valuable to rule out issues where the debounce
>> delay is needed on the drive side more than the controller side, esp. in
>> cases of poorly implemented port multipliers as Tejun & I found back in
>> 2006.
>>
>> Maybe libata.force=X.Y:no_debounce_delay & libata.force=X.Y:force_debounce_delay
>>
>> The ata_parse_force_one function as it stands can't handle a parameter
>> to the value, so you cannot get libata.force=X.Y:debounce_delay=N
>> without also improving ata_parse_force_one.
> 
> Good point. I will look into adding this.

Awesome.

>>> The other large delay is the link stability check in
>>> sata_link_debounce(). 100ms is added (more for hotplug case) to ensure
>>> that the SStatus register DET field provides a stable value. But I
>>> cannot find any text in the AHCI and SATA IO specs that mandate such
>>> large delay.
>> Nice find!

Adding back Damien’s answer text:

>> I tried to address all of the above. Please have a look at the top 4
>> patches in the sata-timing branch of the libata tree:
>> 
>> git@gitolite.kernel.org:pub/scm/linux/kernel/git/dlemoal/libata
>> 
>> The sata-timing branch is for now based on libata for-5.17 branch.

Thank you for cooking this up. I tested this on the ASUS F2A85-M PRO 
(AMD, 1022:0x7801), MSI B350M MORTAR (AMD, 1022:0x7901), and IBM S822LC 
(Marvell, 1b4b:9235) with no issues and the expected decrease in boot time.

>>> There are differences between the many HDDs & SSDs I have connected
>>> though. There is a lot of scheduling side effects at play, so the gains
>>> are variable in my case. A system with a single disk attached should be
>>> used for proper evaluation.
>> That gets likely single-disk worst/best case, but I'm still worried
>> about port multipliers (sadly I don't have the worst-implemented ones
>> anymore, I sold them to some Windows users)
> 
> :)
> 
> I have a e-sata port-multiplier box in the lab. But I need to hook it up to my
> test box, which means that I have to get out of home for once and go to the
> office :) Will do that. Port-multiplier tests are also needed to complete Hannes
> series renaming sysfs fields to match the debug messages.


Kind regards,

Paul
