From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 09/13] libata: fix handling of race between timeout and completion
Date: Thu, 2 Feb 2006 00:36:58 +0900
Message-ID: <20060201153658.GA4311@htj.dyndns.org>
References: <11379893774038-git-send-email-htejun@gmail.com> <43D999CF.7020707@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.194]:38046 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161030AbWBAPhG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Feb 2006 10:37:06 -0500
Received: by wproxy.gmail.com with SMTP id i23so175026wra
        for <linux-ide@vger.kernel.org>; Wed, 01 Feb 2006 07:37:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <43D999CF.7020707@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Jeff.

On Thu, Jan 26, 2006 at 10:55:59PM -0500, Jeff Garzik wrote:
> Tejun Heo wrote:
> >If a qc completes after SCSI timer expires but before libata EH kicks
> >in, the qc gets completed but the scsicmd still gets passed to libata
> >EH resulting in ->eng_timeout invocation with NULL qc.  Currently none
> >of ->eng_timeout callbacks handles this properly.  This patch makes
> >ata_scsi_error() bypass ->eng_timeout and handle this rare case.
> >
> >Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> Doesn't look right to me.  If the qc gets completed, then the SCSI 
> command should have also been completed.
> 
> AFAICS the race is this:  if the qc is completed, then there is no 
> active tag, so ata_qc_from_tag() correctly returns NULL.  This case is 
> really an "error has already been handled" case.  It looks really wrong 
> to even touch a scsicmd.  I would just clear the eh_cmd list and be done 
> with it.
> 

SCSI EH never invokes ->eh_strategy_handler without any failed
scsicmd.  The only case where qc <-> scmd mismatch occurs is the
following case.

1. SCSI issues command (timer activated)
2. libata interprets and issues
3. time passes
4. SCSI timeout occurs, scmd queued for EH
5. irq occurs, completes qc.  ata_qc_complete() calls qc->complete_fn
   which ends up calling scsi_done().  scsi_done() sees that SCSI
   timer has already expired, so it returns without doing anything
   expecting EH to clean up.
6. SCSI EH kicks in, libata ->eh_strategy_handler (ata_scsi_error)
   invoked.
7. in libata EH, we have no active qc but scmds to recover.

This can be reproduced by delaying completion of a qc by 31 secs and
EH of the command by 5 secs.

@30: timeout kicks in and invoked EH sleeps for 5secs
@31: delayed qc completion
@35: EH continues

With the current upstream branch, the following is the result of such
race.

  ata1: inducing race condition
  ata1: delaying completion of f774c818 by 31 secs
  ata1: EH invoked for delayed qc f774c818, sleeping 5secs
  ata1: delayed completion of f774c818
  ata1: woke up, proceeding with EH
  ata1: handling error/timeout
  ata1: BUG: timeout without command
  Assertion failed! host->host_failed == 0 && list_empty(&host->eh_cmd_q),drivers/
  scsi/libata-scsi.c,ata_scsi_error,line=751
  ata1: handling error/timeout
  ata1: BUG: timeout without command
  Assertion failed! host->host_failed == 0 && list_empty(&host->eh_cmd_q),drivers/
  scsi/libata-scsi.c,ata_scsi_error,line=751
  ata1: handling error/timeout
  ata1: BUG: timeout without command
  Assertion failed! host->host_failed == 0 && list_empty(&host->eh_cmd_q),drivers/
  scsi/libata-scsi.c,ata_scsi_error,line=751
  ata1: handling error/timeout
  ata1: BUG: timeout without command
  Assertion failed! host->host_failed == 0 && list_empty(&host->eh_cmd_q),drivers/
  scsi/libata-scsi.c,ata_scsi_error,line=751
  ... repeat ...

What happens is, eh_cmd_q and host_failed aren't cleared properly and
scsi_error_handler() ends up looping forever.

If host->eh_cmd_q and host->host_failed are cleared as you suggested,
the following happens.

ata1: inducing race condition
ata1: delaying completion of f774c818 by 31 secs
ata1: EH invoked for delayed qc f774c818, sleeping 5secs
ata1: delayed completion of f774c818
ata1: woke up, proceeding with EH
<< the drive is locked up >>

As eh_cmd_q and host_failed are cleared, scsi_error_handler() goes to
sleep but the failed scmd is not actually finished.  From SCSI's POV,
it's still out there (host_busy and device_busy haven't been decreased
yet).  As our queue depth is 1, no other command will ever get issued
again.

With the patch I submitted, the result looks like...

ata1: inducing race condition
ata1: delaying completion of f774b818 by 31 secs
ata1: EH invoked for delayed qc f774b818, sleeping 5secs
ata1: delayed completion of f774b818
ata1: woke up, proceeding with EH
ata1: interrupt and timer raced for scsicmd f774943c
ata1: inducing race condition
ata1: delaying completion of f774b818 by 31 secs
ata1: EH invoked for delayed qc f774b818, sleeping 5secs
ata1: delayed completion of f774b818
ata1: woke up, proceeding with EH
ata1: interrupt and timer raced for scsicmd f774919c
ata1: inducing race condition
ata1: delaying completion of f774b818 by 31 secs
ata1: EH invoked for delayed qc f774b818, sleeping 5secs
ata1: delayed completion of f774b818
ata1: woke up, proceeding with EH
ata1: interrupt and timer raced for scsicmd f774943c

