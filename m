From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: PMP product ID mismatch
Date: Tue, 06 Jan 2015 21:40:37 -0500
Message-ID: <54AC9CA5.1080504@ubuntu.com>
References: <54AB3992.5090106@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:41579 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755089AbbAGCkv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Jan 2015 21:40:51 -0500
In-Reply-To: <54AB3992.5090106@ubuntu.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 01/05/2015 08:25 PM, Phillip Susi wrote:
> I'm getting a PMP product ID mismatch error after the two drives in
> my esata dock are attached to the scsi layer and IO fails to them
> and they are then offlined.  When I connect the dock to another
> controller it works fine.  What could cause this?  One thing I
> noticed is that the good controller does not support FIS Based
> Switching, but the bad one does.  Is there a way to disable fbs to
> see if that fixes it?

So I patched the kernel to disable FBS and it works now.  Looks like
maybe this controller needs a quirk?

09:00.0 0106: 1b4b:9172 (rev 11)

aka:

09:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA
6Gb/s Controller (rev 11)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEbBAEBCgAGBQJUrJycAAoJENRVrw2cjl5RcRcH+OOurYXJo8p7EHoECgNwy/rV
eP4cBSP+A3Rz7cDjvhRBl03VTQgZa0wvKCCyDwDoukRMRSWBSOdh7pEKsd+4/Hv6
O2IXtZDFS662QCxCSlpNKcPMUKi2N67jlOgTBtXi6x5hwxZcw7VM6akLieOhv+Jg
qHzGGSOnRfqZS+ir7r50Y15VN2nytg5zk9c061hgwW1+EqsS5aWHdjAelDAQEKk8
Wy0b/JN2zanc/eaKkLn+QWa3LFfzJ3YM5zUEDr2C56Ptkpv20rztLyIiIg5+g02A
CEPG4slyDGt4wYxgB/kWe1Ya8iEL8nx0aYAVIcMAZzjMcHauKsKg8gFnZhGPPw==
=URYD
-----END PGP SIGNATURE-----
