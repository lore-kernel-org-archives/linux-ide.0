From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/13] ATA ACPI: debugging infrastructure
Date: Tue, 28 Feb 2006 13:04:18 +0100
Message-ID: <20060228120418.GB3695@elf.ucw.cz>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222135133.3f80fbf9.randy_d_dunlap@linux.intel.com> <20060228114500.GA4057@elf.ucw.cz> <44043B4E.30907@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12717 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932377AbWB1MK3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 07:10:29 -0500
Content-Disposition: inline
In-Reply-To: <44043B4E.30907@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Randy Dunlap <randy_d_dunlap@linux.intel.com>, lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, akpm@osdl.org

On =DAt 28-02-06 07:00:14, Jeff Garzik wrote:
> Pavel Machek wrote:
> >I hate to see debugging infrastructure like this. We already have it
> >in ACPI and it is nasty/useless. It hides serious errors during norm=
al
> >run, while if you turn on the debugging, it floods logs so that
> >it is unusable, too. I end up having to replace dprintks with
> >printks... nasty.
>=20
> Then you clearly don't understand what the code is doing.
> Fine-grained=20

No, I do not... code is so full of printk()s that it is unreadable.

> message selection allows one to turn on only the messages needed, and=
=20
> only for the controller desired.  Otherwise, it is nearly impossible =
to=20
> debug one SATA controller while booting off another.

Now, maybe message selection is neccessary, but having printk at
begining of each function is not way to go.
								Pavel

--=20
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted.=
=2E.
