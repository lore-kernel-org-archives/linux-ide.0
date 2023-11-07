Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EA4C4167D
	for <linux-ide@archiver.kernel.org>; Tue,  7 Nov 2023 23:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjKGXNW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 7 Nov 2023 18:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbjKGXMf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Nov 2023 18:12:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C49525B5
        for <linux-ide@vger.kernel.org>; Tue,  7 Nov 2023 15:11:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC4BC433C8;
        Tue,  7 Nov 2023 23:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699398662;
        bh=NT7DfcMoPvhby3NQg15h8JMCZ1ONWPWrdZVUIpuK+sI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WunV1mbIbv/OgXKpzViJQKmJRVPRRauN1D2qijjprhPCbd/3S3qvmlz59KtAhExrA
         9u+ckWGGyVqYnQ+nLYJcNYmZwCW7KqVXT+yAgBUVKv1LfZ1iuvOEGvJmmlAgprdUoJ
         l3J6Poc7o6wGtH1WtXv24y5IIPW0hwES71Xw/hpY5tWbIRzu6SrngX+y8i+4UOs4lu
         kK01Qx+hn5uyjJKu97dy3ue5dr1c182Q58eC2Dgcxh585CZ4cYxgkrZ2uihLC8O/IT
         9ilCqPVavpxERvWxTCwUkTzzVwjxrossnwr/3tEpAGbMYAbKGH/EhcGIIKX2l51T+D
         Xr7Dh5qVpnXBw==
Message-ID: <7141dc0d-eb1d-41d4-a608-c1fd569e4325@kernel.org>
Date:   Wed, 8 Nov 2023 08:11:00 +0900
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
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <87a5rpz13n.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/8/23 06:48, Phillip Susi wrote:
> Phillip Susi <phill@thesusis.net> writes:
> 
>> I normally cd -P /sys/block/sda, which gets me into what appears to be
>> the scsi lun.  Going up a few directories through the scsi target, scsi
>> host, and finally to the ataX, I find that node's power/control is
>> set to on, and if I change it to auto, then dmesg shows the port doing
>> runtime suspend and resume.  I think there was another ata_port
>> subdirectory in there somewhere, maybe that's the one you're looking at?
>> I'm not sure what the difference is between ata8 and ata8/ata_port/ata8,
>> but I think the latter did not support runtime pm, so I'm guessing that
>> is the one you are looking at.
> 
> I checked, and yea, /sys/class/ata_port/ataX is the sub level
> ataX/ata_port/ataX, and that does not support runtime pm.  It's the
> upper level that does.  I still don't understand why the port appears to
> be a child of itself.  At first, I thought maybe it is the root port vs
> child ports of the PMP, but even on my PMP, it still only contains a
> single port under ata8/ata_port/ata8/.

Ah, the joy of PMP :)
There are 2 types of PMP:
1) Command based switching: one port can be used to connect up to 15 drives, but
all drives cannot be used at the same time, similarly to PATA. One command is
sent to one drive and another command will not be issued to another drive until
the previous commands complete. So no NCQ with this.
2) FIS based switching: up to 15 drives can be connected to the physical port
and the devices can be used simultaneously, including with NCQ.

Depending on this, management in libata/libahci/ahci differs. See
ata_port->pmp_links[] array being used, despite the fact that we have
ata_port->link per port. This is all not trivial and not being the author of
this old support code, I often get confused with this myself. I have both types
of PMP in the lab, but I never really dug too much into it since eSATA is old
technology that no-one sells anything anymore. So this is all in "maintenance"
mode. Nothing new will ever be implemented for PMP, only bug fixes. All the
eSata boxes I have actually crash/do not work at all if I plug very recent
drives into them...

Your PMP is looking like type (1).

> When I enable runtime pm on the drives and the top level port, then try
> to access the sleeping drive, I see this:

How can you enable runtime PM on a port ? That does not work...

