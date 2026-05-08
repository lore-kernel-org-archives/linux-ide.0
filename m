Received: from out198-153.us.a.mail.aliyun.com (out198-153.us.a.mail.aliyun.com [47.90.198.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755963D5228
	for <linux-ide@vger.kernel.org>; Fri,  8 May 2026 21:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778275183; cv=none; b=OLZ85NRlsqRx4h2zr96JmbC9Qdkim/HSy466LsIdaNz3Z5PG+xbWBm1TyZGaoPTjgJMtVw4GzGQ4g+TP2fdnV012GvYewrM97Wv3dIPV9Qyr6j7mrwt7i5vmbPetGDXkIf5xJuZyLNrnAAxyAY3ZvfFjWxQ9a8pQyDH14NCy1v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778275183; c=relaxed/simple;
	bh=7piiIsRXT8JmHb8nMCvH+6M/Q7awjo3D+ON4irlLqZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jvRdRoFmcG8mK0pHFP2CaP0l0SiYwm1WW/NoQIf5m3L5lRRVRdYvrQXqoUcJbV0WsBn9IKZqeYWu+cp6AlDLPmh7xyMWNOGPujISqX9coBMB5Qv8tHqtVvP81spqn4seGOmr8qhH6JaVSj3LJz+a6giSFNdHpgo2MkbSuuN8qv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alancui.cc; spf=pass smtp.mailfrom=alancui.cc; dkim=pass (2048-bit key) header.d=alancui.cc header.i=@alancui.cc header.b=Cilx/pfd; arc=none smtp.client-ip=47.90.198.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alancui.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alancui.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alancui.cc header.i=@alancui.cc header.b="Cilx/pfd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1778275170; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=7piiIsRXT8JmHb8nMCvH+6M/Q7awjo3D+ON4irlLqZY=;
	b=Cilx/pfdxZTkBrpfQ6KJ6NzxVmfyrK7nmsgxeGrWpDtV5NAJrXkMaDItlIMLoUQL6hRgsamwG+uBMsSt4A+RgkvGlBNVIW+tlZ8LuNFOxZHFZqRaMo9TDf7OhUKFb+Ga6ueFfN4i8lDz3KCQ+hB4nlXJ3PYjwlGWzr5acAPdHgc6NJ8HMZNIwdzNOVLcRreUZv9PGXYbbnUxHuRhxxM/i8NajQku8ihB3XXCCa53QIm2XfmvQYqXSitUxYLi9aPVV0V95hPi2VVRY7lxd+cLB9dsVgtZFbBF6eFcb0jnby/9dq4GPzy5HrNdyN2/WwnwwD4MucVSjb+Y7HytDhgp3Q==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09131266|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.020264-0.000656191-0.97908;FP=13103378969437989735|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=me@alancui.cc;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.hSovvfK_1778273315;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.hSovvfK_1778273315 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 09 May 2026 04:48:36 +0800
From: AlanCui4080 <me@alancui.cc>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject:
 Re: Default IDENTIFY timeout is 5000ms which is too short for enterprise
 disks
Date: Sat, 09 May 2026 04:48:35 +0800
Message-ID: <DlZIztR2R7G4sZHRUgM9CA@alancui.cc>
In-Reply-To: <aepGCyy5uXXxw6jT@ryzen>
References:
 <14015677.uLZWGnKmhe@alanarchdesktop> <p9jLdz6RRGKjgu3OloMgWw@alancui.cc>
 <aepGCyy5uXXxw6jT@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Cassel,

On Friday, 24 April 2026 00:17=EF=BC=8Cyou wrote=EF=BC=9A

> So as far as I can tell, even increasing the timeout does not solve the
> problem in all cases.
>=20
> So, right now, I can't even think of a way to quirk the device so that it
> works reliably.

=46YI, After I replaced the motherboard from B550 to X570, this problem is
completely gone. So It seems that's a corner case with this drive and my
south bridge.

The only message produced by kernel ata driver is:

May 09 04:42:37 AlanArchDesktop kernel: ata6: link is slow to respond, plea=
se be patient (ready=3D0)
May 09 04:42:37 AlanArchDesktop kernel: ata2: link is slow to respond, plea=
se be patient (ready=3D0)

Looks pretty good to me :)

Due to the B550 motherboard is taken down from my computer, I'm going
to do more tests on ata driver once I got my new CPU.

Alan.


