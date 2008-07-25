From: David Miller <davem@davemloft.net>
Subject: Re: recent IDE regression
Date: Fri, 25 Jul 2008 01:42:52 -0700 (PDT)
Message-ID: <20080725.014252.193706389.davem@davemloft.net>
References: <20080724.233831.193691312.davem@davemloft.net>
	<20080725083448.GE8301@fluff.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753092AbYGYInU@vger.kernel.org>
In-Reply-To: <20080725083448.GE8301@fluff.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: ben-linux@fluff.org
Cc: bzolnier@gmail.com, harvey.harrison@gmail.com, linux-ide@kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
List-Id: linux-ide@vger.kernel.org

From: Ben Dooks <ben-linux@fluff.org>
Date: Fri, 25 Jul 2008 09:34:48 +0100

> On Thu, Jul 24, 2008 at 11:38:31PM -0700, David Miller wrote:
> > diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
> > index 07da5fb..8aae917 100644
> > --- a/drivers/ide/ide-iops.c
> > +++ b/drivers/ide/ide-iops.c
> > @@ -510,10 +510,8 @@ void ide_fixstring (u8 *s, const int bytecount, const int byteswap)
> >  
> >  	if (byteswap) {
> >  		/* convert from big-endian to host byte order */
> > -		for (p = end ; p != s;) {
> > -			unsigned short *pp = (unsigned short *) (p -= 2);
> > -			*pp = ntohs(*pp);
> > -		}
> > +		for (p = end ; p != s;)
> > +			be16_to_cpus((u16 *)(p -= 2));
> 
> personally, i would much prefer to see the loop being less evil
> like:
> 
> 	for (p = s; p < end; p += 2)
> 		be16_to_cpus((u16 *)p);
> 
> is there an architecture/compiler combo which really makes this
> evil worthwile? on arm (gcc 4.2), both evaluate to the same number of
> instructions.

Regardless of what we want to do with this ugly loop, the endianness
macros should be fixed to consistently evaluate their arguments
once just like real function calls do.
