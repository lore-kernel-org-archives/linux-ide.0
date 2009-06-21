From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Date: Mon, 22 Jun 2009 00:34:22 +0200
Message-ID: <200906220034.22430.bzolnier@gmail.com>
References: <200906202352.33894.elendil@planet.nl> <200906211515.56804.bzolnier@gmail.com> <20090621.141950.160759111.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <20090621.141950.160759111.davem@davemloft.net>
Content-Disposition: inline
Sender: sparclinux-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: elendil@planet.nl, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sunday 21 June 2009 23:19:50 David Miller wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Sun, 21 Jun 2009 15:15:56 +0200
> 
> > On Sunday 21 June 2009 02:19:45 David Miller wrote:
> >> I wonder how much testing this commit received...
> > 
> > Too less, any help with improving testing coverage is welcomed
> > (this was just a tiny part of very large rework which has been tested
> > and has been sitting in linux-next for weeks before push to Linus).
> 
> Maybe you should leave the driver alone until you can get affirmative
> testing results from people who have the hardware?!?!? :-/
> 
> And in leiu of that, simply leave it alone until such testing can
> actually be performed.

Can't wait forever...

> That's why all the IDE drivers are constantly breaking on sparc.

URLs to bug-reports please.. or it didn't happened..

> The IDE layer is more than legacy at this point, so if you aren't
> fixing bugs (those reported by users and the fix for which can
> be absolutely tested), just leave it be.

Interesting, we have been steadily adding new hardware support
(there is another driver for embedded hardware pending inclusion)..

If you wanted to run IDE-stale tree I would have been more than happy
to help you with it by cc:ing you on bugfix patches.

> So this totally eliminates any argument you may have about necessary
> "infrastructure" changes that might be blocked by not being able to
> make these kinds modifications to drivers for devices you can't even
> test.

I'm really tired of this kind of hostility towards IDE changes and I also
don't have time for such unproductive discussions.  Lets get over this
quickly, since you seem to have such a great insight into running IDE layer
here is a little proposition..

ACK?  [ If not than can we please get back with the program? ]

---
 MAINTAINERS |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: b/MAINTAINERS
===================================================================
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2783,10 +2783,9 @@ S:	Supported
 F:	drivers/scsi/ips.*
 
 IDE SUBSYSTEM
-P:	Bartlomiej Zolnierkiewicz
-M:	bzolnier@gmail.com
+P:	David S. Miller
+M:	davem@davemloft.net
 L:	linux-ide@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bart/ide-2.6.git
 S:	Maintained
 F:	Documentation/ide/
 F:	drivers/ide/
