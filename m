From: Phil Dibowitz <phil@ipom.com>
Subject: Re: IDE kernel traces in 2.6.9 - Bad IRQ ?
Date: Sun, 31 Oct 2004 11:14:10 -0800
Message-ID: <41853982.8090807@ipom.com>
References: <418421E9.6000809@ipom.com> <4184C60C.9010407@ipom.com>
 <4184C8BF.5080602@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary=------------enig9C8E7F7D09BB2FF4CBB0D490
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from msg-mx3.usc.edu ([128.125.137.8]:53491 "EHLO msg-mx3.usc.edu")
	by vger.kernel.org with ESMTP id S261318AbUJaTOY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 Oct 2004 14:14:24 -0500
Received: from [10.1.1.2] ([128.125.81.146])
 by msg-mx3.usc.edu (Sun Java System Messaging Server 6.1 HotFix 0.02 (built
 Aug 25 2004)) with ESMTPSA id <0I6G00KBYQRS8T30@msg-mx3.usc.edu> for
 linux-ide@vger.kernel.org; Sun, 31 Oct 2004 11:14:23 -0800 (PST)
In-reply-to: <4184C8BF.5080602@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9C8E7F7D09BB2FF4CBB0D490
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> Phil Dibowitz wrote:
> 
>> Phil Dibowitz wrote:
>>
>>> I just upgraded my computer, compiled a new kernel appropriately, and 
>>> I'm getting a ton of kernel issues surrounding the IDE driver. I 
>>> tried a generic debian kernel as well, but same issue. Here are the 
>>> tracebacks I get during boot:
>>>
>>> Oct 30 15:56:19 rider kernel: ide0 at 0xefe0-0xefe7,0xefae on irq 5
>>> Oct 30 15:56:19 rider kernel: hda: max request size: 128KiB
>>
>>
>>
>> So, it turns out if I change the IDE Configuration in my BIOS to be 
>> "Compatible mode" instead of "Enhanced Mode", this is fixed 
>> completely. All my drives work flawelessly.
>>
>> Any idea what, if any, features I'm missing, or how to make linux work 
>> with "enhanced mode" ?
> 
> 
> 
> Sounds like you're not using CONFIG_SCSI_SATA for your SATA?

Erm. That's possible -- I have an SATA controller on the new board, but 
I don't have any SATA drives, so I didn't compile the promise driver or 
anything else for SATA...

Thanks, I'll look into that.


-- 
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."
  - Benjamin Franklin, 1759


--------------enig9C8E7F7D09BB2FF4CBB0D490
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBhTmCN5XoxaHnMrsRApr8AKCBbMMXan+DMl16UwQjGIoccOglzwCgkFV2
u6G4Jrymx3JJlfusKYTtUGk=
=QI3U
-----END PGP SIGNATURE-----

--------------enig9C8E7F7D09BB2FF4CBB0D490--
