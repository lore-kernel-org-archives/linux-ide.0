From: Phil Dibowitz <phil@ipom.com>
Subject: Re: Promise 20378
Date: Mon, 04 Jul 2005 22:50:22 -0700
Message-ID: <42CA1F9E.4090305@ipom.com>
References: <42C7B584.401@ipom.com> <42C9F50B.4000508@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary=------------enigCD68411A38A77E04DDB68DA6
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from msg-mx2.usc.edu ([128.125.137.7]:44499 "EHLO msg-mx2.usc.edu")
	by vger.kernel.org with ESMTP id S261752AbVGEFuY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jul 2005 01:50:24 -0400
Received: from [10.1.1.2] ([128.125.81.146])
 by msg-mx2.usc.edu (Sun Java System Messaging Server 6.2-2.02 (built Mar 22
 2005)) with ESMTPSA id <0IJ5002U347Z0I30@msg-mx2.usc.edu> for
 linux-ide@vger.kernel.org; Mon, 04 Jul 2005 22:50:23 -0700 (PDT)
In-reply-to: <42C9F50B.4000508@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCD68411A38A77E04DDB68DA6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> Phil Dibowitz wrote:
> 
>> So, there doesn't appear to be a driver for the 20378 in the kernel...
>> though google showed a few people using some proprietary drivers with
>> varying luck. Ew.
>>
>> I noticed there are a lot of other Promise drivers in the kernel for the
>> same general line, which leads me to believe there may be some interest
>> in getting a 20378 driver in the kernel.
>>
>> So, since I now own a machine with one, I thought I'd drop this list a
>> line and say "I can test stuff and provide info on the chipset"...
> 
> 
> Just add the PCI ID to drivers/scsi/sata_promise.c...

Markus K. emailed me to let me know about sata_promise, which already
binds to my controller with no errors. I'm wondering if it'll support
the PATA controller on there as well - we'll see. I'll play around with
it and report back. Thanks.

-- 
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."
 - Benjamin Franklin, 1759


--------------enigCD68411A38A77E04DDB68DA6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCyh+fN5XoxaHnMrsRAu+pAJ9wWnScmXIVdhOaS3S2vXYMfrnySwCgnRgr
Ktrgu4Pn4F+M0q514qP6sHc=
=QtTj
-----END PGP SIGNATURE-----

--------------enigCD68411A38A77E04DDB68DA6--
