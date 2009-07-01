From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [Bug #13663] suspend to ram regression (IDE related)
Date: Wed, 1 Jul 2009 18:21:25 +0200
Message-ID: <200907011821.26091.bzolnier@gmail.com>
References: <etTXaRqGgAC.A.SaE.6iASKB@chimera> <b6a2187b0907010731k510150b5u1c7fce8cbed7c33b@mail.gmail.com> <1246459661.9660.40.camel@falcon>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:58003 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbZGAQPm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Jul 2009 12:15:42 -0400
In-Reply-To: <1246459661.9660.40.camel@falcon>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: wuzhangjin@gmail.com
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Etienne Basset <etienne.basset@numericable.fr>, David Miller <davem@davemloft.net>, rjw@sisk.pl, linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, linux-ide@vger.kernel.org

On Wednesday 01 July 2009 16:47:41 Wu Zhangjin wrote:
> On Wed, 2009-07-01 at 22:31 +0800, Jeff Chua wrote:
> > On Tue, Jun 30, 2009 at 12:21 AM, Jeff Chua<jeff.chua.linux@gmail.com> wrote:
> > 
> > > I just tried, and it "seems" to work. Will try a few more cycles.
> > 
> > STD/STR survived quite a few cycles now. Patch seems to be doing the
> > right thing.
> > 
> > On Mon, Jun 29, 2009 at 11:51 PM, Etienne
> > Basset<etienne.basset@numericable.fr> wrote:
> > 
> > > To have STR/resume work with current git, I have to :
> > 
> > > 1) apply Bart's patch
> > 
> > This is not yet in Linus's tree. And much needed to really fix the problem.
> > 
> > > 2) revert this commit : a1317f714af7aed60ddc182d0122477cbe36ee9b
> > 
> 
> Yes, This commit must be reverted, otherwise, STD/Hibernation will not
> work either. I have tested it on two different loongson-based machines:
> fuloong2e box and yeeloong2f netbook.(loongson is mips compatiable)

Since it seems like Dave is taking his sweet time with doing the revert
I stared at the code a bit more and I think that I finally found the bug
(thanks to your debugging work for giving me the right hint!).

The patch needs to take into the account a new code introduced by the recent
block layer changes (commit 8f6205cd572fece673da0255d74843680f67f879):

@@ -555,8 +560,11 @@ repeat:
                startstop = start_request(drive, rq);
                spin_lock_irq(&hwif->lock);
 
-               if (startstop == ide_stopped)
+               if (startstop == ide_stopped) {
+                       rq = hwif->rq;
+                       hwif->rq = NULL;
                        goto repeat;
+               }
        } else
                goto plug_device;
 out:

and not zero hwif->rq if the device is blocked. 

Could you try the attached patch and see if it fixes the issue?

[ Dave: while I appreciate fast handling of my patches I had strongly
  suggested giving this particular one some extra testing (because there
  were a lot of changes in between the time that it has been tested
  against other kernel subsystems).  Yet, it seems that its linux-next
  exposure was minimal at best..  :( ]

---
 drivers/ide/ide-io.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
