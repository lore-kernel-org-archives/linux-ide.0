From: Sebastian Droege <sebastian.droege@gmx.de>
Subject: Re: [PATCH] IDE TCQ #2
Date: Fri, 3 May 2002 20:36:00 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20020503203600.5ace492d.sebastian.droege@gmx.de>
References: <20020503110652.GF839@suse.de>
	<20020503163248.633c8358.sebastian.droege@gmx.de>
	<20020503164555.GQ839@suse.de>
	<20020503185744.7f4e192f.sebastian.droege@gmx.de>
	<20020503170118.GV839@suse.de>
	<20020503193006.6b4b9094.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.)?ii'QGHd+1L/f"
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20020503193006.6b4b9094.sebastian.droege@gmx.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

--=.)?ii'QGHd+1L/f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 May 2002 19:30:06 +0200
Sebastian Droege <sebastian.droege@gmx.de> wrote:

> On Fri, 3 May 2002 19:01:18 +0200
> Jens Axboe <axboe@suse.de> wrote:
> 
> > > > > ide_tcq_intr_timeout: timeout waiting for interrupt...
> > > > > ide_tcq_intr_timeout: hwgroup not busy
> > > > 
> > > > We timed out waiting for an interrupt for service or dma completion.
> > > > Damn, I forgot to print which one. Please change that printk in
> > > > drivers/ide/ide-tcq.c:ide_tcq_intr_timeout() to:
> > > > 
> > > > 	printk("ide_tcq_intr_timeout: timeout waiting for %s interrupt...\n",
> > > > 		hwgroup->rq ? "completion" : "service");
> > > > 
> > > > and reproduce!
> > > Is this printk enough or should I handcopy the oops again? ;)
> > 
> > The oops is pretty irrelevant here, the fact that it triggers is enough
> > to know. I already know the backtrace :-)
> 
> It's a service interrupt....
> I'm currently recompiling without preempt

Ok... the problem doesn't solve simple by disabling preempt :(

Bye
--=.)?ii'QGHd+1L/f
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE80tiUe9FFpVVDScsRAromAJ9Z3BXAx1LL0ZAy2003dQyR+1t7gQCfRhqS
2LWo3PNV6WsK+Jt1/IV2Tvw=
=Crdw
-----END PGP SIGNATURE-----

--=.)?ii'QGHd+1L/f--

