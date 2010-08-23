From: Tejun Heo <tj@kernel.org>
Subject: Re: Fwd: Maybe a bug in libata-core
Date: Mon, 23 Aug 2010 11:16:21 +0200
Message-ID: <4C723C65.6080303@kernel.org>
References: <4C71C645.8050007@stud.tu-ilmenau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41862 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753617Ab0HWJWq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Aug 2010 05:22:46 -0400
In-Reply-To: <4C71C645.8050007@stud.tu-ilmenau.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: stefan.huebner@stud.tu-ilmenau.de
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On 08/23/2010 02:52 AM, Stefan /*St0fF*/ H=FCbner wrote:
> Hi Jeff and list,
>=20
> maybe this mail was wrong on the linux-scsi list.  So here we go agai=
n:
>=20
> -------- Original-Nachricht --------
> Betreff: Maybe a bug in libata-core
> Datum: Fri, 20 Aug 2010 23:48:09 +0200
> Von: Stefan H=FCbner  <stefan.huebner@stud.tu-ilmenau.de>
> Antwort an: stefan.huebner@stud.tu-ilmenau.de
> Organisation: TU-Ilmenau
> An: linux-scsi@vger.kernel.org
>=20
>  Hi List!
>=20
> After sending a WRITE_DMA_FUA_EXT ATA-command via SG_IO Passthru to a
> harddisk (here: /dev/sdd), my kernel panics.  The is what I find in s=
yslog:

You're sending down data command w/o data.  Panicking probably isn't
the best response here.  Maybe the BUG_ON() should be changed to
WARN_ON_ONCE() + goto sg_err.

Thanks.

--=20
tejun
