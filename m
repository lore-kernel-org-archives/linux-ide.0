Received: from out198-186.us.a.mail.aliyun.com (out198-186.us.a.mail.aliyun.com [47.90.198.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6F13195EF
	for <linux-ide@vger.kernel.org>; Thu, 23 Apr 2026 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954430; cv=none; b=ueOz53DrfP04RG7Y7iQKDYG85ELXLPlXni327lO61QWVz+wuP90HsSGD9JyP4iemtuzY4qlZZDEwwOXbwVeoEOH9S2JSNfrwLU9DnBQaXJvoIuBVCQSqVshjn49VIXv9nGlXeivRJpEnDAD3nEok3f6BEo/YqBZVZfEBfawnQGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954430; c=relaxed/simple;
	bh=+AuNXhrm+yR59uV3tLBVtl0UJqxuc3yGZCoKlZoXWuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eakz67VLFuex9blryI3dRiTRjDMdIoHTxOhV7qMAg/ReS6Mv3GeVekPGiEpBQQZN5W841MylnGIWqsRrz18/fc4S6wzG9g7Wm6xx49hkGc0ODCD0oZF4dem17GzMoV5sUobV4ypU8m+7fxe5iMBpVU341D89uM0WIyBiio3rnJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alancui.cc; spf=pass smtp.mailfrom=alancui.cc; dkim=pass (2048-bit key) header.d=alancui.cc header.i=@alancui.cc header.b=Imso6jV6; arc=none smtp.client-ip=47.90.198.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alancui.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alancui.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alancui.cc header.i=@alancui.cc header.b="Imso6jV6"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1776954417; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=+AuNXhrm+yR59uV3tLBVtl0UJqxuc3yGZCoKlZoXWuU=;
	b=Imso6jV69Ttu/Q5GXAx309J8Oa7QlptlamvEJRij1MaihIAXXsQYZjfw3fOuSH2c1bACFawwOk4gdqbYoCf86btgleoOtq5OPybHVISlfccQX/IXZg55/rVzqZcw+2raXaMFKxfUHpzTYfzfd92mSU181FAUd8JZiU0QgPLm3Qr1xJt0LGLlj6ZfmC9FsbfknkVb3GFDcaONHzGMOXF2jkay1sknnIX8aNUPSakA7R4VaiRQBm1UGYhLsaPsdNlQqix7xgtRFRh4O3AFxh7Es/O217T81ZPaQkYQ+KcfqjcpBb0Jjc0Xe71t493zFaq0eN6cSEh3rplA1DD2QJ8Mlg==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07979926|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.127356-0.0323431-0.840301;FP=6123644231787261522|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=me@alancui.cc;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.hIkE77g_1776954416;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.hIkE77g_1776954416 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 23 Apr 2026 22:26:56 +0800
From: AlanCui4080 <me@alancui.cc>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject:
 Re: Default IDENTIFY timeout is 5000ms which is too short for enterprise
 disks
Date: Thu, 23 Apr 2026 22:26:55 +0800
Message-ID: <p9jLdz6RRGKjgu3OloMgWw@alancui.cc>
In-Reply-To: <aen_SQ-7fPfdAylr@ryzen>
References:
 <14015677.uLZWGnKmhe@alanarchdesktop> <f8dAJyMVQ4yJA5_7X9Jscw@alancui.cc>
 <aen_SQ-7fPfdAylr@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Thank you for your really really detailed response. And i was surprised by =
your
reply, hopefully that doesn't cost your time too much.

On Thursday, 23 April 2026 19:15=EF=BC=8Cyou wrote=EF=BC=9A
> My best guess is that it is a HDD firmware bug where the drive sometimes
> hangs after a STANDBY + COMRESET + IDENTIFY. Or claims to be ready before
> it is actually ready.
>=20
> It could of course also be a bug in e.g. ata_wait_ready(), and we are sen=
ding
> the IDENTIFY command too quickly after the COMRESET, but if that was the =
case,
> I think we would have seen way more bug reports from different vendors by=
 now.
>=20

That's the same as what i guessed, the drive's firmware didn't implement th=
e ATA
correctly, they either ignored the command or just don't want to reply. The=
 vendor
do really not instrest about specification, they do even break the APM and =
changed
the meaning of standard SMART value.

I'm not a native speaker so the actually question that i want to ask is that
will kernel do quirk for those drives so let it just don't fail to avoid co=
sting
extra 5 seconds and producing annoying erros on console?

> >=20
> > > So I think the question is, at this point, can you read from the driv=
e?
> > >=20
> > > E.g.:
> > > # dd if=3D/dev/sda of=3D/dev/null iflag=3Ddirect bs=3D4K count=3D1
> >=20
> > I will be blocked out of the shell for 5 secs unless the IDENTIFY succe=
ed.
>=20
> But as soon as you get a shell after a system resume, the above command
> succeeds, right?

Yes, that's correct.

>=20
> My suggestion is to look at the zpool code to see how long it waits to fi=
nds
> all devices after a system resume before it kicks devices off the RAID ar=
ray.
>=20
> My initial feeling is that if your device is ready after 5 seconds after a
> system resume, then the timeout value for zpool to kick off a device must=
 be
> very low.

I do believe that's about zpool, i migrated it into btrfs RAID now, it work=
s very
well. And if you want to know, the timeout of TXG to commit is 5000ms also.

Alan



