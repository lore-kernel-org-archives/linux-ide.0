From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return
 zeroes after TRIM
Date: Wed, 03 Dec 2014 22:02:35 -0500
Message-ID: <547FCECB.4090908@ubuntu.com>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.230]:32705 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751106AbaLDDDh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Dec 2014 22:03:37 -0500
In-Reply-To: <yq18uiojfq9.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 12/03/2014 09:44 PM, Martin K. Petersen wrote:
> This patch whitelists SSDs from a few of the main vendors. None of
> the whitelists are based on written guarantees. They are purely
> based on empirical evidence collected from internal and external
> users that have tested or qualified these drives in RAID
> deployments.

Without anything in writing from the vendor, such a white list amounts
to nothing more than wishful thinking.  You can't really test for it
and even if it *appears* to be so, the drive is free to change its
behavior any time.



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCgAGBQJUf87GAAoJENRVrw2cjl5RPMwIAI3RHHZBhv0xDi5uMCzHdaZM
pSp+OAYtuXuYKNhxEnH/v3RqqeL2joARR7ELa3wZ57DilpANF4SPKeV4TyJqdjxG
BLYeW1jySSNn7LjBDRxSgg61FRka4Bz3m4MCA6/6pfZawufE4bkTshRhpMzIWMsb
AAt1d1Kyw2a2wat2+h75LqEVuPdTcENBV7B1Ow//zObkljGf3p3Jkjiz3ZKE3bIT
kXIu62kypdUbvpYCtSE7Xa51Io74jPtZPyjc6vrsFaB8ulhFzDg5WK4o8Ndswz3D
Rjq4WAl7dOJ0KUKef3n57YZFjgtfPo3VUIXzrDOo0hCXYUO77Kxei9ZwOtJUkrc=
=5Wuq
-----END PGP SIGNATURE-----
