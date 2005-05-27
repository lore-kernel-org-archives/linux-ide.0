From: Jens Axboe <axboe@suse.de>
Subject: Re: Playing with SATA NCQ
Date: Fri, 27 May 2005 09:20:47 +0200
Message-ID: <20050527072046.GN1435@suse.de>
References: <20050526140058.GR1419@suse.de> <4295F87B.9070106@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([62.242.22.158]:31930 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261724AbVE0HTu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 May 2005 03:19:50 -0400
Content-Disposition: inline
In-Reply-To: <4295F87B.9070106@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 26 2005, Jeff Garzik wrote:
> >+	return 0;
> >+}
> >+
> >+/**
> >  *	ata_bus_probe - Reset and probe ATA bus
> >  *	@ap: Bus to probe
> >  *
> >@@ -2753,6 +2830,16 @@
> > 	struct ata_port *ap = qc->ap;
> > 	unsigned int tag, do_clear = 0;
> > 
> >+	if (likely(qc->flags & ATA_QCFLAG_ACCOUNT)) {
> >+		if (qc->flags & ATA_QCFLAG_NCQ) {
> >+			assert(ap->ncq_depth);
> >+			ap->ncq_depth--;
> >+		} else {
> >+			assert(ap->depth);
> >+			ap->depth--;
> >+		}
> >+	}
> 
> why is this accounting conditional?

I double checked this. If you agree to move the setting of QCFLAG_ACTIVE
_after_ successful ap->ops->qc_issue(qc) and clear it _after_
__ata_qc_complete(qc) then I can just use that bit and kill
ATA_QCFLAG_ACCOUNT.

What do you think?

-- 
Jens Axboe

