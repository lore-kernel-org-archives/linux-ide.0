From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] ahci: don't ignore result code of ahci_reset_controller()
Date: Mon, 2 Oct 2017 19:59:51 +0100
Message-ID: <CAKv+Gu9q3XYoM7yUtdFLy+dJE+ZWbdSPhiOTxbWERDJZNMFGXw@mail.gmail.com>
References: <20171002183124.17003-1-ard.biesheuvel@linaro.org> <20171002185450.GC3301751@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:54751 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdJBS7w (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Oct 2017 14:59:52 -0400
Received: by mail-io0-f178.google.com with SMTP id h66so5591543ioh.11
        for <linux-ide@vger.kernel.org>; Mon, 02 Oct 2017 11:59:52 -0700 (PDT)
In-Reply-To: <20171002185450.GC3301751@devbig577.frc2.facebook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE-ML <linux-ide@vger.kernel.org>, Graeme Gregory <graeme.gregory@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>

On 2 October 2017 at 19:54, Tejun Heo <tj@kernel.org> wrote:
> Hello, Ard.
>
> On Mon, Oct 02, 2017 at 07:31:24PM +0100, Ard Biesheuvel wrote:
>> ahci_pci_reset_controller() calls ahci_reset_controller(), which may
>> fail, but ignores the result code and always returns success. This
>> may result in failures like below
>>
>>   ahci 0000:02:00.0: version 3.0
>>   ahci 0000:02:00.0: enabling device (0000 -> 0003)
>>   ahci 0000:02:00.0: SSS flag set, parallel bus scan disabled
>>   ahci 0000:02:00.0: controller reset failed (0xffffffff)
>>   ahci 0000:02:00.0: failed to stop engine (-5)
>>     ... repeated many times ...
>>   ahci 0000:02:00.0: failed to stop engine (-5)
>>   Unable to handle kernel paging request at virtual address ffff0000093f9018
>>     ...
>>   PC is at ahci_stop_engine+0x5c/0xd8 [libahci]
>>   LR is at ahci_deinit_port.constprop.12+0x1c/0xc0 [libahci]
>>     ...
>>   [<ffff000000a17014>] ahci_stop_engine+0x5c/0xd8 [libahci]
>>   [<ffff000000a196b4>] ahci_deinit_port.constprop.12+0x1c/0xc0 [libahci]
>>   [<ffff000000a197d8>] ahci_init_controller+0x80/0x168 [libahci]
>>   [<ffff000000a260f8>] ahci_pci_init_controller+0x60/0x68 [ahci]
>>   [<ffff000000a26f94>] ahci_init_one+0x75c/0xd88 [ahci]
>>   [<ffff000008430324>] local_pci_probe+0x3c/0xb8
>>   [<ffff000008431728>] pci_device_probe+0x138/0x170
>>   [<ffff000008585e54>] driver_probe_device+0x2dc/0x458
>>   [<ffff0000085860e4>] __driver_attach+0x114/0x118
>>   [<ffff000008583ca8>] bus_for_each_dev+0x60/0xa0
>>   [<ffff000008585638>] driver_attach+0x20/0x28
>>   [<ffff0000085850b0>] bus_add_driver+0x1f0/0x2a8
>>   [<ffff000008586ae0>] driver_register+0x60/0xf8
>>   [<ffff00000842f9b4>] __pci_register_driver+0x3c/0x48
>>   [<ffff000000a3001c>] ahci_pci_driver_init+0x1c/0x1000 [ahci]
>>   [<ffff000008083918>] do_one_initcall+0x38/0x120
>>
>> where an obvious hardware level failure results in an unnecessary 15 second
>> delay and a subsequent crash.
>
> I'm not sure the retries are necessarily bad and am hesitant to change
> that part; however, we definitely wanna fix the crash.

It is not retrying anything. It is repeatedly trying to stop the
engine as part of the 'start engine' sequence, with which it proceeds
because the code in ahci_init_one() does not realize the reset has
failed.

> How does
> forwarding the error make the crash go away?  That sounds like we
> aren't clearing something we should have cleared while offlining the
> controller.
>

ahci_init_one() bails out if ahci_pci_reset_controller() returns a
failure. But as you can see, that code never does return a failure,
because it ignores the result code of ahci_reset_controller(). So the
'if (rc) return rc;' that follows in ahci_init_one() is essentially
dead code.
