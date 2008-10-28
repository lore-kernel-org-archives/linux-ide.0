From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 2.6.28-rc2] sata_promise: proper hardreset
Date: Tue, 28 Oct 2008 13:01:04 +0100
Message-ID: <18694.65280.371472.203936@harpo.it.uu.se>
References: <200810270049.m9R0ngI8027933@harpo.it.uu.se>
	<490673AB.2090502@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:56449 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752404AbYJ1MCm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Oct 2008 08:02:42 -0400
In-Reply-To: <490673AB.2090502@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org

Tejun Heo writes:
 > Hello, Mikael.
 > 
 > Mikael Pettersson wrote:
 > > +static int pdc_pata_hardreset(struct ata_link *link, unsigned int *class,
 > > +			      unsigned long deadline)
 > > +{
 > > +	pdc_reset_port(link->ap);
 > > +	return 0;
 > > +}
 > 
 > You either need to return -EAGAIN here to ask for follow-up SRST or
 > override softreset.  I think pdc_reset_port() doesn't actually reset the
 > ATA channel, right?  In that case, the latter would be the correct thing
 > to do.

(ponders..) ah yes, pata normally skips hardreset so this would
make it skip the needed softreset. pdc_reset_port() just reinits
the ATA engine, nothing else should be affected.

I'll update the patch to make pata override ->softreset instead.

Thanks.

/Mikael
