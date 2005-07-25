From: Stefan Smietanowski <stesmi@stesmi.com>
Subject: Re: read vs write
Date: Mon, 25 Jul 2005 12:32:33 +0200
Message-ID: <42E4BFC1.7070905@stesmi.com>
References: <d15adc960507250314ec47755@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxfep01.bredband.com ([195.54.107.70]:11234 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S261185AbVGYK0W (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Jul 2005 06:26:22 -0400
In-Reply-To: <d15adc960507250314ec47755@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Saswat Praharaj <saswat@gmail.com>
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Saswat.

> Moreover, I am wondering if I could achieve the 100Mbps read speed as
> claimed by different vendors.For me , It should ideally be 100 Mbps as
> I am using a 80 conductor cable and UDMA 5.Why then I am getting 58
> Mbps max . .

If you mean Mbps then you are already above it. 100Mbps = 12.5MB/s
give or take and both speeds are above that.
I guess you probably mean 100MB/s though and that is only what
the cable can take.

If you take a T-ford onto the highway - can you go 130Km/h in it?

No, the road is rated at 130Km/s but the car can't go that fast.

Same here, the standard says you can transfer 100MB/s over the cable
but the disk isn't fast enough to be able to transfer that fast.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFC5L/BBrn2kJu9P78RAkXKAJ4vc/xQ0Z8mA1ddo79+wC6NCFe5VACgl+j+
ceP+as8dx0uZs2W6xaYiMVc=
=Of1/
-----END PGP SIGNATURE-----
