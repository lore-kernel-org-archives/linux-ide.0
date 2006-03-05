From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/4] libata: implement port_task
Date: Mon, 6 Mar 2006 01:23:05 +0900
Message-ID: <20060305162305.GA1156@htj.dyndns.org>
References: <11415401491000-git-send-email-htejun@gmail.com> <440B0D24.7080501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.181]:38590 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932104AbWCEQXK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 11:23:10 -0500
Received: by pproxy.gmail.com with SMTP id t32so604823pyc
        for <linux-ide@vger.kernel.org>; Sun, 05 Mar 2006 08:23:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <440B0D24.7080501@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Sun, Mar 05, 2006 at 11:09:08AM -0500, Jeff Garzik wrote:
> >+/**
> >+ *	ata_port_queue_task - Queue port_task
> >+ *	@ap: The ata_port to queue port_task for
> >+ *
> >+ *	Schedule @fn(@data) for execution after @delay jiffies using
> >+ *	port_task.  There is one port_task per port and it's the
> >+ *	user(low level driver)'s responsibility to make sure that only
> >+ *	one task is active at any given time.
> >+ *
> >+ *	libata core layer takes care of synchronization between
> >+ *	port_task and EH.  ata_port_queue_task() may be ignored for EH
> >+ *	synchronization.
> >+ *
> >+ *	LOCKING:
> >+ *	Inherited from caller.
> >+ */
> >+void ata_port_queue_task(struct ata_port *ap, void (*fn)(void *), void 
> >*data,
> >+			 unsigned long delay)
> >+{
> >+	int rc;
> >+
> >+	if (ap->flags & ATA_FLAG_FLUSH_PIO_TASK)
> >+		return;
> >+
> >+	PREPARE_WORK(&ap->port_task, fn, data);
> >+
> >+	if (!delay)
> >+		rc = queue_work(ata_wq, &ap->port_task);
> >+	else
> >+		rc = queue_delayed_work(ata_wq, &ap->port_task, delay);
> 
> Two worries here, though not quite a NAK:
> 
> 1) This is abuse of the PREPARE_WORK(), which is usually not used 
> because INIT_WORK() took care of the initialization.  However, it should 
> be OK if...

I first used separate atomic flag and INIT_WORK() for this but seemed
like an overkill as task->pending does mostly the same thing.

> 2) This will fall apart if anything tries to queue a task while a 
> previous task is still pending.  Are you certain a double-queue never 
> ever happens?

The current code never does and neither does irq-pio branch (irq-pio
actually uses only one task, so...).  Also, if any such event occurs,
WARN_ON(rc == 0) should almost always trigger and whine about it.

We can also choose to generalize it further such that there can be
more than one libata-managed tasks but there's no need yet.

-- 
tejun
