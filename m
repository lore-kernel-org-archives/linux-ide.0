From: Petr Sebor <petr@scssoft.com>
Subject: Re: sata_via - too slow
Date: Tue, 03 Aug 2004 00:22:01 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <410EBE89.9000008@scssoft.com>
References: <410E2E9C.8020606@scssoft.com> <410EC673.1090506@clanhk.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE40A0BDB6390ABA736B2B574"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fe-cecom-sitel1.supernetwork.cz ([81.31.3.242]:14720 "EHLO
	lindik.prosek.czf") by vger.kernel.org with ESMTP id S264192AbUHBWWP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Aug 2004 18:22:15 -0400
In-Reply-To: <410EC673.1090506@clanhk.org>
List-Id: linux-ide@vger.kernel.org
To: "J. Ryan Earl" <heretic@clanhk.org>
Cc: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE40A0BDB6390ABA736B2B574
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

J. Ryan Earl wrote:

> Petr Sebor wrote:
>
>> and it is being worse, I can see frequently, that the 'wait' gets 
>> frequently over 90%.
>> I have tried the kernel both in SMP or UP, with noacpi, iommu=off, 
>> preemptible kernel or not
>> without difference....
>
>
> Which 86_64.org patches are you using?

None. It is vanilla 2.6.7 kernel with 2.6.8-rc2-bkX patch. I'd try to 
patch the kernel with x86_64.org's
stuff, but I thought this applies only if I run the kernel in native - 
64bit mode. I haven't gotten that far...
The kernel is compiled with K7 Athlon CPU optimizations, nothing more.

>
>>
>> From what I have understood, these drives are SATA with PATA bridge 
>> on them.
>> The problems described happen on both. No difference.
>>
>> Interesting is, that
>> root@opteron:$ hdparm -t /dev/sda
>>
>> /dev/sda:
>> Timing buffered disk reads:  144 MB in  3.03 seconds =  47.45 MB/sec
>>
>> So it is not _that_ slow... 
>
>
> I highly doubt it's related to libata or sata_via at all.  A high wait 
> indicates your processors handle data a lot faster than your 
> harddrives can deliver and processes are blocked waiting on I/O, it 
> would otherwise be counted as idle time in the 2.4 line; this is 
> normal AFAIK.  Your performance is nominal, the problem is most likely 
> elsewhere.

The more I naively think about it the more I am getting the similar 
feeling. I fear I have incorrectly blamed
the sata layer, but I don't remember having similar problems with ide 
drives.

> What motherboard is this?  The MSI FAR2 whatever?

It is MSI Master2-FAR.. sorry for not mentioning that.

Petr


--------------enigE40A0BDB6390ABA736B2B574
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBDr6Xir6eWjmOQ6cRAhDCAJ91pckAlKCFkbwYIKfzeHP3kn1qQACfekcU
RV83tFNSTyKiOStR1Z6tJdY=
=xT/f
-----END PGP SIGNATURE-----

--------------enigE40A0BDB6390ABA736B2B574--
