From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC][PATCH 2.6.13] Marvell SATA support (PIO mode)
Date: Tue, 30 Aug 2005 16:48:04 -0400
Message-ID: <4314C604.4030208@pobox.com>
References: <20050830183625.BEE1520F4C@lns1058.lss.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:60619 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932458AbVH3UsS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Aug 2005 16:48:18 -0400
In-Reply-To: <20050830183625.BEE1520F4C@lns1058.lss.emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Brett Russ wrote:
> This is the first public release of my libata compatible low level driver for
> the Marvell SATA family.  Currently it successfully runs in PIO mode on a 6081
> chip.  EDMA support is in the works and should be done shortly.  Review,
> testing (especially on other flavors of Marvell), comments welcome.

Even though its only PIO, if you feel this is stable, I would like to 
get it into upstream soon-ish.

Current version looks OK to me.

	Jeff



