From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: don't ignore result code of ahci_reset_controller()
Date: Mon, 2 Oct 2017 11:54:50 -0700
Message-ID: <20171002185450.GC3301751@devbig577.frc2.facebook.com>
References: <20171002183124.17003-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:53999 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdJBSyy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Oct 2017 14:54:54 -0400
Received: by mail-it0-f54.google.com with SMTP id 85so8521504ith.2
        for <linux-ide@vger.kernel.org>; Mon, 02 Oct 2017 11:54:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20171002183124.17003-1-ard.biesheuvel@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-ide@vger.kernel.org, graeme.gregory@linaro.org, leif.lindholm@linaro.org, daniel.thompson@Linaro.org

Hello, Ard.

On Mon, Oct 02, 2017 at 07:31:24PM +0100, Ard Biesheuvel wrote:
> ahci_pci_reset_controller() calls ahci_reset_controller(), which may
> fail, but ignores the result code and always returns success. This
> may result in failures like below
> 
>   ahci 0000:02:00.0: version 3.0
>   ahci 0000:02:00.0: enabling device (0000 -> 0003)
>   ahci 0000:02:00.0: SSS flag set, parallel bus scan disabled
>   ahci 0000:02:00.0: controller reset failed (0xffffffff)
>   ahci 0000:02:00.0: failed to stop engine (-5)
>     ... repeated many times ...
>   ahci 0000:02:00.0: failed to stop engine (-5)
>   Unable to handle kernel paging request at virtual address ffff0000093f9018
>     ...
>   PC is at ahci_stop_engine+0x5c/0xd8 [libahci]
>   LR is at ahci_deinit_port.constprop.12+0x1c/0xc0 [libahci]
>     ...
>   [<ffff000000a17014>] ahci_stop_engine+0x5c/0xd8 [libahci]
>   [<ffff000000a196b4>] ahci_deinit_port.constprop.12+0x1c/0xc0 [libahci]
>   [<ffff000000a197d8>] ahci_init_controller+0x80/0x168 [libahci]
>   [<ffff000000a260f8>] ahci_pci_init_controller+0x60/0x68 [ahci]
>   [<ffff000000a26f94>] ahci_init_one+0x75c/0xd88 [ahci]
>   [<ffff000008430324>] local_pci_probe+0x3c/0xb8
>   [<ffff000008431728>] pci_device_probe+0x138/0x170
>   [<ffff000008585e54>] driver_probe_device+0x2dc/0x458
>   [<ffff0000085860e4>] __driver_attach+0x114/0x118
>   [<ffff000008583ca8>] bus_for_each_dev+0x60/0xa0
>   [<ffff000008585638>] driver_attach+0x20/0x28
>   [<ffff0000085850b0>] bus_add_driver+0x1f0/0x2a8
>   [<ffff000008586ae0>] driver_register+0x60/0xf8
>   [<ffff00000842f9b4>] __pci_register_driver+0x3c/0x48
>   [<ffff000000a3001c>] ahci_pci_driver_init+0x1c/0x1000 [ahci]
>   [<ffff000008083918>] do_one_initcall+0x38/0x120
> 
> where an obvious hardware level failure results in an unnecessary 15 second
> delay and a subsequent crash.

I'm not sure the retries are necessarily bad and am hesitant to change
that part; however, we definitely wanna fix the crash.  How does
forwarding the error make the crash go away?  That sounds like we
aren't clearing something we should have cleared while offlining the
controller.

Thanks.

-- 
tejun
