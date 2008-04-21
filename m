From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] make sata_set_spd_needed() static
Date: Mon, 21 Apr 2008 12:03:31 +0300
Message-ID: <20080421090331.GJ26897@cs181133002.pp.htv.fi>
References: <20080421085117.GC26897@cs181133002.pp.htv.fi> <20080421085732.GR12215@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:41953 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754475AbYDUJD7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Apr 2008 05:03:59 -0400
Content-Disposition: inline
In-Reply-To: <20080421085732.GR12215@devserv.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 21, 2008 at 04:57:32AM -0400, Jeff Garzik wrote:
> On Mon, Apr 21, 2008 at 11:51:17AM +0300, Adrian Bunk wrote:
> > sata_set_spd_needed() can now become static.
> > 
> > Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> For future reference...  please don't email jgarzik@redhat.com unless
> its an NDA issue or similar.  That email is only for signed-off-by
> lines, never for actual email (you never see me post to a list
> @redhat.com, nor will you see me in git as /author/ @redhat.com)
>...

In this case I pasted it from a signed-off-by line...

I will try to remember this special case of your email address in the 
future (but please don't be offended if I might send accidentally to 
the @redhat.com address again).

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

