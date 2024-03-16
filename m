Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E65C1879
	for <linux-ide@vger.kernel.org>; Sat, 16 Mar 2024 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710589549; cv=none; b=n9LVjeiUaEe2O10/Ts7RZBx5EUjSe9vdgkIyURVDOxWNfwjnTN2w82idy9rllZbGFUZkKaHo8oh/HSUwy8ki7jTKDgs1vzfTcm+8FlxO2zboE1Qvjyt+p7TycpSivOoipFNJcIRMtbxQH/uFyDoW73C2bkN4MRslvDoj3nEIPYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710589549; c=relaxed/simple;
	bh=Re1dY9VZM1ytqBAUVmHv+H6Aq3DfDd6eZRpncKXn7AI=;
	h=From:To:Subject:Cc:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMnHkNUTyofcWirPQQyqlq5JbJf1CRVlWwDNLZiRuj6js61K76BsTAdALYAXdMQVqTn4Fv6K1kq1Fxuc3o411Uz+7Zvx0VDw2eps2GxhmyM2yOli2Ma7n1wxQDLq3n8s3TR+Ar+Fo85Xe8uyUos6zIJthyd0XSGsqUl0KvuiNys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: "Conrad Kostecki" <conikost@gentoo.org>
To: Cryptearth <cryptearth@googlemail.com>, "Hans de Goede" <hdegoede@redhat.com>
Subject: Re[2]: ASMedia ASM1166/ASM1064 port restrictions will break cards with
 port-multipliers
Cc: "Niklas Cassel" <cassel@kernel.org>, "Andrey Melnikov" <temnota.am@gmail.com>,
 linux-ide@vger.kernel.org
Date: Sat, 16 Mar 2024 11:45:41 +0000
Message-Id: <em260ca711-2dd7-490f-b401-eeac6c172e98@c8aae956.com>
In-Reply-To: <CAFDm6W0zP=Yw_OA9_qJ17Np=px=sR69m9hGF3D96A9gyS5PLTQ@mail.gmail.com>
References: <CAFDm6W19R3KHDO09c94Uwry9mdG+whAVy=u4Sdpt30A2MK1KPA@mail.gmail.com>
 <CA+PODjqxYcBMc=R792uOava1u0EYZtrWTOw9HvKUBG4=zYbzcg@mail.gmail.com>
 <CAFDm6W2dWu5+Dz2DiWG_9L-VatM6Wj=pMHM2th74Wh144kvqvg@mail.gmail.com>
 <ZfMerqAmWoyu66/5@x1-carbon> <2e471c2b-8432-4501-b093-4295529a4d38@redhat.com>
 <CAFDm6W0zP=Yw_OA9_qJ17Np=px=sR69m9hGF3D96A9gyS5PLTQ@mail.gmail.com>
Reply-To: "Conrad Kostecki" <conikost@gentoo.org>
User-Agent: eM_Client/9.2.2230.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi!

Am 16.03.2024 12:33:57, "Cryptearth" <cryptearth@googlemail.com>=20
schrieb:

>The subsystem IDs don't lead to anywhere - from a quick google search
>it seems they use it on any of the cards no matter if it's a ASM1064
>or ASM1166. So, using it as a filter likely doesn't cut it for
>something like auto-detection. A manual override is likely the best
>way to go - however it ends up implemented.
I can confirm this. Such cards seems still always to use original vendor=20
and device id from ASMedia.
At least all my cards I had hands on it showed that.


>As these cards are so common and in such wide varieties my guss is
>that there's some generic firmware which was written once and in a way
>to work on all of these cards - and hence just reports up to 32 ports.
>It could be that it was done in a way "to just work with the least
>amount of effort" and hence can cause side effects.
I do also suspect this, that there is some default firmware for this.=20
Unfortunately, ASMedia won't give any firmware to end users, only=20
vendors.


>I still hassle with the initial report: I couldn't tell any time lost
>or gained. For me the probe of an unused port only takes roughly 0.3
>seconds. Even multiplying by 128 I only get about 40 seconds. How
>would someone end up with 3-4 minutes? On the other hand: When a drive
>is connected and has to be initialized this does take more time - for
>me roughly 1 second per drive. But even then a jbod with 128 drives
>would take only 2 minutes or so. Is there something I just don't get
>because I don't know or don't understand properly?
>
It may be the difference, that my ASM1064 card is _not_ using any port=20
multipliers.
It's a Delock 90073 16 port sata controller. It contains 4x ASM1064,=20
each connected to one PCIe lane.
So hardware PCIe interface is x4.

Even, when 16 drives are connected, I can clearly see, that's its=20
waiting on other sata ports for answer and reports after some time a=20
timeout. It's not the hard drives, which are "slow". Its slow on unused=20
ports and waits for timeout. Since 4 ASM1064 are present, a total of 128=20
ports are reported. Maybe your connected port multiplier JMB575 causes,=20
that those timeout are not happening then?

Conrad
