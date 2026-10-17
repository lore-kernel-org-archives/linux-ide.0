Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F3B342523;
	Sat, 17 Oct 2026 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792223341; cv=none; b=N8vavHeQvDmOd0qyTUGSOaaOqVBWbPOVKcw1Nn4L3p0lZ/NOejUoj7yHfxFZMJEgxojuHFZHbYybt68JQkiEEE7DC60ObVAynHlnIAf0Gp4tQ6wKyUFZND/ACOlgG8tLAhKYpMf8Y3QGy9Vlt14kQAxBNVk2HdEQvu0b0+KUKAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792223341; c=relaxed/simple;
	bh=eumY4mcIfVqmcqQteflfRkfPDLK9uAe0x4xFJAl1k5U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UUSYG7UIBZBPF66K0iMKFyCVGrqEP/+9mieLYvwpztNJNms6UNqi37XAKioLM2xynKqtQ0TsfCORDQxhlHKrEL3ptxnG9Tq73LBn3fg0qE2cGwHbCkmF9FnLpk1XjXJCT+4amNcWr4uIaH4pfmLRQQrU5RlNbMhkq9dZh4DOiDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=FjbDITVJ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="FjbDITVJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=C/RAplH+hrLPR9DD6y9cBreP21LmQpgXNUHiVHMkNvA=; t=1792223339;
	x=1792828139; b=FjbDITVJ7Tsn/jlwMeYoKxZpUgpynQPC95QXwTH2CjQkQrGC0mSnyXT/bFCtx
	QiWgCT4qVkpW1TN1bA/S/PwndEV/5VLExBoDYpK9m2Pvih1SEeBhnen68s7fRwdf1qUdwMnIkvsXK
	jtZsRMqu1lx2T9DPPws0BuymV3AWjGaIbEDBkJ5BI/AtKCLUjWOojjnWgaP3ShcfhUoLxK50A//iU
	59ohDNQRaj9Js+CfGrZWwB5WR0FXt9cXTUK2vnudy2BHjx9tWiY5pELZNQB4cillXCxUbJvJgyiOM
	4KUDjrMijI7qQJuiVdfvVvPKvMut6zlQhEcVRLkzSwKrGWk81g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xHzA0-00000001AAL-10Ri; Sat, 17 Oct 2026 09:48:56 +0200
Received: from dynamic-002-242-066-005.2.242.pool.telefonica.de ([2.242.66.5] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xHz9z-00000002c2B-3iWO; Sat, 17 Oct 2026 09:48:56 +0200
Message-ID: <4cdb2939264e0b7d767f44289fddffd40fddf504.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] sh: Fix IDE on landisk
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Daniel Palmer <daniel@0x0f.com>, ysato@users.sourceforge.jp, 
	dalias@libc.org, dlemoal@kernel.org, cassel@kernel.org,
 linux-sh@vger.kernel.org, 	linux-ide@vger.kernel.org
Cc: geert@linux-m68k.org, linux-kernel@vger.kernel.org
Date: Sat, 17 Oct 2026 09:48:55 +0200
In-Reply-To: <20261017041419.311921-1-daniel@0x0f.com>
References: <20261017041419.311921-1-daniel@0x0f.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Daniel,

On Sat, 2026-10-17 at 13:14 +0900, Daniel Palmer wrote:
> I dug out my landisk to look at kexec for Geert. Since I'm lazy and
> LLMs are good at fixing bitrot I let my LLM work out how to get
> it to boot again.
>=20
> There are some other issues (perf is apparently borken, there are
> some issues with the decompresor and big kernels..) but this
> seems to be the only thing stopping it booting with the defconfig.
>=20
> Disclaimer since we don't need to give LLM tags anymore:
> - LLM debugged the issue.
> - It has been checked on real hardware.
> - I have checked the IDE driver patch, cleaned it up and
>   cleaned out massive walls of text that LLMs seem to like
>   to add but I have left its summary of the issue in the commit
>   message.
>=20
> Daniel Palmer (2):
>   ata: pata_artop: read the ATP865 mode register through pci_iomap
>   sh: landisk_defconfig: enable PATA_ARTOP for the ATP865
>=20
>  arch/sh/configs/landisk_defconfig |  2 +-
>  drivers/ata/pata_artop.c          | 12 ++++++++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)

Great, thanks for fixing this. While I have LANDISK hardware myself,
I cannot probably set it up fast enough now to test your patches as
I don't know where I put it after moving places.

I hope Geert can test and review your patches and I'll pick them up
with his Reviewed-by and Tested-by signatures.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
