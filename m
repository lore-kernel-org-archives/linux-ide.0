From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [PATCH] drivers/ata/sata_via.c - Eliminate "may be used
	uninitialized" warning
Date: Mon, 7 Apr 2008 10:53:57 +0300
Message-ID: <20080407075357.GB20257@cs181133002.pp.htv.fi>
References: <1207518320.1803.52.camel@localhost> <20080406215054.GI30987@cs181133002.pp.htv.fi> <1207519207.1803.60.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755270AbYDGHyp@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1207519207.1803.60.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Sun, Apr 06, 2008 at 03:00:07PM -0700, Joe Perches wrote:
> On Mon, 2008-04-07 at 00:50 +0300, Adrian Bunk wrote:
> > On Sun, Apr 06, 2008 at 02:45:20PM -0700, Joe Perches wrote:
> > > Called by svia_init_one with a temporary,
> > > so there's no effective code change.
> > I'm not getting any warning here.
> > Are you using an older gcc?
> 
> Yes.  Slightly less than 4.3.0
> 
> $ gcc --version
> gcc (GCC) 4.2.2 20071128 (prerelease) (4.2.2-3.1mdv2008.0)
>...

I've reproduced the warning with 4.2 but not with the 4.3 in Debian 
unstable.

Jeff is the one to decide about this specific patch.

Independent from this specific patch my opinion is that considering that 
we support 7 different release series of gcc aiming for a warning free 
compilation with the latest gcc is a good goal, but aiming for a warning 
free compilation with all supported gcc release series is not worth it
(especially considering that patches that fix such warnings might even 
introduce new bugs).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
