From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Maybe a bug in libata-core
Date: Mon, 23 Aug 2010 10:44:00 +0100
Message-ID: <20100823104400.37cfb3f0@lxorguk.ukuu.org.uk>
References: <4C71C645.8050007@stud.tu-ilmenau.de>
	<4C723C65.6080303@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-14
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33754 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753122Ab0HWJ3s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Aug 2010 05:29:48 -0400
In-Reply-To: <4C723C65.6080303@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: stefan.huebner@stud.tu-ilmenau.de, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Mon, 23 Aug 2010 11:16:21 +0200
Tejun Heo <tj@kernel.org> wrote:

> On 08/23/2010 02:52 AM, Stefan /*St0fF*/ H=FCbner wrote:
> > Hi Jeff and list,
> >=20
> > maybe this mail was wrong on the linux-scsi list.  So here we go ag=
ain:
> >=20
> > -------- Original-Nachricht --------
> > Betreff: Maybe a bug in libata-core
> > Datum: Fri, 20 Aug 2010 23:48:09 +0200
> > Von: Stefan H=FCbner  <stefan.huebner@stud.tu-ilmenau.de>
> > Antwort an: stefan.huebner@stud.tu-ilmenau.de
> > Organisation: TU-Ilmenau
> > An: linux-scsi@vger.kernel.org
> >=20
> >  Hi List!
> >=20
> > After sending a WRITE_DMA_FUA_EXT ATA-command via SG_IO Passthru to=
 a
> > harddisk (here: /dev/sdd), my kernel panics.  The is what I find in=
 syslog:
>=20
> You're sending down data command w/o data.  Panicking probably isn't
> the best response here.  Maybe the BUG_ON() should be changed to
> WARN_ON_ONCE() + goto sg_err.

It's user triggerable (as root I grant) so really shouldn't be
generating WARNs in that case either - just an -EIO.

Alan
