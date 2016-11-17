From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [RFT] powerpc: convert maple_defconfig to use libata PATA drivers
Date: Thu, 17 Nov 2016 23:04:09 +1100 (AEDT)
Message-ID: <3tKKY51wtHz9t2C@ozlabs.org>
References: <1454514630-29269-16-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454514630-29269-16-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-ide@vger.kernel.org

On Wed, 2016-03-02 at 15:50:22 UTC, Bartlomiej Zolnierkiewicz wrote:
> IDE subsystem has been deprecated since 2009 and the majority
> (if not all) of Linux distributions have switched to use
> libata for ATA support exclusively.  However there are still
> some users (mostly old or/and embedded non-x86 systems) that
> have not converted from using IDE subsystem to libata PATA
> drivers.  This doesn't seem to be good thing in the long-term
> for Linux as while there is less and less PATA systems left
> in use:
> 
> * testing efforts are divided between two subsystems
> 
> * having duplicate drivers for same hardware confuses users
> 
> This patch converts maple_defconfig to use libata PATA
> drivers.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c1f9d2938bd75c0245f640ad30d81e

cheers
