From: Tejun Heo <tj@kernel.org>
Subject: Re: [ata_port_probe] BUG: unable to handle kernel NULL pointer
 dereference at 0000000000000350
Date: Tue, 21 Nov 2017 06:57:36 -0800
Message-ID: <20171121145719.GD983427@devbig577.frc2.facebook.com>
References: <20171121090529.p3bcdz5y5bs5mqk2@wfg-t540p.sh.intel.com>
 <20171121120935.t3ouyqq7byc5zd43@wfg-t540p.sh.intel.com>
 <20171121121915.k3jcazsc6eugdo3k@wfg-t540p.sh.intel.com>
 <CAK8P3a1c+u-r6+AD8=eKfRaoTgx0ByV_mVJWoJu7BzfDLk1JBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:43064 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbdKUO5p (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Nov 2017 09:57:45 -0500
Content-Disposition: inline
In-Reply-To: <CAK8P3a1c+u-r6+AD8=eKfRaoTgx0ByV_mVJWoJu7BzfDLk1JBA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Fengguang Wu <fengguang.wu@intel.com>, IDE-ML <linux-ide@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hello,

On Tue, Nov 21, 2017 at 01:54:25PM +0100, Arnd Bergmann wrote:
> > [   56.376960] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
> > [   56.379169] ata2.00: configured for MWDMA2
> > [   56.381518] ata2.00: disabled
> > [   56.385696] sd 1:0:0:0: [sda] Attached SCSI disk
> > [   56.395326] sd 1:0:0:0: [sda] Synchronizing SCSI cache
> 
> I guess both can be explained by the same race as the previous one, with
> async probe racing against removal. The first one might be a use-after-free
> problem, the second one could be the probing thread running after the
> device got removed.

This is not a bug in libata.  This is caused by
CONFIG_DEBUG_TEST_DRIVER_REMOVE incorrectly detaching the driver
before probing is complete, which can't happen in normal operations
(we have async flush at the end of boot and around module operations).

Greg, this issue was identified way back.  It's a debug code which
causes failures which aren't possible.  Can we please either fix or
remove it?

Thanks.

-- 
tejun
