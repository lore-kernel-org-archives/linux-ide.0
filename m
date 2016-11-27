From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] ata: disable port while unloading ATA controller driver
Date: Mon, 28 Nov 2016 01:30:35 +0200
Message-ID: <7e0d4279-c1a2-8a09-0b81-38f3a92554f6@mleia.com>
References: <20161127231856.11466-1-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:50918 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752329AbcK0Xaj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 27 Nov 2016 18:30:39 -0500
In-Reply-To: <20161127231856.11466-1-vz@mleia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org

On 11/28/2016 01:18 AM, Vladimir Zapolskiy wrote:
> While removing ATA controller driver ata_port_detach() sets
> ATA_PFLAG_UNLOADING flag and charges the error handler, however actual
> port disabling does not happen due to unset ATA_PFLAG_EH_PENDING flag.
>
> To take care about clean port removal and ATA_PFLAG_EH_PENDING flag
> setting it is sufficient to replace ata_port_schedule_eh() call with
> ata_port_freeze().
>
> The problem is reported by an assertion in ata_port_detach(),
> if a controller driver is unloaded manually or on boot with
> DEBUG_TEST_DRIVER_REMOVE option enabled:
>
>   # rmmod ahci_imx
>   WARNING: CPU: 2 PID: 379 at drivers/ata/libata-core.c:6484 ata_port_detach+0x11c/0x12c
>   Modules linked in: ahci_imx(-) i2c_imx
>   CPU: 2 PID: 379 Comm: rmmod Not tainted 4.9.0-rc6+ #66
>   Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
>   Backtrace:
>   [<>] (dump_backtrace) from [<>] (show_stack+0x18/0x1c)
>   [<>] (show_stack) from [<>] (dump_stack+0xb4/0xe8)
>   [<>] (dump_stack) from [<>] (__warn+0xd8/0x104)
>   [<>] (__warn) from [<>] (warn_slowpath_null+0x28/0x30)
>   [<>] (warn_slowpath_null) from [<>] (ata_port_detach+0x11c/0x12c)
>   [<>] (ata_port_detach) from [<>] (ata_platform_remove_one+0x2c/0x44)
>   [<>] (ata_platform_remove_one) from [<>] (platform_drv_remove+0x2c/0x44)
>   [<>] (platform_drv_remove) from [<>] (__device_release_driver+0x90/0x12c)
>   [<>] (__device_release_driver) from [<>] (driver_detach+0xc0/0xc4)
>   [<>] (driver_detach) from [<>] (bus_remove_driver+0x64/0xdc)
>   [<>] (bus_remove_driver) from [<>] (driver_unregister+0x30/0x50)
>   [<>] (driver_unregister) from [<>] (platform_driver_unregister+0x14/0x18)
>   [<>] (platform_driver_unregister) from [<>] (imx_ahci_driver_exit+0x14/0x1c [ahci_imx])
>   [<>] (imx_ahci_driver_exit [ahci_imx]) from [<>] (SyS_delete_module+0x140/0x1f4)
>   [<>] (SyS_delete_module) from [<>] (ret_fast_syscall+0x0/0x1c)
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---

Tejun, Bartlomiej,

you may consider this change as RFC, because I'm not an expert in ATA
subsystem, for example I hesitate to claim that ata_port_freeze() is
actually needed here, in my test case (iMX6Q SabreAuto without
a connected SATA drive) a weaker ata_port_abort() also works well.

I suppose that the change is in the kernel sources for a long time,
so you may consider to send the fix to the maintainers of stable
branches, feel free to ask me to find a commit for Fixes tag.

--
With best wishes,
Vladimir
