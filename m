From: Valdis.Kletnieks@vt.edu
Subject: Re: PATCH: (Discussion) Stop IDE legacy ISA probes on PCI systems
Date: Mon, 27 Dec 2004 17:15:39 -0500
Message-ID: <200412272215.iBRMFeRS019650@turing-police.cc.vt.edu>
References: <1104156823.20898.21.camel@localhost.localdomain>
            <y2a7jn34f4h.fsf@cartman.at.fivegeeks.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1478405822P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h80ad25c6.async.vt.edu ([128.173.37.198]:26830 "EHLO
	h80ad25c6.async.vt.edu") by vger.kernel.org with ESMTP
	id S261557AbUL0WSY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Dec 2004 17:18:24 -0500
In-Reply-To: Your message of "Mon, 27 Dec 2004 21:15:26 GMT."
             <y2a7jn34f4h.fsf@cartman.at.fivegeeks.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adam Sampson <azz@us-lot.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

--==_Exmh_-1478405822P
Content-Type: text/plain; charset=us-ascii

On Mon, 27 Dec 2004 21:15:26 GMT, Adam Sampson said:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> >  	switch (index) {
> >  		case 0:	return 0x1f0;
> >  		case 1:	return 0x170;
> > +		
> > +		if(pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) == NULL) {
> > +			case 2: return 0x1e8;
> > +			case 3: return 0x168;
> > +			case 4: return 0x1e0;
> > +			case 5: return 0x160;
> > +		}
> > +
> >  		default:
> >  			return 0;
> >  	}
> 
> I don't think that code will have the intended effect, unless your
> GCC has some funny ideas about switch statements...

Those who don't understand the Duff Device are doomed to re-invent it, poorly. ;)

(Yes Alan, I know *you* know C well enough, but I just looked at that block
of code and it looked *so* much like Tom Duff's that I had to say it. ;)

For those not in the know:

http://www.lysator.liu.se/c/duffs-device.html

--==_Exmh_-1478405822P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB0ImKcC3lWbTT17ARAtFgAKDAUGVXSWL3tVxqR+S2UyUkjNg00QCg+tdR
ZXjSPwBDtFKLwuz+Ptnlqzg=
=VZeg
-----END PGP SIGNATURE-----

--==_Exmh_-1478405822P--
