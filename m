From: Bartlomiej Zolnierkiewicz <bzolnier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Bug #13663] suspend to ram regression (IDE related)
Date: Wed, 1 Jul 2009 18:29:15 +0200
Message-ID: <200907011829.16850.bzolnier@gmail.com>
References: <etTXaRqGgAC.A.SaE.6iASKB@chimera> <1246459661.9660.40.camel@falcon> <200907011821.26091.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200907011821.26091.bzolnier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wuzhangjin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Jeff Chua <jeff.chua.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Etienne Basset <etienne.basset-Bf/eaXMDFuuXqB7oj33eUg@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, rjw-KKrjLPT3xs0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Wednesday 01 July 2009 18:21:25 Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 01 July 2009 16:47:41 Wu Zhangjin wrote:
> > On Wed, 2009-07-01 at 22:31 +0800, Jeff Chua wrote:
> > > On Tue, Jun 30, 2009 at 12:21 AM, Jeff Chua<jeff.chua.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > 
> > > > I just tried, and it "seems" to work. Will try a few more cycles.
> > > 
> > > STD/STR survived quite a few cycles now. Patch seems to be doing the
> > > right thing.
> > > 
> > > On Mon, Jun 29, 2009 at 11:51 PM, Etienne
> > > Basset<etienne.basset-Bf/eaXMDFuuXqB7oj33eUg@public.gmane.org> wrote:
> > > 
> > > > To have STR/resume work with current git, I have to :
> > > 
> > > > 1) apply Bart's patch
> > > 
> > > This is not yet in Linus's tree. And much needed to really fix the problem.
> > > 
> > > > 2) revert this commit : a1317f714af7aed60ddc182d0122477cbe36ee9b
> > > 
> > 
> > Yes, This commit must be reverted, otherwise, STD/Hibernation will not
> > work either. I have tested it on two different loongson-based machines:
> > fuloong2e box and yeeloong2f netbook.(loongson is mips compatiable)
> 
> Since it seems like Dave is taking his sweet time with doing the revert
> I stared at the code a bit more and I think that I finally found the bug
> (thanks to your debugging work for giving me the right hint!).
> 
> The patch needs to take into the account a new code introduced by the recent
> block layer changes (commit 8f6205cd572fece673da0255d74843680f67f879):
> 
> @@ -555,8 +560,11 @@ repeat:
>                 startstop = start_request(drive, rq);
>                 spin_lock_irq(&hwif->lock);
>  
> -               if (startstop == ide_stopped)
> +               if (startstop == ide_stopped) {
> +                       rq = hwif->rq;
> +                       hwif->rq = NULL;
>                         goto repeat;
> +               }
>         } else
>                 goto plug_device;
>  out:
> 
> and not zero hwif->rq if the device is blocked. 
> 
> Could you try the attached patch and see if it fixes the issue?

Here is the more complete version, also taking into the account changes
in ide_intr() and ide_timer_expiry():

---
 drivers/ide/ide-io.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -532,7 +532,8 @@ repeat:
 
 		if (startstop == ide_stopped) {
 			rq = hwif->rq;
-			hwif->rq = NULL;
+			if ((drive->dev_flags & IDE_DFLAG_BLOCKED) == 0)
+				hwif->rq = NULL;
 			goto repeat;
 		}
 	} else
@@ -679,8 +680,10 @@ void ide_timer_expiry (unsigned long dat
 		spin_lock_irq(&hwif->lock);
 		enable_irq(hwif->irq);
 		if (startstop == ide_stopped && hwif->polling == 0) {
-			rq_in_flight = hwif->rq;
-			hwif->rq = NULL;
+			if ((drive->dev_flags & IDE_DFLAG_BLOCKED) == 0) {
+				rq_in_flight = hwif->rq;
+				hwif->rq = NULL;
+			}
 			ide_unlock_port(hwif);
 			plug_device = 1;
 		}
@@ -856,8 +859,10 @@ irqreturn_t ide_intr (int irq, void *dev
 	 */
 	if (startstop == ide_stopped && hwif->polling == 0) {
 		BUG_ON(hwif->handler);
-		rq_in_flight = hwif->rq;
-		hwif->rq = NULL;
+		if ((drive->dev_flags & IDE_DFLAG_BLOCKED) == 0) {
+			rq_in_flight = hwif->rq;
+			hwif->rq = NULL;
+		}
 		ide_unlock_port(hwif);
 		plug_device = 1;
 	}
