From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 08/12] libata: convert drivers with combined SATA/PATA ports to new init model
Date: Fri, 9 Mar 2007 23:35:47 +0100 (MET)
Message-ID: <200703092235.l29MZlMx007319@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:58674 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767574AbXCIWgG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 17:36:06 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk, htejun@gmail.com, jeff@garzik.org, linux-ide@vger.kernel.org

On Fri, 9 Mar 2007 20:15:36 +0900, Tejun Heo wrote:
> Convert sata_via and sata_promise to nwe init model.  Both controllers
> can have combined configuration (SATA + PATA) and used twisted
> initialization method (modifying port in ->port_start) to overcome
> probe_ent limitations.
> 
> This patch converts both drivers to new init model in which such
> configuration is natively supported.
> 
> * promise: Combined pata port now uses separate port_info entry right
>   after the sata counterpart entry.
> 
> * promise: Controller configuration is discerned using ap->flags.
>   This simplifies init path and makes it look more like other LLDs.
> 
> * promise: SATA/PATA branches are converted into separate ops.
>   Remaining ones are converted to more standard ap->cbl ==
>   ATA_CBL_SATA check.

I don't object to the new init model in principle.
My only reservation here is that you are folding what
logically are separate changes into one big change to
sata_promise, and that makes the patch more difficult
to review (and regressions more difficult to trace).

I would like to do the SATA/PATA splitup into distinct
operations as a separate first step, with you doing the
new init model adaptation in a followup step.

Also, at least the error handler changes would seem to
be in conflict with Alan's cable type changes.

/Mikael
