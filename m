From: Tejun Heo <tj@kernel.org>
Subject: Re: Forcing a CAP register value to make booting more reliable on
 the Acer Aspire Switch Alpha 12 tablet
Date: Fri, 2 Dec 2016 11:11:46 -0500
Message-ID: <20161202161146.GA6033@htj.duckdns.org>
References: <CAFaEeaFuQCya0HrQNSQe1f1HZ18B=iCAoXKcxdhxv3uq_OzHFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:36281 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbcLBQLv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 2 Dec 2016 11:11:51 -0500
Received: by mail-yw0-f179.google.com with SMTP id a10so219934075ywa.3
        for <linux-ide@vger.kernel.org>; Fri, 02 Dec 2016 08:11:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAFaEeaFuQCya0HrQNSQe1f1HZ18B=iCAoXKcxdhxv3uq_OzHFA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sui Chen <suichen6@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

On Thu, Dec 01, 2016 at 05:57:55PM -0600, Sui Chen wrote:
> When the SSD is detected the following lines can be seen in the dmesg
> output:
>    [    1.347021] ahci 0000:00:17.0: version 3.0
>    [    1.365569] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 3 ports 6 Gbps
> 0x7 impl SATA mode
>    [    1.367519] ahci 0000:00:17.0: flags: 64bit ncq pm led clo only pio
> slum part deso sadm sds apst
>    [    1.377574] scsi host0: ahci
>    [    1.379465] scsi host1: ahci
>    [    1.381373] scsi host2: ahci
>    [    1.383060] ata1: SATA max UDMA/133 abar m2048@0xb1648000 port
> 0xb1648100 irq 124
>    [    1.384665] ata2: SATA max UDMA/133 abar m2048@0xb1648000 port
> 0xb1648180 irq 124
>    [    1.386305] ata3: SATA max UDMA/133 abar m2048@0xb1648000 port
> 0xb1648200 irq 124
> 
> However, when the SSD is not detecting:
>    [    1.337065] ahci 0000:00:17.0: version 3.0
> -> [    1.343206] ahci 0000:00:17.0: implemented port map (0x7) contains
> more ports than nr_ports (2), using nr_ports
> -> [    1.351165] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps
> *0x0* impl SATA mode
>    [    1.352323] ahci 0000:00:17.0: flags: 64bit ncq pm led clo only pio
> slum part deso sadm sds apst
>    [    1.355960] scsi host0: ahci
>    [    1.357292] scsi host1: ahci
> -> [    1.358405] ata1: *DUMMY*
> -> [    1.359466] ata2: *DUMMY*

That looks like BIOS messing up initial setup.

> One can note the differences in the marked lines in the dmesg output when
> the SSD is not detecting: 1) nr_ports becomes 2 instead of 3; 2) ATA1 and
> ATA2 are both DUMMY.
> 
> Adding the following lines in the function "ahci_save_initial_config" in
> file libahci.c, line 453 seems to fix this for now:
>     if ((cap & 0xC734FF00) == 0xC734FF00) {
>         dev_info(dev, "Forcing CAP to 0xC734FF02 and port_map to 0x7!\n");
>         hpriv->saved_cap = cap = 0xC734FF02;
>         hpriv->saved_port_map = port_map = 0x7;
>     }
> 
> What the code does is to force port_map to become 0x7 and saved_cap to
> become 0xC734FF02. Actually, when the SSD is detecting the cap register
> holds a value of 0xC734FF02 but when it fails, cap can be either 0xC734FF01
> or 0xC734FF00.
> 
> My questions are:
> Is this a bad way of solving this or possibly damage the computer?
> Could this also possibly be related to the BIOS of the specific computer?

We have a bunch of system-specific workarounds implemented in ahci.c.
Look for DMI_MATCH().  I think this can be handled the same way.
Match the system and just override CAP to the sane value.

Thanks.

-- 
tejun
