From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ahci: imx: manage only sata_ref_clk in imx_sata_enable[disable]
Date: Wed, 28 May 2014 12:59:43 -0300
Message-ID: <CAOMZO5BkdkU-_s8G5CqVMzfkMgxdUg8bx0JJnqC8dPyFMK=Ocw@mail.gmail.com>
References: <1401289539-3485-1-git-send-email-shawn.guo@freescale.com>
	<5386026C.1010603@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:39342 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058AbaE1P7o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 May 2014 11:59:44 -0400
Received: by mail-ve0-f174.google.com with SMTP id jw12so12800324veb.33
        for <linux-ide@vger.kernel.org>; Wed, 28 May 2014 08:59:43 -0700 (PDT)
In-Reply-To: <5386026C.1010603@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Shawn Guo <shawn.guo@freescale.com>, Tejun Heo <tj@kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>, linux-ide@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hans,

On Wed, May 28, 2014 at 12:36 PM, Hans de Goede <hdegoede@redhat.com> wrote:

> The proper fix is obvious, if we've shutdown everything due to there
> not being a device present at the initial probe, don't call
> ahci_platform_resume_host on resume, as is done in the attached patch.

I tested your attached patch. It does not build as it lacks to add the
definition of imxpriv inside the suspend/resume functions. After
fixing it I get:

root@freescale /$ echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.002 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
PM: suspend of devices complete after 91.109 msecs
PM: suspend devices took 0.100 seconds
PM: late suspend of devices complete after 9.086 msecs
PM: noirq suspend of devices complete after 8.780 msecs
Disabling non-boot CPUs ...
CPU1: shutdown
CPU2: shutdown
CPU3: shutdown
Enabling non-boot CPUs ...
CPU1: Booted secondary processor
CPU1 is up
CPU2: Booted secondary processor
CPU2 is up
CPU3: Booted secondary processor
CPU3 is up
PM: noirq resume of devices complete after 6.914 msecs
PM: early resume of devices complete after 5.160 msecs
PM: resume of devices complete after 167.025 msecs
PM: resume devices took 0.180 seconds
Restarting tasks ... done.
ata1: failed to resume link (SControl 2003)
random: nonblocking pool is initialized
root@freescale /$ ata1: softreset failed (1st FIS failed)
ata1: failed to resume link (SControl 2003)
ata1: softreset failed (1st FIS failed)
ata1: failed to resume link (SControl 2003)
ata1: softreset failed (1st FIS failed)
ata1: limiting SATA link speed to 1.5 Gbps
ata1: failed to resume link (SControl 2003)
ata1: softreset failed (1st FIS failed)
ata1: reset failed, giving up

With Shawn's version I  do not get the suspend error messages:
...
CPU1: Booted secondary processor
CPU1 is up
CPU2: Booted secondary processor
CPU2 is up
CPU3: Booted secondary processor
CPU3 is up
PM: noirq resume of devices complete after 5.836 msecs
PM: early resume of devices complete after 5.334 msecs
PM: resume of devices complete after 176.763 msecs
PM: resume devices took 0.190 seconds
Restarting tasks ... done.
ata1: SATA link down (SStatus 0 SControl 300)
random: nonblocking pool is initialized
