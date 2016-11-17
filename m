From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: disable IDE subsystem in pasemi_defconfig
Date: Thu, 17 Nov 2016 23:04:04 +1100 (AEDT)
Message-ID: <3tKKY06RKtz9t1d@ozlabs.org>
References: <1454514630-29269-17-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454514630-29269-17-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Cc: Olof Johansson <olof@lixom.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-ide@vger.kernel.org

On Wed, 2016-03-02 at 15:50:23 UTC, Bartlomiej Zolnierkiewicz wrote:
> This patch disables deprecated IDE subsystem in pasemi_defconfig
> (no IDE host drivers are selected in this config so there is no valid
> reason to enable IDE subsystem itself).
> 
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/23bf36cd120f97e85ce089c841197f

cheers
