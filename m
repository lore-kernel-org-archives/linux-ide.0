From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] libata: end the r-word
Date: Fri, 07 Mar 2014 14:22:48 -0800
Message-ID: <1394230968.4658.2.camel@dwillia2-mobl2.amr.corp.intel.com>
References: <20140306032706.9641.99151.stgit@viggo.jf.intel.com>
	 <20140307130654.GC30778@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56751 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752506AbaCGWXc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Mar 2014 17:23:32 -0500
In-Reply-To: <20140307130654.GC30778@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Fri, 2014-03-07 at 08:06 -0500, Tejun Heo wrote:
> Hello, Dan.
> 
> On Wed, Mar 05, 2014 at 07:33:04PM -0800, Dan Williams wrote:
> > We want our contributors to spend their anger, resentment, and
> > frustration emotional resources on finding and fixing broken code.  We
> > do not want those valuable resources wasted on unfortunately worded
> > comments.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> > Hi Tejun,
> > 
> > Today is "Spread the Word to End the Word" day, so I thought it would be
> > an interesting exercise to see how often the r-word is used in kernel
> > code comments.  Suprisingly, to me at least, it's rare.  In fact it
> > seems only libata uses it in code commentary.
> > 
> > Please consider applying this patch to call slow-to-reset devices
> > outliers.
> 
> I lack the cultural context to evaluate whether this is necessary.
> That said, there's no reason to cling onto it when an active
> contributor cares enough to submit a patch about it.  Can you please
> make the patch description a bit drier tho?
> 

Sure thing.  Thanks Tejun, I really appreciate it.

8<----------------
>From f1c564c4bcf1d636ff020faf4f3e644cf1c3d152 Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 5 Mar 2014 19:25:02 -0800
Subject: [PATCH] libata: end the r-word

Prompted by the social effort in the US to discourage usage of the
adjective "retarded".

In this case we needlessly anthropomorphize hard drives.  The
implication is that due to design deficiencies in the device reset
recovery time is negatively impacted.  We can simply clearly state that
fact.  "Exceptional devices cause outliers in reset recovery time." This
steers clear of any unintended comparison of such devices to humans with
cognitive disabilities.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/ata/libata-eh.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b4d0596f30a8..6760fc4e85b8 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -95,12 +95,13 @@ enum {
  * represents timeout for that try.  The first try can be soft or
  * hardreset.  All others are hardreset if available.  In most cases
  * the first reset w/ 10sec timeout should succeed.  Following entries
- * are mostly for error handling, hotplug and retarded devices.
+ * are mostly for error handling, hotplug and those outlier devices that
+ * take an exceptionally long time to recover from reset.
  */
 static const unsigned long ata_eh_reset_timeouts[] = {
 	10000,	/* most drives spin up by 10sec */
 	10000,	/* > 99% working drives spin up before 20sec */
-	35000,	/* give > 30 secs of idleness for retarded devices */
+	35000,	/* give > 30 secs of idleness for outlier devices */
 	 5000,	/* and sweet one last chance */
 	ULONG_MAX, /* > 1 min has elapsed, give up */
 };
-- 
1.7.7.6



