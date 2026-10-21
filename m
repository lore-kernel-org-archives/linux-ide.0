Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572750;
	b=IR0VSwZ8a4X+AutQH+Ia36FVOP61nL60G9gsx/iwY/YrYjUnLhOZ8GyVui16eiBefkhD
	 RttsXNkXOYQySz1fk8CCzg/vYqBhfanB63K7dD3UTqwRsA8cEV9DophsO9YfcoAq12LEG
	 YY4EhNbcJ4nkkzKcBvjV2KqbREmZiu+z8WBEFvY2i0WOmaHix9er3Ug9/bJ7b1UzBccmM
	 4L3CFr5o3orxnoMD+L+vsHLyPJDUnt9G0oiPv5FVQZXCb4i9v5J92w2G16QZ7AVxkmGcY
	 Z+zTzBnBiDoWtcBwbtyPCCjxkFa1ShR3OXgj6QPmJEgEdx7096RbQ0eIFQWnu3o2crw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572750;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=nLAv4znXqp7J4jKgEvw3NbURy0oURMFIRBJwXlCWHgc=;
	b=EcP8j2vtdfB2n6nnO10Rbc3LduGMo8qPvKyGfo5tSgeswEe4Vq53SY1YG4SP5hzeGo24
	 9KrklkQEvLF429vDyY6HpB9+GUe8oAnqbM9u1NaqqWy3MCahw2ea1PKLjtwgm9vxcF/vW
	 uCf8OclvGjeaC9pw3Jw2ubrOrUKuYdS5CmgrwWqls7sr8NNUyTiWOa1by3fhXoFpOyAvT
	 uHRvUvCWfy1ij4Xh9Ajf7YcNACPSu/AF0HBwuL9EEfmlYwhFJBpKkIOLk4S1506+zo7gT
	 GeYoRORjvSXUO6mXOfGwhVQNUeqYaqffo/f1pajhjw/Msmp1GjZiPgqRI2yvuigtjWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=N36hx7Ov;
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318EE606A320;
	Wed, 21 Oct 2026 08:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 318EE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=N36hx7Ov
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=nLAv4znXqp7J4jKgEvw3NbURy0oURMFIRBJwXlCWHgc=; t=1792572748;
	x=1793177548; b=N36hx7OvBDwonjMUw+vQZGNWUgwXxpoDmz5vIeTFgVY61KB2mL3OlSk699E5/
	GTPxSqnHeCf5aOBFoZZYZAAaxjTaeW92rEBbnnajK1J7qyUaIA5NFkNK+XqCVlnrQ7nIyQfk3S669
	phI6yzfWBf6EZgYFnTLbDDfjIe79qMyzJoI4yCyU6YxtPfIqP1s+kh7rDGvy1cw0S5BloHNpBdGqG
	OriiBxzTO0jFgk8QpL6iz8mgfc/JZqCV/sHdrwIAKurnNG1itu+sHIBeYDWbHSRFS336nq4cvkOyL
	+FAXlkmRfE4YJ84dZ53HxeS5yikbq0MMJBYi9ICQgryImF4xvQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xJS3c-00000001Fqm-0sQr; Wed, 21 Oct 2026 10:52:24 +0200
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xJS3b-00000003HQO-3yZw; Wed, 21 Oct 2026 10:52:24 +0200
Message-ID: <0c70afc8a119504aa5c2d22361f613547b2750bc.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] sh: Fix IDE on landisk
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Daniel Palmer <daniel@0x0f.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>
Cc: dalias@libc.org, dlemoal@kernel.org, cassel@kernel.org, 
	linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yoshinori Sato <yoshinori.sato@nifty.com>, 
	fuchsfl@gmail.com
Date: Wed, 21 Oct 2026 10:52:23 +0200
In-Reply-To: <CAFr9PXn4henL=rQ3n73H7Mjwd7v6XX6Jt63h=Sywu-boOPggKw@mail.gmail.com>
References: <20261017041419.311921-1-daniel@0x0f.com>
	 <4cdb2939264e0b7d767f44289fddffd40fddf504.camel@physik.fu-berlin.de>
	 <CAMuHMdXmZash+8PmfSVrT=Wwob-mkq0x4umyRgX2-yikV9kaVA@mail.gmail.com>
	 <CAFr9PXn4henL=rQ3n73H7Mjwd7v6XX6Jt63h=Sywu-boOPggKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Daniel,

On Mon, 2026-10-19 at 08:04 +0900, Daniel Palmer wrote:
> Hi Geert,
>=20
> On Sun, 18 Oct 2026 at 23:48, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
> > > I hope Geert can test and review your patches and I'll pick them up
> > > with his Reviewed-by and Tested-by signatures.
> >=20
> > Sorry, I must have different hardware, as mine doesn't have an
> > ATP865 PCI device:
> >=20
> >     # lspci
> >     00:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> > RTL-8139/8139C/8139C+ (rev 20)
> >     00:02.0 USB Controller: NEC Corporation USB (rev 43)
> >     00:02.1 USB Controller: NEC Corporation USB (rev 43)
> >     00:02.2 USB Controller: NEC Corporation USB 2.0 (rev 04)
> >=20
> > My CF rootfs uses pata_platform, which is enabled in my working .config=
.
> > landisk_defconfig lacks CONFIG_PATA_PLATFORM=3Dy, so it hangs during
> > boot. After enabling that, the boot gets further, but it still hangs:
>=20
> I guess you have something like the USL-5P that uses the SH's onboard
> CF interface.
> Since Florian has confirmed their hardware has the PCI IDE controller
> like mine and reviewed the change I think we're good.

Is disabling CONFIG_PATA_ATP867X still correct or would that brick the
boot on USL-5P? I guess you are using any of the HDL-XXXU devices [1],
aren't you?

I actually own both as I did quite a SuperH shopping spree in Japan some
ten years ago.

Adrian

> [1] https://www.iodata.jp/product/nas/personal/hdl-u/

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
