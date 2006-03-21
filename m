From: Sander <sander@humilis.net>
Subject: Re: Some sata_mv error messages
Date: Tue, 21 Mar 2006 08:28:59 +0100
Message-ID: <20060321072859.GB4089@favonius>
References: <20060318044056.350a2931.akpm@osdl.org> <20060320133318.GB32762@favonius> <441F508E.1030008@pobox.com> <441F8599.7080703@rtr.ca>
Reply-To: sander@humilis.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ookhoi.xs4all.nl ([213.84.114.66]:15574 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932196AbWCUH3B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Mar 2006 02:29:01 -0500
Content-Disposition: inline
In-Reply-To: <441F8599.7080703@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, sander@humilis.net, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, lkml@rtr.ca

Mark Lord wrote (ao):
> Jeff Garzik wrote:
> >For now, the goal is a system that doesn't crash and doesn't corrupt 
> >data. If its occasionally slow or spits out a few errors, but
> >otherwise still works, that's pretty darned good :)
> 
> I'm currently working with the original authors of sata_mv, and have
> taken over maintenance of it for now. It should progress from "highly
> experimental" to "production quality" over the next month or so.

Thanks a lot :-)

> The (mucho) updated driver I'm using here now is already much improved
> in many ways. At some point, I'll break it out into patches for Jeff.
> 
> But there's one MAJOR bugfix patch that I'll release here shortly, to
> go with the interrupt handler fix already posted.

I've actually a patched kernel ready to test your patch. Only need to
boot the server, so will do that this afternoon and report back.

	Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
