From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH] [STACK] >3k call path in ide
Date: Wed, 16 Jun 2004 11:47:37 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040616094737.GA2548@wohnheim.fh-wedel.de>
References: <20040609122921.GG21168@wohnheim.fh-wedel.de> <20040615163445.6b886383.rddunlap@osdl.org> <200406160911.11985.jolt@tuxbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.fh-wedel.de ([213.39.232.194]:58309 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S266224AbUFPJru (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jun 2004 05:47:50 -0400
Content-Disposition: inline
In-Reply-To: <200406160911.11985.jolt@tuxbox.org>
List-Id: linux-ide@vger.kernel.org
To: Florian Schirmer <jolt@tuxbox.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, akpm <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 16 June 2004 09:11:11 +0200, Florian Schirmer wrote:
>=20
> >  failed:
> >      ide_release(link);
> >      link->state &=3D ~DEV_CONFIG_PENDING;
> >
> > +    /* memory allocation errors */
> > +err_cisparse:
> > +    kfree(cfginfo);
> > +err_cfginfo:
> > +    kfree(def_cte);
> > +err_def_cte:
> > +    kfree(tbuf);
> > +err_tbuf:
> > +    printk(KERN_NOTICE "ide-cs: ide_config failed memory allocatio=
n\n");
> > +    goto failed;
> >  } /* ide_config */
>=20
> Huh? This will either leak memory (non alloc error case) or deadlock =
(mem=20
> alloc error case). I'm missing something?

Leak memory.  I also tend to depend on the fact that kfree(NULL) works
just fine:

err_kfree:
	kfree(cfginfo);
	kfree(def_cte);
	kfree(tbuf);
	printk(KERN_NOTICE "ide-cs: ide_config failed memory allocation\n");
	goto failed;

Makes the error path a little simpler.

J=F6rn

--=20
The strong give up and move away, while the weak give up and stay.
-- unknown
