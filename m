From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [ata_port_detach] WARNING: CPU: 0 PID: 1 at drivers/ata/libata-core.c:6613
 ata_port_detach+0x9b/0x180
Date: Tue, 21 Nov 2017 12:30:25 +0100
Message-ID: <CAK8P3a321sP3H0CK4zC1=506NGaLCGcNN199St45GFUVWZp-nw@mail.gmail.com>
References: <20171121090529.p3bcdz5y5bs5mqk2@wfg-t540p.sh.intel.com> <20171121105408.j6yaooeevof2zuvv@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44883 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbdKULa1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Nov 2017 06:30:27 -0500
In-Reply-To: <20171121105408.j6yaooeevof2zuvv@wfg-t540p.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Tejun Heo <tj@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>

On Tue, Nov 21, 2017 at 11:54 AM, Fengguang Wu <fengguang.wu@intel.com> wrote:
> Hello,
>
> FYI this happens in mainline kernel 4.14.0-12891-gc8a0739.
> It at least dates back to v4.11.
>
> It occurs in 4 out of 4 boots.

I see that this is the result of CONFIG_DEBUG_TEST_DRIVER_REMOVE=y,
which tries to remove the device immediately after probing.

The ATA_PFLAG_UNLOADED only gets set in ata_eh_unload(), it looks
like that never gets called when we unload while ATA_PFLAG_INITIALIZING
is still set during async probing.

      Arnd
