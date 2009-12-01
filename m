From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata hotplug question
Date: Tue, 01 Dec 2009 16:57:53 +1100
Message-ID: <1259647073.2076.247.camel@pasglop>
References: <1259561052.2076.73.camel@pasglop>
	 <1259624651.2076.158.camel@pasglop>  <4B1459B5.40504@kernel.org>
	 <1259635420.2076.180.camel@pasglop> <1259644647.2076.204.camel@pasglop>
	 <4B14A809.8000304@kernel.org> <1259645409.2076.213.camel@pasglop>
	 <4B14AAD0.4060806@kernel.org>  <1259645941.2076.225.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:53670 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752294AbZLAF62 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 00:58:28 -0500
In-Reply-To: <1259645941.2076.225.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Tue, 2009-12-01 at 16:39 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2009-12-01 at 14:34 +0900, Tejun Heo wrote:
> > In effect, they would be the same but if the hotplug notification can
> > be made reliable, I think using DFLAG_DETACH would be better as
> > there's already other users doing that (user requested detach and ACPI
> > dock removal). 
> 
> Allright. I just need to find how to tell it at boot that it's detached
> to avoid time probing a non existing interface but that's no big deal.

No point bothering, it looks like it picks up the ff's at boot just fine
like an unpopulated interface and things just work without any spurrious
delay.

I'll do a few more tests and will send the patches for review.

Note that I had to do one change to libata-sff:

--- linux-work.orig/drivers/ata/libata-sff.c	2009-12-01 16:51:10.000000000 +1100
+++ linux-work/drivers/ata/libata-sff.c	2009-12-01 16:52:59.000000000 +1100
@@ -2384,7 +2384,7 @@ void ata_sff_post_internal_cmd(struct at
 	ap->hsm_task_state = HSM_ST_IDLE;
 
 	if (ap->ioaddr.bmdma_addr)
-		ata_bmdma_stop(qc);
+		ap->ops->bmdma_stop(qc);
 
 	spin_unlock_irqrestore(ap->lock, flags);

I'll include that change in my patch series.

Cheers,
Ben.


