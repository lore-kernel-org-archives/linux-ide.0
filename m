From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: AIC 8110
Date: Sun, 23 Jan 2005 14:08:30 +0300
Message-ID: <20050123140830.00af03a0.vsu@altlinux.ru>
References: <Pine.LNX.4.44.0501192013300.14873-100000@kenzo.iwr.uni-heidelberg.de>
	<58cb370e050119113410ce3baf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__23_Jan_2005_14_08_30_+0300_Yu9/fzdd.MRn/KcV"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.177.124.23] ([213.177.124.23]:18304 "EHLO sirius.home")
	by vger.kernel.org with ESMTP id S261289AbVAWLJ5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Jan 2005 06:09:57 -0500
In-Reply-To: <58cb370e050119113410ce3baf@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>, linux-ide@vger.kernel.org

--Signature=_Sun__23_Jan_2005_14_08_30_+0300_Yu9/fzdd.MRn/KcV
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 19 Jan 2005 20:34:33 +0100 Bartlomiej Zolnierkiewicz wrote:

> On Wed, 19 Jan 2005 20:24:56 +0100 (CET), Bogdan Costescu
> <Bogdan.Costescu@iwr.uni-heidelberg.de> wrote:
> > 
> > Hi!
> 
> Hi Bogdan,
>  
> > Does anyone has some information about Adaptec's AIC 8110 SATA adapter ?
> > 
> > I can see it used on mainboards like Asus PSCH-SR/SATA, but I couldn't
> > find any information about Linux support. One of the Google searches
> > returned a hit suggesting that it's just a rebranded Silicon Image
> > chip, but without specifying which chip...
> 
> Since it is 4xSATA controller I bet that it is based on SiL3114.

Does not seem to be the case.  The Windows .inf file contains these PCI IDs:

  PCI\VEN_11ab&DEV_5041
  PCI\VEN_11ab&DEV_5081

which, according to the pci.ids file, are:

11ab  Marvell Technology Group Ltd.
	5041  MV88SX5041 4-port SATA I PCI-X Controller
	5081  MV88SX5081 8-port SATA I PCI-X Controller

--Signature=_Sun__23_Jan_2005_14_08_30_+0300_Yu9/fzdd.MRn/KcV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB84WuW82GfkQfsqIRAtRzAKCNplOSvVfHGJMIsMQUI0dCOYyljgCeNG6S
cWv0W+zNjakMkMK4qwoI6V8=
=jbee
-----END PGP SIGNATURE-----

--Signature=_Sun__23_Jan_2005_14_08_30_+0300_Yu9/fzdd.MRn/KcV--
