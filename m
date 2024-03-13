Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF315788B
	for <linux-ide@vger.kernel.org>; Wed, 13 Mar 2024 21:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366760; cv=none; b=fasC0M6cdrZtHcMqkCoT5HtPP0vUhsbFrOAEZzgW0HxPrnI+xxpDjLP7wcaVHIAurALIWO8YtaIrCSZjHBy3Ri5FvX9KVi8S1S96ZBcvu4r1R3IKzurElvN7ZJb892jG78hXMsxQ8RcTpyX+WQq51xYuYYAuFhMKIgvA9cT194E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366760; c=relaxed/simple;
	bh=c9LGFnWLhuQOmf6lLSFJ28JD7SN9Cot3e9AWjHR3SGQ=;
	h=From:To:Subject:Cc:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0kRc5MYWBYHAmNdf425izziSDHckmwjO7hTIznhvJ+NLMO5RfO+/ecqX5JZ7Mvsw90D0hAqxgAGilrbM6bU/5a2fcgdIc+0HvzpviP6Q3BqYo+6lX8/+CHpzuRCLj4wrPpvHJh00x78TjujYo+6JbVu/HRYdHHMPgSkdqo1JIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: "Conrad Kostecki" <conikost@gentoo.org>
To: "Hans de Goede" <hdegoede@redhat.com>, Cryptearth <cryptearth@googlemail.com>,
 "Andrey Melnikov" <temnota.am@gmail.com>
Subject: Re[2]: ASMedia ASM1166/ASM1064 port restrictions will break cards with
 port-multipliers
Cc: linux-ide@vger.kernel.org, cassel@kernel.org
Date: Wed, 13 Mar 2024 21:52:31 +0000
Message-Id: <emd39240ba-840a-4d09-a992-7a4b15cd8189@588c6196.com>
In-Reply-To: <066b051d-f092-4ba2-9a26-1c73f3df4252@redhat.com>
References: <CAFDm6W19R3KHDO09c94Uwry9mdG+whAVy=u4Sdpt30A2MK1KPA@mail.gmail.com>
 <CA+PODjqxYcBMc=R792uOava1u0EYZtrWTOw9HvKUBG4=zYbzcg@mail.gmail.com>
 <CAFDm6W2dWu5+Dz2DiWG_9L-VatM6Wj=pMHM2th74Wh144kvqvg@mail.gmail.com>
 <066b051d-f092-4ba2-9a26-1c73f3df4252@redhat.com>
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

Hello folks,

Am 13.03.2024 22:21:51, "Hans de Goede" <hdegoede@redhat.com> schrieb:

>So on this 4 port controller we actually get 4 + 16 ports.
>which isuggests that port multipliers are handled transparently
>inside the controller and that ata15-ata18 are likely the ports
>on a 1:4 multiplier on ata7, ata19-ata22 are the ports on a
>1:4 multiplier on ata8, etc.
>
do you have any idea, if we could make somehow an non-default option to=20
disable such ports?

The initial problem will now persist again. As for example a 16 port x4=20
pcie card (4x ASM1064, each connted to one pcie lane, so only providing=20
16 physical real ports, no SATA PMP) will take about 3-4 minutes to slow=20
down boot, as 128 ports are being detected and waiting to timeout to=20
continue further.


>Conrad as the author of the patch adding the original port limiting for
>the ASM1166, can you submit a patch upstream to drop the port-limiting for
>both the ASM1164 and ASM1166 for now, with the following tags added to thi=
s
>patch:
>
>Fixes: 0077a504e1a4 ("ahci: asm1166: correct count of reported ports")
>Fixes: 9815e3961754 ("ahci: asm1064: correct count of reported ports")
>Cc: stable@vger.kernel.org
>
I've send the patch

Cheers
Conrad
