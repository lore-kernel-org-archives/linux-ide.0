From: Hugo Mills <hugo-lkml@carfax.org.uk>
Subject: Re: [PATCH][RFC] Add support for Adaptec 1210SA (was: Re: SiI3112 (Adaptec 1210SA): no devices)
Date: Sun, 8 Jun 2003 22:45:04 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20030608214504.GA5754@carfax.org.uk>
References: <20030607175637.GA1266@carfax.org.uk> <200306071802.h57I2Yb07842@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:34693 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S263915AbTFHVbm
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Jun 2003 17:31:42 -0400
Content-Disposition: inline
In-Reply-To: <200306071802.h57I2Yb07842@devserv.devel.redhat.com>
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: Samuel Flory <sflory@rackable.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, andre@linux-ide.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 07, 2003 at 02:02:34PM -0400, Alan Cox wrote:
> >    I've assumed that it's exactly like a SiI3112 in making these
> > changes. The kernel now recognises the device, and I can (e.g.) run
> > cfdisk. However, any read or write on the disk causes huge delays, and
> > these:
> 
> Its clearly clos in that it works in PIO although DMA is failing

   Given that there appear to be problems with DMA in the plain SiI
driver, would it be worth my while waiting until those are sorted out
before continuing?

> >    I don't have the knowledge to determine whether this is similar to
> > the SiI3112 problems people have been having elsewhere, or if it's a
> 
> It is

   That's good to know.

> >  Model=ST3120026AS, FwRev=3.05, SerialNo=3JT059GT
> 
> According to the info I have that drive should be working ok

   I recall Andre Hedrick commenting apparently disparagingly on the
80Gb version of the Seagate drives[1], although I don't get the errors
seen in that post.

> This is a very good starting point anyway

   What would be the next steps in getting this thing working?  Should
I try to obtain the board/chip specifications from Adaptec? Or start
poking stuff into arbitrary registers? :)

   Hugo.

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=105013509721375&w=2

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
              --- The future isn't what it used to be. ---               

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+465gssJ7whwzWGARAo2qAJ9TiFEqwquk3IbLkytmu57pH9cCOQCgskdI
0Z3CCQ18CVIk5EC41FP2pRo=
=rnSA
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