> [49990.120581] sd 7:0:0:0: [sdd] Synchronizing SCSI cache
> [49990.120746] sd 7:0:0:0: [sdd] Stopping disk
> [50008.056699] sd 7:1:0:0: [sde] Synchronizing SCSI cache
> [50008.056907] sd 7:1:0:0: [sde] Stopping disk
> [50022.913268] ata8.00: Entering standby power mode
> [50023.313106] ata8.01: Entering standby power mode
> [50077.660449] ata8.15: SATA link down (SStatus 0 SControl 300)
> [50078.290513] ata8.15: failed to read PMP GSCR[0] (Emask=0x100)
> [50078.290528] ata8.15: PMP revalidation failed (errno=-5)
> [50083.349144] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [50083.663061] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
> [50083.975250] ata8.01: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
> [50083.976788] ata8.00: configured for UDMA/100
> [50083.976798] ata8.00: Activating
> [50083.978736] ata8.01: configured for UDMA/100
> [50083.978747] ata8.01: Activating
> [50083.979407] ata8.00: Activating
> [50083.979480] ata8.01: Activating
> [50083.979674] sd 7:1:0:0: [sde] Starting disk
> 
> So it looks like ata8.00 and .01 are suspended, which seems odd since
> those are the names of the ata_links, and not the ata_port ( either sub
> or top level, where you actually enable the runtime pm ).  I would

They are the first 2 devices connected to the PMP port that exist. These
correspond to your sdd and sde scsi disks.

> expect the downstream links to have to be susspended first, and THEN the
> PMP link, and finally the root port.  How is it that the two drive links
> appear to be suspended when the links don't support runtime pm, only the
> port?

If there is no PM op defined for a device (link in this case), PM core assumes
nothing needs to be done and sets the device pm state directly. At least, that
is my understanding. Would need to check again the pm code to be 100% sure.

The other thing here is that we have scsi_disk -> scsi_device -> ata_port
ancestry relationship. For the ata device and link, we have:

ata_device -> ata_link -> ata_port

So scsi_device and ata_device/link do not have any parent-child relation,
leading to the PM core code to not introduce and dependencies for their power state.

> Then when I later poke the disk, it looks like libata notices that the
> root port is down ( because it was runtime suspended ), but tries to
> revalidate the PMP anyhow, which fails, then it does another round of
> eh where the root port is reset, I assume this time revalidating the PMP
> works, and then the downstream links are reset, then for some reason,
> the two individual drives are both activated twice ( like how I noted
> happens to my optical drive after system resume ).

Are you running the latest code from Linus tree ? There is now a check on the
power state of a device to avoid useless activate.

> 
>> I'll try to get you the config tonight.  My internal drives are on an
>> Intel AHCI controller built into the southbridge of my chipset.  My
>> external drives are on another cheap AHCI eSATA controller I got, since
>> the Intel doesn't support hotplug or PMP iirc.
> 
> Internal lspci -v:
> 
> 00:17.0 SATA controller: Intel Corporation Q170/Q150/B150/H170/H110/Z170/CM236 Chipset SATA Controller [AHCI Mode] (rev 31) (prog-if 01 [AHCI 1.0])
>         Subsystem: ASUSTeK Computer Inc. Q170/Q150/B150/H170/H110/Z170/CM236 Chipset SATA Controller [AHCI Mode]
>         Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 127
>         Memory at f7f48000 (32-bit, non-prefetchable) [size=8K]
>         Memory at f7f4c000 (32-bit, non-prefetchable) [size=256]
>         I/O ports at f050 [size=8]
>         I/O ports at f040 [size=4]
>         I/O ports at f020 [size=32]
>         Memory at f7f4b000 (32-bit, non-prefetchable) [size=2K]
>         Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Capabilities: [70] Power Management version 3
>         Capabilities: [a8] SATA HBA v1.0
>         Kernel driver in use: ahci
>         Kernel modules: ahci
> 
> External lspci -v:
> 
> 05:00.0 SATA controller: JMicron Technology Corp. JMB363 SATA/IDE Controller (rev 02) (prog-if 01 [AHCI 1.0])

I think I may have one of these in the lab. I am currently using a ASMedia
ASM1062 controller which shows the PMP drives exactly like your setup. On
another machine, I have a more intelligent Marvell PMP adapter which has FBS
support.

> kernel-config
> 
> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/x86 6.6.0-rc5 Kernel Configuration

Please switch to using Linus latest tree (libata for-6.7 branch) as that has
some additional changes around suspend/resume.


-- 
Damien Le Moal
Western Digital Research

