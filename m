From: Tejun Heo <tj@kernel.org>
Subject: Re: hitting a WARN() in ata_host_activate on 4.13
Date: Wed, 20 Sep 2017 15:23:38 -0700
Message-ID: <20170920222337.GD828415@devbig577.frc2.facebook.com>
References: <20170920021120.ldddwe3pd3ynizjd@smitten>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:48094 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbdITWXm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 20 Sep 2017 18:23:42 -0400
Received: by mail-qt0-f180.google.com with SMTP id b1so4316874qtc.4
        for <linux-ide@vger.kernel.org>; Wed, 20 Sep 2017 15:23:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170920021120.ldddwe3pd3ynizjd@smitten>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Richter <rrichter@cavium.com>, Tycho Andersen <tycho@docker.com>
Cc: linux-ide@vger.kernel.org

Hello,

(cc'ing Robert and quoting entire message)

Robert, can you please take a look?  Is cavium ahci device expected to
get registered without irq?

Thanks.

On Tue, Sep 19, 2017 at 08:11:20PM -0600, Tycho Andersen wrote:
> Hi all,
> 
> I've been playing with a Cavium ThunderX arm64 board on a stock 4.13 kernel and
> I've hit the following warning:
> 
> [   13.784242] ------------[ cut here ]------------
> [   13.784247] WARNING: CPU: 48 PID: 556 at drivers/ata/libata-core.c:6554 ata_host_activate+0x148/0x160
> [   13.784248] Modules linked in: drm(+) ahci(+) libahci thunder_bgx(+) thunder_xcv mdio_thunder mdio_cavium
> [   13.784260] CPU: 48 PID: 556 Comm: kworker/48:1 Tainted: G        W       4.13.0+ #2
> [   13.784261] Hardware name: FOXCONN C2U1N/C2U1N_MB, BIOS G31FB12A 10/26/2016
> [   13.784265] Workqueue: events work_for_cpu_fn
> [   13.784268] task: ffff810f87ac4b00 task.stack: ffff810f8ec28000
> [   13.784270] PC is at ata_host_activate+0x148/0x160
> [   13.784272] LR is at ata_host_activate+0x70/0x160
> [   13.784274] pc : [<ffff00000875b378>] lr : [<ffff00000875b2a0>] pstate: 60400045
> [   13.784275] sp : ffff810f8ec2bbe0
> [   13.784276] x29: ffff810f8ec2bbe0 x28: ffff000000b26a48 
> [   13.784279] x27: ffff000000b271e8 x26: ffff800f952930a0 
> [   13.784283] x25: 0000000000000001 x24: 0000000000000080 
> [   13.784286] x23: ffff000000b271e8 x22: ffff000000b203d8 
> [   13.784289] x21: 0000000000000000 x20: ffff810f837d0f18 
> [   13.784292] x19: 0000000000000000 x18: ffffffffffffffff 
> [   13.784295] x17: ffff000000a897e8 x16: ffff000000a897e0 
> [   13.784298] x15: ffff0000092f8c08 x14: 0088000000000000 
> [   13.784301] x13: ffff000009481b79 x12: ffff00009317f000 
> [   13.784304] x11: 0000000000000001 x10: 0000000000000001 
> [   13.784307] x9 : 0000000000000000 x8 : ffff000053195500 
> [   13.784310] x7 : 0000000000000000 x6 : 000000000000007f 
> [   13.784313] x5 : 0000000000000080 x4 : ffff810f870c5600 
> [   13.784316] x3 : ffff810f870c5b00 x2 : ffff800f95293330 
> [   13.784319] x1 : 0000000000000040 x0 : 0000000000000000 
> [   13.784323] Call trace:
> [   13.784325] Exception stack(0xffff810f8ec2b9f0 to 0xffff810f8ec2bb20)
> [   13.784327] b9e0:                                   0000000000000000 0001000000000000
> [   13.784330] ba00: 0000000002359000 ffff00000875b378 0000000060400045 ffff0000086d4780
> [   13.784333] ba20: ffff810f8ec2ba50 ffff0000086d4808 ffff810f870c5780 0000000000000008
> [   13.784335] ba40: ffff810f8ec2bad0 ffff0000086c4b0c ffff800f952930a0 0000000000000004
> [   13.784338] ba60: ffff800f95293170 0000000000000040 ffff0000092f8c08 0000000000016500
> [   13.784341] ba80: 0000000000000100 ffff800f952930a0 ffff810f8ec2bad0 ffff000000a8591c
> [   13.784343] baa0: ffff810f837d4000 0000000000040d00 0000000000000000 0000000000000040
> [   13.784346] bac0: ffff800f95293330 ffff810f870c5b00 ffff810f870c5600 0000000000000080
> [   13.784349] bae0: 000000000000007f 0000000000000000 ffff000053195500 0000000000000000
> [   13.784351] bb00: 0000000000000001 0000000000000001 ffff00009317f000 ffff000009481b79
> [   13.784354] [<ffff00000875b378>] ata_host_activate+0x148/0x160
> [   13.784365] [<ffff000000a87680>] ahci_host_activate+0x148/0x1c8 [libahci]
> [   13.784376] [<ffff000000b211b4>] ahci_init_one+0x7d4/0xda0 [ahci]
> [   13.784379] [<ffff00000856029c>] local_pci_probe+0x44/0xb0
> [   13.784382] [<ffff0000080ef0c0>] work_for_cpu_fn+0x20/0x30
> [   13.784385] [<ffff0000080f2850>] process_one_work+0x1e8/0x430
> [   13.784387] [<ffff0000080f2ce4>] worker_thread+0x24c/0x440
> [   13.784389] [<ffff0000080f9a08>] kthread+0x108/0x138
> [   13.784392] [<ffff0000080838e0>] ret_from_fork+0x10/0x30
> [   13.784393] ---[ end trace 6b8dd2026acce7bc ]---
> 
> lspci for the controller is below. Is this the right place to report the bug?
> Any other information I can collect that would be useful?
> 
> Cheers,
> 
> Tycho
> 
> 0001:00:08.0 SATA controller: Cavium, Inc. THUNDERX AHCI SATA Controller (rev 09) (prog-if 01 [AHCI 1.0])
>         Subsystem: Cavium, Inc. CN88XX AHCI SATA Controller
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Region 0: [virtual] Memory at 814000000000 (32-bit, non-prefetchable) [size=2M]
>         Region 4: [virtual] Memory at 814000200000 (32-bit, non-prefetchable) [size=1M]
>         Capabilities: [40] Express (v2) Endpoint, MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
>                 LnkCap: Port #0, Speed unknown, Width x0, ASPM not supported, Exit Latency L0s <64ns, L1 <1us
>                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>         Capabilities: [80] MSI-X: Enable+ Count=4 Masked-
>                 Vector table: BAR=4 offset=00000000
>                 PBA: BAR=4 offset=000f0000
>         Capabilities: [98] #14 [0002]
>         Capabilities: [100 v1] Alternative Routing-ID Interpretation (ARI)
>                 ARICap: MFVC- ACS-, Next Function: 0
>                 ARICtl: MFVC- ACS-, Function Group: 0
>         Capabilities: [108 v1] Vendor Specific Information: ID=00a0 Rev=1 Len=040 <?>
>         Kernel driver in use: ahci
>         Kernel modules: ahci
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
tejun
