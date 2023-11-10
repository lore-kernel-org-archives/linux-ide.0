Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D522C4332F
	for <linux-ide@archiver.kernel.org>; Fri, 10 Nov 2023 00:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjKJAoA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Nov 2023 19:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjKJAn6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Nov 2023 19:43:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42513272
        for <linux-ide@vger.kernel.org>; Thu,  9 Nov 2023 16:43:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7C1C433C7;
        Fri, 10 Nov 2023 00:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699577034;
        bh=KoLaZU+ndd0Cri4CGbRLGjMa2LyamttOikFjdJM8zVk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qpkKz5IHfIfr2Xpzi10YhPH8wiZ8RmVfLo/j1oUTUv/RE2ThqMax+MQuN7viZx7tS
         HH4j6CAlBecAH0ipgOlgqi2AUxkeGAL6GcULN5EiIMUY45JBa5VHtQQ76sXcaVyFjp
         2EHpuibMb6Fj1WXakaRJURJw2IjBnjOU+5XLPhVGlFQTSqfZig4+1Z2cK/0oWEyJFT
         hrsSw/dRr+sVXoywX/2C4bqfhugMssir5j1IwODDU01Yuwz1RpJXzkxhJblSinPNFs
         TSozdbqhY3KRfR3js2wna6kXNZrZPRaG1bWIMFvvqx4dCxEtdhQk9jx5Mi2OKEPkJQ
         zakFXXEsXzArA==
Message-ID: <466c88a7-8a71-4835-98ad-0ade0c17c1a8@kernel.org>
Date:   Fri, 10 Nov 2023 09:43:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/23] scsi: sd: Differentiate system and runtime
 start/stop management
Content-Language: en-US
To:     Phillip Susi <phill@thesusis.net>
Cc:     linux-ide@vger.kernel.org
References: <87edhz3bry.fsf@vps.thesusis.net>
 <672365d4-bdd6-47c9-b0be-6756f523db59@kernel.org>
 <871qdyh9na.fsf@vps.thesusis.net>
 <ff334ece-ca5b-490b-91d7-6bb51fd2e2b3@kernel.org>
 <87sf63hnbg.fsf@vps.thesusis.net>
 <969790e6-7050-43b9-bb0b-4b55baa21cc9@kernel.org>
 <87h6m24srm.fsf@vps.thesusis.net>
 <9868ba0d-7d31-4671-84a3-33bca029f89d@kernel.org>
 <871qd1n0cm.fsf@vps.thesusis.net> <87a5rpz13n.fsf@vps.thesusis.net>
 <7141dc0d-eb1d-41d4-a608-c1fd569e4325@kernel.org>
 <875y2buc13.fsf@vps.thesusis.net> <87pm0ipoiv.fsf@vps.thesusis.net>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <87pm0ipoiv.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/10/23 07:09, Phillip Susi wrote:
> Phillip Susi <phill@thesusis.net> writes:
> 
>> I hadn't pulled in some time.  Updating now.
> 
> Great... the latest post 6.6 kernel hangs on entry to suspend for me.
> Bisecting it now back to the 6.6-rc5 that was previously working.

I checked again and all is fine for me on qemu and on my test systems.
With qemu, I do see this on resume:

[  168.724355] ACPI: PM: Low-level resume complete
[  168.726261] ACPI: PM: Restoring platform NVS memory
[  168.729790] ------------[ cut here ]------------
[  168.731076] WARNING: CPU: 0 PID: 938 at drivers/base/syscore.c:103
syscore_resume+0x1f9/0x230
[  168.734205] ---[ end trace 0000000000000000 ]---
[  168.736875] Enabling non-boot CPUs ...
[  168.739185] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  168.748806] CPU1 is up
...

That is new. But that may be a qemu issue.

For the real hardware, which includes a PMP box connected to an ASMedia adapter,
I get this on resume for the drives connected to PMP:

[58290.563637] ata10.00: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[58291.043728] ata10.01: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[58291.523829] ata10.02: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[58291.844544] ata10.03: SATA link down (SStatus 0 SControl 330)
[58292.164943] ata10.04: SATA link down (SStatus 0 SControl 330)
[58292.485311] ata10.05: SATA link down (SStatus 0 SControl 330)
[58292.804215] ata10.06: SATA link down (SStatus 0 SControl 330)
[58293.123028] ata10.07: SATA link down (SStatus 0 SControl 330)
[58293.443913] ata10.08: SATA link down (SStatus 0 SControl 330)
[58293.763285] ata10.09: SATA link down (SStatus 0 SControl 330)
[58295.373838] ata10.00: configured for UDMA/133
[58295.378596] ata10.00: Entering active power mode
[58305.536662] ata10.00: qc timeout after 10000 msecs (cmd 0x40)
[58305.549455] ata10.00: VERIFY failed (err_mask=0x4)
[58305.560870] ata10.01: failed to read SCR 0 (Emask=0x40)
[58305.570953] ata10.01: failed to IDENTIFY (I/O error, err_mask=0x40)
[58305.580431] ata10.01: revalidation failed (errno=-5)
[58308.047142] ata10.00: hard resetting link
[58308.529006] ata10.00: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[58309.017039] ata10.01: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[58309.505029] ata10.02: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[58309.522564] ata10.00: configured for UDMA/133
[58309.541098] ata10.01: configured for UDMA/133
[58309.554900] ata10.01: Entering active power mode
[58319.872693] ata10.01: qc timeout after 10000 msecs (cmd 0x40)
[58319.883979] ata10.01: VERIFY failed (err_mask=0x4)
[58319.894481] ata10.02: failed to read SCR 0 (Emask=0x40)
[58319.904346] ata10.02: failed to IDENTIFY (I/O error, err_mask=0x40)
[58319.913584] ata10.02: revalidation failed (errno=-5)
[58321.142463] ata10.00: hard resetting link
[58321.625077] ata10.00: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[58321.638685] ata10.01: hard resetting link
[58322.121098] ata10.01: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[58322.609043] ata10.02: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[58322.930618] ata10.03: SATA link down (SStatus 0 SControl 330)
[58323.258625] ata10.04: SATA link down (SStatus 0 SControl 330)
[58323.585871] ata10.05: SATA link down (SStatus 0 SControl 330)
[58323.914277] ata10.06: SATA link down (SStatus 0 SControl 330)
[58324.242533] ata10.07: SATA link down (SStatus 0 SControl 330)
[58324.570485] ata10.08: SATA link down (SStatus 0 SControl 330)
[58324.898665] ata10.09: SATA link down (SStatus 0 SControl 330)
[58326.545243] ata10.00: configured for UDMA/133
[58326.557807] ata10.01: configured for UDMA/133
[58326.568930] ata10.02: configured for UDMA/133
[58326.578750] ata10.02: Entering active power mode

Note the timeouts for verify. They are due to the disks being slow to spin up.
Using the same timeouts as for scan on boot causes this. With a regular boot,
the time from system power up to the time libata starts probing is enough to
have the disks fully spun up, but with a resume, that same time is very short
and the drives have barely started spinning. So depending on the drives, the
initial 10s timeout is simply not enough. The second timeout after the hard
reset is however long enough for the drives to spinup and revalidation to
complete without any issue. All the drives are back.

Will patch that to increase the timeouts for verify command after a resume, to
avoid this useless hardreset.

-- 
Damien Le Moal
Western Digital Research

