Received: from out28-65.mail.aliyun.com (out28-65.mail.aliyun.com [115.124.28.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7E63E5564
	for <linux-ide@vger.kernel.org>; Thu, 23 Apr 2026 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776936227; cv=none; b=PlnF2nA/Cpc44UWaovCcOAuW6T9qB8wE+NJBkzyuCnl+IK3yAfo5IF3eCHFgTSDhbcuSLgCdxU/v28erFjYIRSeGtxzhTdDKhrtyqNjf6S5DI3mmUio8LlwC8eeEOsFkujoPwPbFWlDHNceMnRmAsa+f86/FiOSMEpSVI1fnJzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776936227; c=relaxed/simple;
	bh=WPwiFc776qnX9G2zEUaL/RBl3KB88G7/FHizAE8Lsv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uNvfO8k5dz1mMpwtIzjDL8aCSSfMYAa/uuuQK4nIly50SE7/aG3WAtpiahMhl7KkIcGn2SPhJNwfAMp/S4pMO06BoKtVIHO8MDvQMjKdwBB+x+C1FbeTjm/dZce2mObZT/F7rLIq3dCFxyugAl8CxJncmk+JJqxmwLR1WB/UpgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alancui.cc; spf=pass smtp.mailfrom=alancui.cc; dkim=pass (2048-bit key) header.d=alancui.cc header.i=@alancui.cc header.b=tpoPs6o4; arc=none smtp.client-ip=115.124.28.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alancui.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alancui.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alancui.cc header.i=@alancui.cc header.b="tpoPs6o4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1776936224; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=WPwiFc776qnX9G2zEUaL/RBl3KB88G7/FHizAE8Lsv0=;
	b=tpoPs6o4s784o92QLgQQS7EkoqM+rntD2xs9FyZqYtq6g1qh/r/qijkQonOhAUZH1mg7N69emFQzurSPru71jasMIMPWhOtHzSpXMrrsT6KVwrX3W/5thTkZI6C5YBzs7oHL0R+fe0mFnCqJP7m/8TXZ6pMxfx0CAQLuvFn0+wHdGgtBsG8YEjwIIM2Hv2VqzCH9L2XGWZKeCAePCKzeiOFHHyFNqfSiN67PelhaLhYyZweCKtpVtNp5o+jplmm3iAAcClhqRPptGsy3UxFEoLRI+LU1tWoo+V/8VQzpVUJuS29rCQfEDu72UkWYm9XuQdsVhUe8+PVaNrnrB1AHXg==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0802791|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0483249-0.000358162-0.951317;FP=6516163024916397306|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023018039;MF=me@alancui.cc;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.hIXsb3k_1776935904;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.hIXsb3k_1776935904 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 23 Apr 2026 17:18:25 +0800
From: AlanCui4080 <me@alancui.cc>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject:
 Re: Default IDENTIFY timeout is 5000ms which is too short for enterprise
 disks
Date: Thu, 23 Apr 2026 17:18:24 +0800
Message-ID: <f8dAJyMVQ4yJA5_7X9Jscw@alancui.cc>
In-Reply-To: <aeZUCa5wumWXi_yN@ryzen>
References:
 <14015677.uLZWGnKmhe@alanarchdesktop> <23071769.EfDdHjke4D@alanarchdesktop>
 <aeZUCa5wumWXi_yN@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 21 April 2026 00:27=EF=BC=8Cyou wrote=EF=BC=9A
> From this it seems that it is simply the first IDENTIFY that times out.
> On the second try, it seems that the IDENTIFY passes, otherwise we would
> have seen more "revalidation failed (errno=3D-5)" prints for the same dri=
ve.
>=20
> So, from this log alone, I don't see any problem. We will try to do IDENT=
IFY
> up to three times, so just a single IDENTIFY failing should not be a prob=
lem.

So at your opinion, the error is caused by a hardware failure but not kerne=
l,=20
so we should not add any quirk to relax or solve the problem, is that corre=
ct?
(I just want to confirm that how kernel will deal with this error)

> So I think the question is, at this point, can you read from the drive?
>=20
> E.g.:
> # dd if=3D/dev/sda of=3D/dev/null iflag=3Ddirect bs=3D4K count=3D1

I will be blocked out of the shell for 5 secs unless the IDENTIFY succeed.

>=20
> If you can read from the device, then this seem like a problem with zpool
> kicking the device off the RAID array (perhaps because it is taking longer
> than some zpool defined timeout value?), rather than a libata problem.

But after the link re-established, the drive works normally.

Alan


