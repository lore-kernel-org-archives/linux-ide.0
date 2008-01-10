From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device
	driver
Date: Wed, 9 Jan 2008 18:36:34 -0600
Message-ID: <20080110003634.GA19966@lixom.net>
References: <20080109190852.GA18827@localhost.localdomain> <20080109191041.GB23283@localhost.localdomain> <20080110104048.2fea6ab3.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:33080 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754117AbYAJA1F (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Jan 2008 19:27:05 -0500
Content-Disposition: inline
In-Reply-To: <20080110104048.2fea6ab3.sfr@canb.auug.org.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Jeff Garzik <jeff@garzik.org>

On Thu, Jan 10, 2008 at 10:40:48AM +1100, Stephen Rothwell wrote:
> Hi Anton,
> 
> Juts one small trivial comment (could be fixed later).
> 
> On Wed, 9 Jan 2008 22:10:41 +0300 Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> >
> > +static struct of_device_id pata_of_platform_match[] = {
> 
> This could be declared const.

Good point, but let's not hold up merge based on this. Need something
for janitors to do too, and it's good enough to merge as-is. :)


-Olof
