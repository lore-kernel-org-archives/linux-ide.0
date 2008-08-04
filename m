From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] sata_fsl.c: fix 8315DS workaround
Date: Mon, 4 Aug 2008 12:22:15 +0300
Message-ID: <20080804092215.GE6088@cs181140183.pp.htv.fi>
References: <20080804084611.GA6088@cs181140183.pp.htv.fi> <A94B04433DF4F44C9C2AB5DEFBF29A4E05E1E7@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:41882 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752750AbYHDJXb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Aug 2008 05:23:31 -0400
Content-Disposition: inline
In-Reply-To: <A94B04433DF4F44C9C2AB5DEFBF29A4E05E1E7@zch01exm26.fsl.freescale.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Li Yang <LeoLi@freescale.com>
Cc: Kalra Ashish <ashish.kalra@freescale.com>, Jeff Garzik <jeff@garzik.org>, galak@kernel.crashing.org, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, "Robert P. J. Day" <rpjday@crashcourse.ca>

On Mon, Aug 04, 2008 at 04:55:37PM +0800, Li Yang wrote:
> > -----Original Message-----
> > From: Adrian Bunk [mailto:bunk@kernel.org] 
> > Sent: Monday, August 04, 2008 4:46 PM
> > To: Kalra Ashish; Li Yang; Jeff Garzik; galak@kernel.crashing.org
> > Cc: linuxppc-dev@ozlabs.org; linux-ide@vger.kernel.org; 
> > Robert P. J. Day
> > Subject: [2.6 patch] sata_fsl.c: fix 8315DS workaround
> > 
> > Commit e7eac96e8f0e57a6e9f94943557bc2b23be31471 
> > (ata/sata_fsl: Move MPC8315DS link speed limit workaround to 
> > specific ifdef) aimed at limiting the workaround only to the 
> > affected hardware, but since the #ifdef used a nonexisting 
> > kconfig variable it actually killed the workaround.
> 
> This workaround is only for MPC8315_DS board which is not supported in the main line yet.  We can remove the workaround if we need to do something here.

Thanks, in this case my patch is complete crap.

There's no need for any action.

> - Leo

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

