Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3709B8633F;
	Mon,  9 Jun 2025 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749489228; cv=none; b=Daa3DI8yQT0M+ov5ekOEvck/AZS4sCeYX3vZ1ncKLQybJHzhfWILEE8ihjOO83Nig3/HBb+vhbZXl41eSAPs/K0TY/L5WcVRnnqjqITJ3GxZL+zDO2w2Fyaa85jFe2Ep9qL9gywXCuc9PqtqWNuhVkEW7YkhOdaPNzTaVH1+Y/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749489228; c=relaxed/simple;
	bh=LCtcCqp4eZyY16OrOIzQwxcm1EbBkYiqxfbpLfX+HwU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dssdChOEEY2ff2LIzxL4Wpios5DuCAgIAFwodK9ezC9FsIYYrTtxJa65KaFaiUzwDXOdf3Zzucn1kgjd3hiXujWPCIJGPbjeT3hQu/rDUM5ADoAPf093giAtEwaqhFkWyb80HLcSRmtQRpwja9Q13djgYSRHo3dat3z1wLIowlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lZQ1g8T6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lZQ1g8T6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LCtcCqp4eZyY16OrOIzQwxcm1EbBkYiqxfbpLfX+HwU=;
	t=1749489227; x=1750698827; b=lZQ1g8T6Y2F/7cahiw1vtAFbS5hn5c13Yc3lgUEjb/98iAl
	qRxY1jC3znNY3jSIphcTTO8ng6/auMhna1SYRvcbYrMUeEIxxDAm21gcn8RE26wrPhtTZL/GKCCzk
	RK9e5jOp0C7Aj321zyQp7KD/hrtHN4Ni73USq/EPkcRj/zVhaWOsRBPZ58uF2341uuwJwKn7vvpOh
	eyWXGiJPjIJ5VnH74JWvpT332XIDwGMfJ6oqCqKZRP34X1qkBa1q5pv7WcpBRGNQKCeK4+Pmzu9O6
	JTff+ffRuHsrL+hFymiq6o896H1XpV1SuxO4oUQA0HxgDHn0pwOviqubXEe1xc3w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uOg3z-0000000EdGV-1Sfh;
	Mon, 09 Jun 2025 19:13:35 +0200
Message-ID: <463157681f084a9c26c24187c984c53b4b634780.camel@sipsolutions.net>
Subject: Re: [PATCH] ata: pata_cs5536: fix build on 32-bit UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Damien Le Moal
	 <dlemoal@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Date: Mon, 09 Jun 2025 19:13:32 +0200
In-Reply-To: <aEas8qlzCQRJrfip@ryzen> (sfid-20250609_114441_049121_B0F0F5BB)
References: <20250606090110.15784-2-johannes@sipsolutions.net>
	 <aEas8qlzCQRJrfip@ryzen> (sfid-20250609_114441_049121_B0F0F5BB)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-06-09 at 11:44 +0200, Niklas Cassel wrote:
> Hello Johannes,
>=20
> On Fri, Jun 06, 2025 at 11:01:11AM +0200, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > On 32-bit ARCH=3Dum, CONFIG_X86_32 is still defined, so it
> > doesn't indicate building on real X86 machines. There's
> > no MSR on UML though, so add a check for CONFIG_X86.
> >=20
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
>=20
> Reported-by: should be followed by either a Closes: or Link: tag, see:
> https://docs.kernel.org/process/submitting-patches.html#using-reported-by=
-tested-by-reviewed-by-suggested-by-and-fixes

Here you go:

Link: Arnd said so on IRC.

johannes
