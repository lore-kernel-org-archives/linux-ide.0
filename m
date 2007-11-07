From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 4/4] libata sata_qstor conversion to new error handling
	(EH).
Date: Wed, 7 Nov 2007 18:27:21 -0500
Message-ID: <20071107232721.GB26706@havoc.gtf.org>
References: <4731DF06.3050202@rtr.ca> <4731DFA7.8010202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:57485 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753749AbXKGX1V (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Nov 2007 18:27:21 -0500
Content-Disposition: inline
In-Reply-To: <4731DFA7.8010202@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Wed, Nov 07, 2007 at 10:54:15AM -0500, Mark Lord wrote:
> sata_qstor conversion to new error handling (EH).
> 
> Convert sata_qstor to use the newer libata EH mechanisms.
> Based on earlier work by Jeff Garzik.
> 
> This belongs in 2.6.24.
> 
> Signed-off-by:  Mark Lord <mlord@pobox.com>

Did you test this with both device probe ("it works") and at least
one device error?

	Jeff



