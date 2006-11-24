From: "Berck E. Nash" <flyboy@gmail.com>
Subject: Re: [PATCH] ahci: do not powerdown during initialization
Date: Fri, 24 Nov 2006 10:53:39 -0700
Message-ID: <456731A3.8070807@gmail.com>
References: <20061120064236.GM2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:5569 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S934998AbWKXRxn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Nov 2006 12:53:43 -0500
Received: by wx-out-0506.google.com with SMTP id h27so965269wxd
        for <linux-ide@vger.kernel.org>; Fri, 24 Nov 2006 09:53:43 -0800 (PST)
In-Reply-To: <20061120064236.GM2184@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> This patch moves power up/down out of port init/deinit and call them
> only when needed.
> ---
> 
> Berck, can you please test this patch?  This might fix your problem
> too.  Jeff, this patch is necessary regardless of Berck's repsonse.  I
> think this should go into #usptream-fixes too after some testing in
> #upstream (and in -mm).

Nope, that doesn't do it.  All along I've also been getting weird 
messages on system power-downs.  I just now set up a serial console to 
capture them.  I dunno if they're of any significance, but they're on 
the same device that pauses on boot, so perhaps they're related.

Berck

Will now halt.
[  538.178188] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  538.191083] ata2.00: (irq_stat 0x40000001)
[  538.199288] ata2.00: tag 0 cmd 0xe0 Emask 0x1 stat 0x51 err 0x4 
(device error)
[  538.222873] ata2.00: configured for UDMA/133
[  538.231432] ata2: EH complete
[  538.237406] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  538.250289] ata2.00: (irq_stat 0x40000001)
[  538.258497] ata2.00: tag 0 cmd 0xe0 Emask 0x1 stat 0x51 err 0x4 
(device error)
[  538.282048] ata2.00: configured for UDMA/133
[  538.290606] ata2: EH complete
[  538.296580] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  538.309465] ata2.00: (irq_stat 0x40000001)
[  538.317672] ata2.00: tag 0 cmd 0xe0 Emask 0x1 stat 0x51 err 0x4 
(device error)
[  538.341206] ata2.00: configured for UDMA/133
[  538.349764] ata2: EH complete
[  538.355738] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  538.368621] ata2.00: (irq_stat 0x40000001)
[  538.376834] ata2.00: tag 0 cmd 0xe0 Emask 0x1 stat 0x51 err 0x4 
(device error)
[  538.400367] ata2.00: configured for UDMA/133
[  538.408920] ata2: EH complete
[  538.414894] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  538.427783] ata2.00: (irq_stat 0x40000001)
[  538.435987] ata2.00: tag 0 cmd 0xe0 Emask 0x1 stat 0x51 err 0x4 
(device error)
[  538.459528] ata2.00: configured for UDMA/133
[  538.468077] ata2: EH complete
[  538.474054] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  538.486941] ata2.00: (irq_stat 0x40000001)
[  538.495144] ata2.00: tag 0 cmd 0xe0 Emask 0x1 stat 0x51 err 0x4 
(device error)
[  538.518681] ata2.00: configured for UDMA/133
[  538.527242] ata2: EH complete
[  538.533219] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  538.546113] ata2.00: (irq_stat 0x40000001)
[  538.554319] ata2.00: tag 0 cmd 0x94 Emask 0x1 stat 0x51 err 0x4 
(device error)
[  538.577860] ata2.00: configured for UDMA/133
[  538.586410] ata2: EH complete
[  538.592387] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  538.605269] ata2.00: (irq_stat 0x40000001)
[  538.613475] ata2.00: tag 0 cmd 0x94 Emask 0x1 stat 0x51 err 0x4 
(device error)
[  538.637015] ata2.00: configured for UDMA/133
[  538.645566] ata2: EH complete
[  538.651540] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  538.664425] ata2.00: (irq_stat 0x40000001)
[  538.672634] ata2.00: tag 0 cmd 0x94 Emask 0x1 stat 0x51 err 0x4 
(device error)
[  538.696179] ata2.00: configured for UDMA/133
[  538.704742] ata2: EH complete
[  538.710716] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  538.723601] ata2.00: (irq_stat 0x40000001)
[  538.731807] ata2.00: tag 0 cmd 0x94 Emask 0x1 stat 0x51 err 0x4 
(device error)
[  538.755349] ata2.00: configured for UDMA/133
[  538.763900] ata2: EH complete
[  538.769873] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  538.782765] ata2.00: (irq_stat 0x40000001)
[  538.790965] ata2.00: tag 0 cmd 0x94 Emask 0x1 stat 0x51 err 0x4 
(device error)
[  538.814513] ata2.00: configured for UDMA/133
[  538.823073] ata2: EH complete
[  538.829047] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  538.841933] ata2.00: (irq_stat 0x40000001)
[  538.850140] ata2.00: tag 0 cmd 0x94 Emask 0x1 stat 0x51 err 0x4 
(device error)
[  538.873679] ata2.00: configured for UDMA/133
[  538.882233] ata2: EH complete
[  538.888199] SCSI device sdd: 640 512-byte hdwr sectors (0 MB)
[  538.890404] Synchronizing SCSI cache for disk sde:
[  538.909477] sdd: Write Protect is off
[  538.916822] SCSI device sdd: drive cache: write through
[  538.927285] SCSI device sdd: 640 512-byte hdwr sectors (0 MB)
[  538.938797] Synchronizing SCSI cache for disk sdc:
[  538.948561] sdd: Write Protect is off
[  538.949171] Synchronizing SCSI cache for disk sdb:
[  538.949424] Synchronizing SCSI cache for disk sda:
[  538.975451] SCSI device sdd: drive cache: write through
[  539.441444] Shutdown: hdg
[  539.446910] Shutdown: hde
[  539.452716] Power down.
[  539.457706] acpi_power_off called



