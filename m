Received: from mail.novencio.pl (mail.novencio.pl [162.19.155.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9244230AADC
	for <linux-ide@vger.kernel.org>; Wed, 19 Nov 2025 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.19.155.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542616; cv=none; b=EbVCQefC/8QLeBeCd4sXNmJM+OOLuvrZDZyEM8CsPlaDpXwJPHwQ+w+fNpljNEp8l2XEmHtj2Vu9xe+RCM+Uje3NB5nnaJpMtiYQO23m/qiqcSHtvVBbzLNsYA0qdq7OI20v1Em6R9AZ1mS3DnSZn42dT/utFmkaMBBccwNyji8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542616; c=relaxed/simple;
	bh=fIh67CnJs35z4uTVN1yEzBZIG1sWJSjOc8Phu/rB5ug=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=ZT4Cpluhi4H96WtSoMu+LHxpO0H7blvmTfC+2pVXf+79FOU5PSH7GAQYoaWtrj1BEWiwE2v5DCwuTlNckxtvs4KibRhV4oJ0AUPdzm8ilt5DQRLve7z9qXMRGDUgsCaXaj4mK+A5YHl9/iRlJm1oNIJnTeFlcVE6/gTLb9Hm7EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=novencio.pl; spf=pass smtp.mailfrom=novencio.pl; dkim=pass (2048-bit key) header.d=novencio.pl header.i=@novencio.pl header.b=gFMUv2D8; arc=none smtp.client-ip=162.19.155.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=novencio.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novencio.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=novencio.pl header.i=@novencio.pl header.b="gFMUv2D8"
Received: by mail.novencio.pl (Postfix, from userid 1002)
	id 0627824D61; Wed, 19 Nov 2025 08:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novencio.pl; s=mail;
	t=1763542613; bh=fIh67CnJs35z4uTVN1yEzBZIG1sWJSjOc8Phu/rB5ug=;
	h=Date:From:To:Subject:From;
	b=gFMUv2D8fWAXVGwCwLWrgskuU+l/q818a3X85p02wk31WLtbbmvVVOnOf40BZp2bh
	 7282kGy5KGtupUGPfsH2XXIxkJYHNWNFjsgLMFimSlGlOkIoTJnR1aL44uDrymDD4C
	 olGmtXLf1K1EcHOtuFbO5MYOCSAETzujUGbWnOt0mkaRdHB8fRsgw8OOYRNSXfskZB
	 VFOnk4/GNDM+JhWjimDlhY+UbpsWdhWBd4m/z/LEeSEli3BLJa7Cl9ck8dVEg7Yeyj
	 XtPYt88ZW2JTv8MiOiwVaIqpCLNmBjc73YPAkxGSgXcfs4BZsqbNJdW+eTdm7mikAd
	 F4M+tXS4mQ/Yw==
Received: by mail.novencio.pl for <linux-ide@vger.kernel.org>; Wed, 19 Nov 2025 08:55:55 GMT
Message-ID: <20251119074742-0.1.5y.z3nc.0.n1a6q4biut@novencio.pl>
Date: Wed, 19 Nov 2025 08:55:55 GMT
From: "Marek Poradecki" <marek.poradecki@novencio.pl>
To: <linux-ide@vger.kernel.org>
Subject: =?UTF-8?Q?Wiadomo=C5=9B=C4=87_z_ksi=C4=99gowo=C5=9Bci?=
X-Mailer: mail.novencio.pl
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

pomagamy przedsi=C4=99biorcom wprowadzi=C4=87 model wymiany walut, kt=C3=B3=
ry minimalizuje wahania koszt=C3=B3w przy rozliczeniach mi=C4=99dzynarodo=
wych.

Kiedyv mo=C5=BCemy um=C3=B3wi=C4=87 si=C4=99 na 15-minutow=C4=85 rozmow=C4=
=99, aby zaprezentowa=C4=87, jak taki model m=C3=B3g=C5=82by dzia=C5=82a=C4=
=87 w Pa=C5=84stwa firmie - z gwarancj=C4=85 indywidualnych kurs=C3=B3w i=
 pe=C5=82nym uproszczeniem p=C5=82atno=C5=9Bci? Prosz=C4=99 o propozycj=C4=
=99 dogodnego terminu.


Pozdrawiam
Marek Poradecki
