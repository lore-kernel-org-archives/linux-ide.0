From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return
 zeroes after TRIM
Date: Wed, 03 Dec 2014 23:40:29 -0500
Message-ID: <547FE5BD.9070101@ubuntu.com>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net> <547FCECB.4090908@ubuntu.com>	<yq1sigwgkqt.fsf@sermon.lab.mkp.net> <547FD4F6.7090700@ubuntu.com> <yq1k328gk80.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:43480 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751914AbaLDEkj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Dec 2014 23:40:39 -0500
In-Reply-To: <yq1k328gk80.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 12/03/2014 10:35 PM, Martin K. Petersen wrote:
> Phillip> OEM product requirements documents and supply contracts
> sound Phillip> like forms of writing to me.
> 
> Except they are not forms of writing that we as a community have
> access to.

So your assertion is that you have seen it in writing, so we should
all assume the drives will adhere to that, but the writing is private
and can not be verified and the manufacturers can not be held to it if
they choose not to abide by it in the general case, but we should
assume that if they are bound by private contracts, that they would
perform the same way with publically sold models that claim to have
the same model and revision?

I'm not saying a hard hell no, but this certainly makes me
uncomfortable.  I'd much rather see the manufacturers put it in
writing that yes, this make and model will perform this way even
though it is not strictly required by ATA8.  What would be better
still is if the bloody ATA standard got a clue and said that if the
drive claims that it does in fact zero after TRIM, that the TRIM
command becomes mandatory instead of advisory.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCgAGBQJUf+W5AAoJENRVrw2cjl5RObkIAIRy29u8cx1Ejp2gOr01oWn/
tV+Qj0gpgGzcazKDJWpDK5sxboDteoFl+UiI1/1yEPE+dfvwT26ryyqWKsNjTUDb
YcwkT3zn7wgUbloL3yx4WqNZnM9/vDDv1mh94bjdIjZM2iUOpoZj81iGVaKWHIFC
I/qXf5eeHGrPtHBUzdEyAgVtd4pc1dN2zo4KZmwA3Xfj6zxq3knsASE4fgiFuegv
iyC5PvqXN1z14P2f+6/EhT2Ls1Vzo0Y/pnxZstEexftjWG6a4rbaEZVFT/fxawgn
nAqaB0GxvLpD5tSmUKUWtAYFDSWOUP+MIFyPvm0A8V1pLrLQV81PrKZ2qHMKvMU=
=dFFk
-----END PGP SIGNATURE-----
