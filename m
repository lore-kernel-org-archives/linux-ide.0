From: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: fixup incomplete ident blocks on ITE raid volumes
Date: Sun, 15 Aug 2004 16:27:22 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040815202722.GA29861@devserv.devel.redhat.com>
References: <20040815144527.GA7983@devserv.devel.redhat.com> <1092601693.8976.140.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:59347 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266891AbUHOU2X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Aug 2004 16:28:23 -0400
Content-Disposition: inline
In-Reply-To: <1092601693.8976.140.camel@nosferatu.lan>
List-Id: linux-ide@vger.kernel.org
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org, Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>, torvalds@osdl.org

On Sun, Aug 15, 2004 at 10:28:13PM +0200, Martin Schlemmer wrote:
> > +		}
> > +		id->cyls = 1 + id->lba_capacity_2 / (id->heads * id->sectors);
> > +		/* LBA28 is ok, DMA is ok, UDMA data is valid */

Change that to use sector_div() and it should be fine. My gcc didn't end
up generating internal gcc library helpers for that so I didnt notice.
