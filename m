From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/2] tx4938ide: Check minimum cycle time and SHWT range
Date: Mon, 27 Oct 2008 23:52:24 +0900 (JST)
Message-ID: <20081027.235224.82088530.anemo@mba.ocn.ne.jp>
References: <20081027.223913.128619425.anemo@mba.ocn.ne.jp>
	<4905CB09.5020805@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:54539 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713AbYJ0Ow0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 10:52:26 -0400
In-Reply-To: <4905CB09.5020805@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

On Mon, 27 Oct 2008 17:07:05 +0300, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > +	/* -DIOx recovery time (SHWT * 4) and cycle time requirement */
> > +	while (shwt * cycle * 4 + t->act8b < t->cycle)
> 
>     This can lead to adding an extra setup cycle due to use of "non-quantized" 
> active time, here's more precise expression for the cycle time:
> 
>     (shwt * 4 + wt + (wt ? 2 : 3)) * cycle
> 
> or even this, more obsure:
> 
>     (shwt * 4 + wt + !wt + 2) * cycle

Hm, indeed.  I prefer former one.  Revised.  Thanks!


From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCH] tx4938ide: Check minimum cycle time and SHWT range (v2)

SHWT value is used as address valid to -CSx assertion and -CSx to -DIOx
assertion setup time, and contrarywise, -DIOx to -CSx release and -CSx
release to address invalid hold time, so it actualy applies 4 times and
so constitutes -DIOx recovery time.  Check requirement of the recovery
time and cycle time.  Also check SHWT maximum value.

Suggested-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 drivers/ide/tx4938ide.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/tx4938ide.c b/drivers/ide/tx4938ide.c
index a0d10a9..796289c 100644
--- a/drivers/ide/tx4938ide.c
+++ b/drivers/ide/tx4938ide.c
@@ -39,10 +39,17 @@ static void tx4938ide_tune_ebusc(unsigned int ebus_ch,
 	/* Address-valid to DIOR/DIOW setup */
 	shwt = DIV_ROUND_UP(t->setup, cycle);
 
+	/* -DIOx recovery time (SHWT * 4) and cycle time requirement */
+	while ((shwt * 4 + wt + (wt ? 2 : 3)) * cycle < t->cycle)
+		shwt++;
+	if (shwt > 7) {
+		pr_warning("tx4938ide: SHWT violation (%d)\n", shwt);
+		shwt = 7;
+	}
 	pr_debug("tx4938ide: ebus %d, bus cycle %dns, WT %d, SHWT %d\n",
 		 ebus_ch, cycle, wt, shwt);
 
-	__raw_writeq((cr & ~(0x3f007ull)) | (wt << 12) | shwt,
+	__raw_writeq((cr & ~0x3f007ull) | (wt << 12) | shwt,
 		     &tx4938_ebuscptr->cr[ebus_ch]);
 }
 
-- 
1.5.6.3