It recovers and IO continues.

The problem is that there are race conditions which make scmd's
lifetime and qc's lifetime different.  qc ends up dying earlier than
its scmd and in the process we also lose completion status.  The only
thing that can/must be done is retrying or failing the scmd.

Note that altough this race condition should be very rare but with NCQ
the likelihood increases as EH waits until all commands are settled
after a qc times out.  This widens the window for such race condition
considerably.

I'm attaching four patches used for the above test cases.

* race-patch		: race inducing patch on top of upstream
* jeff-patch		: clear eh_cmd_q and host_failed only on race
* jeff-race-patch	: race inducing patch on top of jeff-patch
* tj-race-patch		: race inducing patch on top of this fix

-- 
tejun

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=race-patch

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 249e67f..d3bc7c1 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3919,6 +3919,13 @@ void ata_qc_free(struct ata_queued_cmd *
 	}
 }
 
+static void delayed_qc_complete(unsigned long arg)
+{
+	struct ata_queued_cmd *qc = (void *)arg;
+	printk(KERN_ERR "ata%u: delayed completion of %p\n", qc->ap->id, qc);
+	ata_qc_complete(qc);
+}
+
 /**
  *	ata_qc_complete - Complete an active ATA command
  *	@qc: Command to complete
@@ -3936,6 +3943,17 @@ void ata_qc_complete(struct ata_queued_c
 	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
 	assert(qc->flags & ATA_QCFLAG_ACTIVE);
 
+	if (qc->flags & (1 << 31) && !(qc->flags & (1 << 30))) {
+		static struct timer_list timer;
+		printk(KERN_ERR "ata%u: delaying completion of %p by 31 secs\n",
+		       qc->ap->id, qc);
+		qc->flags |= 1 << 30;
+		setup_timer(&timer, delayed_qc_complete, (unsigned long)qc);
+		timer.expires = jiffies + 31 * HZ;
+		add_timer(&timer);
+		return;
+	}
+
 	if (likely(qc->flags & ATA_QCFLAG_DMAMAP))
 		ata_sg_clean(qc);
 
@@ -4010,6 +4028,15 @@ unsigned int ata_qc_issue(struct ata_que
 	qc->ap->active_tag = qc->tag;
 	qc->flags |= ATA_QCFLAG_ACTIVE;
 
+	{
+		static int cnt = 0;
+		if (++cnt % 1000 == 0) {
+			printk(KERN_ERR "ata%u: inducing race condition\n",
+			       ap->id);
+			qc->flags |= (1 << 31);
+		}
+	}
+
 	return ap->ops->qc_issue(qc);
 
 sg_err:
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 6df8293..53a7c84 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -732,10 +732,20 @@ int ata_scsi_slave_config(struct scsi_de
 int ata_scsi_error(struct Scsi_Host *host)
 {
 	struct ata_port *ap;
+	struct ata_queued_cmd *qc;
 
 	DPRINTK("ENTER\n");
 
 	ap = (struct ata_port *) &host->hostdata[0];
+
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	if (qc && (qc->flags & (1 << 31))) {
+		printk(KERN_ERR "ata%u: EH invoked for delayed qc %p, sleeping 5secs\n",
+		       ap->id, qc);
+		msleep(5000);
+		printk(KERN_ERR "ata%u: woke up, proceeding with EH\n", ap->id);
+	}
+
 	ap->ops->eng_timeout(ap);
 
 	assert(host->host_failed == 0 && list_empty(&host->eh_cmd_q));

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=jeff-patch

diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 6df8293..17920d1 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -732,11 +732,19 @@ int ata_scsi_slave_config(struct scsi_de
 int ata_scsi_error(struct Scsi_Host *host)
 {
 	struct ata_port *ap;
+	struct ata_queued_cmd *qc;
 
 	DPRINTK("ENTER\n");
 
 	ap = (struct ata_port *) &host->hostdata[0];
-	ap->ops->eng_timeout(ap);
+
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	if (qc)
+		ap->ops->eng_timeout(ap);
+	else {
+		host->host_failed = 0;
+		INIT_LIST_HEAD(&host->eh_cmd_q);
+	}
 
 	assert(host->host_failed == 0 && list_empty(&host->eh_cmd_q));
 

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=jeff-race-patch

diff -u b/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- b/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -739,6 +739,14 @@
 	ap = (struct ata_port *) &host->hostdata[0];
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
+	if (qc && (qc->flags & (1 << 31))) {
+		printk(KERN_ERR "ata%u: EH invoked for delayed qc %p, sleeping 5secs\n",
+		       ap->id, qc);
+		msleep(5000);
+		printk(KERN_ERR "ata%u: woke up, proceeding with EH\n", ap->id);
+	}
+
+	qc = ata_qc_from_tag(ap, ap->active_tag);
 	if (qc)
 		ap->ops->eng_timeout(ap);
 	else {
only in patch2:
unchanged:
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3919,6 +3919,13 @@ void ata_qc_free(struct ata_queued_cmd *
 	}
 }
 
+static void delayed_qc_complete(unsigned long arg)
+{
+	struct ata_queued_cmd *qc = (void *)arg;
+	printk(KERN_ERR "ata%u: delayed completion of %p\n", qc->ap->id, qc);
+	ata_qc_complete(qc);
+}
+
 /**
  *	ata_qc_complete - Complete an active ATA command
  *	@qc: Command to complete
@@ -3936,6 +3943,17 @@ void ata_qc_complete(struct ata_queued_c
 	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
 	assert(qc->flags & ATA_QCFLAG_ACTIVE);
 
+	if (qc->flags & (1 << 31) && !(qc->flags & (1 << 30))) {
+		static struct timer_list timer;
+		printk(KERN_ERR "ata%u: delaying completion of %p by 31 secs\n",
+		       qc->ap->id, qc);
+		qc->flags |= 1 << 30;
+		setup_timer(&timer, delayed_qc_complete, (unsigned long)qc);
+		timer.expires = jiffies + 31 * HZ;
+		add_timer(&timer);
+		return;
+	}
+
 	if (likely(qc->flags & ATA_QCFLAG_DMAMAP))
 		ata_sg_clean(qc);
 
@@ -4010,6 +4028,15 @@ unsigned int ata_qc_issue(struct ata_que
 	qc->ap->active_tag = qc->tag;
 	qc->flags |= ATA_QCFLAG_ACTIVE;
 
+	{
+		static int cnt = 0;
+		if (++cnt % 1000 == 0) {
+			printk(KERN_ERR "ata%u: inducing race condition\n",
+			       ap->id);
+			qc->flags |= (1 << 31);
+		}
+	}
+
 	return ap->ops->qc_issue(qc);
 
 sg_err:

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=tj-race-patch

Index: work1/drivers/scsi/libata-core.c
===================================================================
--- work1.orig/drivers/scsi/libata-core.c	2006-02-01 23:29:00.000000000 +0900
+++ work1/drivers/scsi/libata-core.c	2006-02-01 23:29:20.000000000 +0900
@@ -3959,6 +3959,13 @@ void ata_qc_free(struct ata_queued_cmd *
 	}
 }
 
+static void delayed_qc_complete(unsigned long arg)
+{
+	struct ata_queued_cmd *qc = (void *)arg;
+	printk(KERN_ERR "ata%u: delayed completion of %p\n", qc->ap->id, qc);
+	ata_qc_complete(qc);
+}
+
 /**
  *	ata_qc_complete - Complete an active ATA command
  *	@qc: Command to complete
@@ -3976,6 +3983,17 @@ void ata_qc_complete(struct ata_queued_c
 	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
 	assert(qc->flags & ATA_QCFLAG_ACTIVE);
 
+	if (qc->flags & (1 << 31) && !(qc->flags & (1 << 30))) {
+		static struct timer_list timer;
+		printk(KERN_ERR "ata%u: delaying completion of %p by 31 secs\n",
+		       qc->ap->id, qc);
+		qc->flags |= 1 << 30;
+		setup_timer(&timer, delayed_qc_complete, (unsigned long)qc);
+		timer.expires = jiffies + 31 * HZ;
+		add_timer(&timer);
+		return;
+	}
+
 	if (likely(qc->flags & ATA_QCFLAG_DMAMAP))
 		ata_sg_clean(qc);
 
@@ -4050,6 +4068,15 @@ unsigned int ata_qc_issue(struct ata_que
 	qc->ap->active_tag = qc->tag;
 	qc->flags |= ATA_QCFLAG_ACTIVE;
 
+	{
+		static int cnt = 0;
+		if (++cnt % 1000 == 0) {
+			printk(KERN_ERR "ata%u: inducing race condition\n",
+			       ap->id);
+			qc->flags |= (1 << 31);
+		}
+	}
+
 	return ap->ops->qc_issue(qc);
 
 sg_err:
Index: work1/drivers/scsi/libata-scsi.c
===================================================================
--- work1.orig/drivers/scsi/libata-scsi.c	2006-02-01 23:29:00.000000000 +0900
+++ work1/drivers/scsi/libata-scsi.c	2006-02-01 23:29:50.000000000 +0900
@@ -737,6 +737,14 @@ int ata_scsi_error(struct Scsi_Host *hos
 
 	DPRINTK("ENTER\n");
 
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	if (qc && (qc->flags & (1 << 31))) {
+		printk(KERN_ERR "ata%u: EH invoked for delayed qc %p, sleeping 5secs\n",
+		       ap->id, qc);
+		msleep(5000);
+		printk(KERN_ERR "ata%u: woke up, proceeding with EH\n", ap->id);
+	}
+
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(!(ap->flags & ATA_FLAG_IN_EH));

--sm4nu43k4a2Rpi4c--
