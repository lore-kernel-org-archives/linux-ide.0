From: Paul Rolland <rol@as2917.net>
Subject: Re: [2.6.22.5] irq X: nobody cared but X is successfully used by
 libata
Date: Fri, 19 Oct 2007 14:14:21 +0200
Message-ID: <20071019141421.5a13e90c@tux.DEF.witbe.net>
References: <20070826203513.4fa35f68@tux.DEF.witbe.net>
	<6bffcb0e0708261637s3369dd6fl1f833461e41c4daa@mail.gmail.com>
	<47182323.10706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tag.witbe.net ([81.88.96.48]:52021 "EHLO tag.witbe.net"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750826AbXJSMO2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Oct 2007 08:14:28 -0400
In-Reply-To: <47182323.10706@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Hi Tejun,

On Fri, 19 Oct 2007 12:23:15 +0900
Tejun Heo <htejun@gmail.com> wrote:

> > On 26/08/07, Paul Rolland <rol@as2917.net> wrote:
> >> My machine (an ASUS P5W-DH-Deluxe, Core2, 4Go RAM, 3 SATA and 2IDE) is
> >> reporting a :
> >> irq 23: nobody cared (try booting with the "irqpoll" option)
> >> together with a Call Trace, but :
> >>  - irqpoll is present on the command line,
> >>  - the irq is reported to be used by libata,
> >>  - the irqpoll option is mandatory if I want _some_ of my SATA disks to
> >> be accessible.
> 
> Does this still happen with 2.6.23?  If so, please post boot log.  Thanks.
> 
Not tested yet, will do so during the WE.

Regards,
Paul
