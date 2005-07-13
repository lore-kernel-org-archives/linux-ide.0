From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Host protected area on suspend/resume
Date: Wed, 13 Jul 2005 15:25:15 +0400
Message-ID: <20050713152515.61c61ee2.vsu@altlinux.ru>
References: <20050712113044.GA8744@srcf.ucam.org>
	<42D3D87F.5040901@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__13_Jul_2005_15_25_15_+0400_T683iyR8BxDzKm5m"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mivlgu.ru ([81.18.140.87]:34186 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S262612AbVGMLZX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jul 2005 07:25:23 -0400
In-Reply-To: <42D3D87F.5040901@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl

--Signature=_Wed__13_Jul_2005_15_25_15_+0400_T683iyR8BxDzKm5m
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 12 Jul 2005 23:49:35 +0900 Tejun Heo wrote:

> Matthew Garrett wrote:
> > On boot, Linux will attempt to disable the host protected area on a 
> > disk. After a suspend/resume cycle, the BIOS may reenable it (seen on a 
> > Thinkpad T40 and R40). As a result, the kernel is now unable to access 
> > the HPA.
> > 
> > Is there any issue with just adding a call to idedisk_check_hpa() in the 
> > IDE resume code?
> 
>   This has come up several times now.  One thing I'm curious about is 
> why we are disabling HPA on boot without consent from the user.  AFAIK, 
> HPA is mostly used to implement hidden recovery/suspend storage areas 
> and disabling automatically on boot increases the likeliness of 
> destroying them.  What do we gain by disabling HPA on boot?  Are there 
> some dumb machines which unnecessarily sets HPA and reduces the capacity 
> of drives excessively?  Even in such cases, wouldn't it be better to do 
> idedisk_check_hpa() only when kernel parameter explicitly says so?

Support for disabling HPA during boot is needed mainly for old
machines with BIOS limitations. Some disks have jumpers which limit
capacity to 32 GB, so that such old BIOSes can recognize the disk
without hanging at boot; disabling HPA gives access to the whole
capacity.

--Signature=_Wed__13_Jul_2005_15_25_15_+0400_T683iyR8BxDzKm5m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFC1PoeW82GfkQfsqIRAntTAJ0Vn88/1ZIiEirYCoRbl4iyyD9oYwCffxak
TQTJfCAVJ6hkjwbERiKVElw=
=AGhU
-----END PGP SIGNATURE-----

--Signature=_Wed__13_Jul_2005_15_25_15_+0400_T683iyR8BxDzKm5m--
