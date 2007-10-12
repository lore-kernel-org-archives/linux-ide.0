From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [git patches] IDE updates (part 1)
Date: Fri, 12 Oct 2007 15:25:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64N.0710121518030.21684@blysk.ds.pg.gda.pl>
References: <200710120034.49730.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757579AbXJLO0Y@vger.kernel.org>
In-Reply-To: <200710120034.49730.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, 12 Oct 2007, Bartlomiej Zolnierkiewicz wrote:

> * Kconfig facelift - as a result of this change users have three less
>   config options to worry about (BLK_DEV_IDEPCI, BLK_DEV_IDEDMA_PCI
>   and IDE_CHIPSETS) and can just select host drivers that they need

 Well, it depends on how you look at it.  If you have PCI, an on-board IDE 
interface and do not want any PCI IDE controllers, then you now have a 
zillion of options to disable instead of just one.  Have a look at 
"arch/mips/configs/sb1250-swarm_defconfig" for an example (hmm..., 
CONFIG_BLK_DEV_IDE_SWARM disabled by default -- that should probably be 
changed; I'll cook a patch).  I guess it is not possible to make everyone 
happy at once though, so please do not treat it as a hard objection. :-)

  Maciej
