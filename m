From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.30-rc2 2/2] palm_bk3710:  UDMA performance fix
Date: Wed, 22 Apr 2009 15:29:23 -0700
Message-ID: <200904221529.23427.david-b@pacbell.net>
References: <200904201841.10989.david-b@pacbell.net>
	<200904221343.14414.david-b@pacbell.net>
	<200904222305.54820.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <200904222305.54820.bzolnier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Bartlomiej Zolnierkiewicz <bzolnier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, DaVinci <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Wednesday 22 April 2009, Bartlomiej Zolnierkiewicz wrote:
> 
> > By the way ... what about the first patch,
> > which removed accesses to all those non-existent
> > registers and bitfields?
> 
> I didn't see any discussion on it and it looked less urgent / more risky
> (it is not uncommon for documentation to lack some data) than patch #2.

It's uncommon for TI's documentation to be that far off,
for that long, though.  "Lacking" docs for 50% of the
registers, for several years ... doesn't make sense.

The current reset handling is clearly broken:  the docs
are quite explicit that the controller doesn't drive the
reset signal, it's got to be done through a GPIO.  The
board designs match that part of the docs.  The code is
thus contrary to *all* other documentation.

Early DaVinci drivers sometimes exhibited a flagrant
disregard for chip documentation.  This driver is from
about that era.  Maybe it started from prototypes using
the a different controller design, for example.


> Should it also go upstream for 2.6.30?

I can't say either patch would be urgent for 2.6.30,
but of course it's good that bugfixes merge ASAP.

Since we're only at RC3, I'd be inclined to push both
up right now.  If we were at RC6 or so, I'd hold off
till the next merge window.

- Dave
