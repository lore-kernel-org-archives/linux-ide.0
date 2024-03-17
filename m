Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F285221
	for <linux-ide@vger.kernel.org>; Sun, 17 Mar 2024 01:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710639310; cv=none; b=TZXuqhpRoDo6ehTdR9yOENGe4ZNLoBHv/zjdb0/vDYwcbbvvOpc695xS9m4388jyjPWHI0KsZuo4Sa0zCnoQ6G5Zv66q8qMlfbXxfXDl18/l/btknuiNNv41YNaMXUMbfwBFqPL0FopsTb/96FRAW+6KYCte6g+1mdbBO/qR+FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710639310; c=relaxed/simple;
	bh=/IkTJJ788751RF9XCGSc1fxJ0Mxm2r6cR7dhxSiBh2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvpHw8unN2WOJLAos2bv2G8kBwhGGwj5yVgZBzM5qdMZXz0MgN3zFpNye4OeodjxHueXdHmy/s1RXKGTlJ8XuytJszz/B9XbwOdm888SHLqt5KsdGc5nUC/QHtx1hg32I2GBdgLqiRQEhtPRAJgegAZyzh/bEpAqyFSxhbvCcjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LDvDCKcA; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LDvDCKcA"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-430a8592d38so16697321cf.0
        for <linux-ide@vger.kernel.org>; Sat, 16 Mar 2024 18:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710639307; x=1711244107; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8tKPGXVDbIO5JZQ6owbVtNl3e9nJCOWbo6OL1/p52B8=;
        b=LDvDCKcAn2sc21u+0GTsqcrc0QhLv1w4nzE+EAHfy5sQgIGXlF4s9VTsPqWilqU4pV
         t2tsZdB5TNXqv8wPVvvCZ+D9ObRoLVLWc1zkVLp2mqpdM7/cLPJfAqzcaYR9FE9r6PHg
         Cmi4F56fJ7comICcZCpr7VJvfWfJwNO73nerkQlJzlIiYKc7GtB9HXER5b/2QguuXyzF
         +8CIHj1HP6dOxOtqfhWvhSAh8uuNsLdlrOFDO+dO4ibK3gUtAdeUzK/H0qKpHGxzasxz
         amymB5xFV2dK/aJB0+ssf94x//QnvW5U16g6LsAch8UucKdtrGIgllWZzd1saN2sCnlB
         nNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710639307; x=1711244107;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tKPGXVDbIO5JZQ6owbVtNl3e9nJCOWbo6OL1/p52B8=;
        b=xIlBdqwc4Eu1LrzXBQofFwRv5xjliZS3Fh9qGMXFDWZQ9wRFeZQtTFGnzJKXTp5z3o
         /86WZsj9PN09H12FaImvz9vEBnJfvnZ+CHQiubX6ZFeRTUNZyO4CRg2DllpjX3ht931P
         wQUIepIhk2jMPqeHC4mpL8fGQrKW3I6Vf8TlhdjhdXPsDAoxKB7Vn7+dPYgnbbPRKaya
         YHuGp3ktPzVP5aIdC+pczDAsWS/QI0pKxinBt1d5JDHCYplDdyb671hprDAt5IufaV3u
         rGY4S5xEOWG5k89uwZcEm3Z5IyAJwNh3lMHwerMnuS3eRSIgr7HPiiLNFmjzSEea+NM2
         HYrA==
X-Forwarded-Encrypted: i=1; AJvYcCVXLg4aB+tEnUX8LPdT1mXXACxypBvRlOlfNLqsBfnaB+91+kbGUnhbtJ7LZmB0dywfl2zvuYeln9lJ42q+vppOLrGn+B1XrfYU
X-Gm-Message-State: AOJu0YwqLeJDoCLMDBODakKCtVHAvfSlnE3c+s9ypxtKr9UURJ2pCadJ
	qJUJ6kQEtI9xpYBlm8aKOsIphsRQHV/IGJVdH72CYTghJ+eM6DXhsP/dY++lmbb8I5h+5gGbkqX
	4EB9YygVK8mlHP9yOlQI6lZNA92I=
X-Google-Smtp-Source: AGHT+IE2ShkOAvpeiRaG2BwIzjejpoJrj6NU8h6fccuC5hraEr/yX9vf2pCax5tp7GCpGNcFbiuJlu1mz/u2UDaceZQ=
X-Received: by 2002:a05:622a:15d5:b0:430:9744:2253 with SMTP id
 d21-20020a05622a15d500b0043097442253mr9797044qty.13.1710639307202; Sat, 16
 Mar 2024 18:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFDm6W19R3KHDO09c94Uwry9mdG+whAVy=u4Sdpt30A2MK1KPA@mail.gmail.com>
 <CA+PODjqxYcBMc=R792uOava1u0EYZtrWTOw9HvKUBG4=zYbzcg@mail.gmail.com>
 <CAFDm6W2dWu5+Dz2DiWG_9L-VatM6Wj=pMHM2th74Wh144kvqvg@mail.gmail.com>
 <066b051d-f092-4ba2-9a26-1c73f3df4252@redhat.com> <emd39240ba-840a-4d09-a992-7a4b15cd8189@588c6196.com>
 <e09f1db6-2720-4fbc-ac64-2be498be8e4d@redhat.com> <yje3amxvq6is5padpzd27krlatyn5j7qxfwejmbankkuq3xjt7@5zqxlw2xyuyz>
In-Reply-To: <yje3amxvq6is5padpzd27krlatyn5j7qxfwejmbankkuq3xjt7@5zqxlw2xyuyz>
From: Cryptearth <cryptearth@googlemail.com>
Date: Sun, 17 Mar 2024 02:34:56 +0100
Message-ID: <CAFDm6W0uuu7y-6=P=_ZSEnti-Dx2Q8j2_n74wMra9qqaeJKzTw@mail.gmail.com>
Subject: Re: ASMedia ASM1166/ASM1064 port restrictions will break cards with port-multipliers
To: "Andrey Jr. Melnikov" <temnota.am@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Conrad Kostecki <conikost@gentoo.org>, linux-ide@vger.kernel.org, 
	cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi there,

this is just a quick follow up as Arch just released the 6.8.1 kernel.
I tested it and as it includes the change it didn't work out of the
box.
I ended up to rebuild both the kernel and ZFS from source (as I
figured out one can not use the standard zfs package built for the
standard kernel with a self-compiled package - and I don't want to use
DKMS). I added the simplest fix I could come up with and commented out
the entire ASMedia block. And although it took me several hours
(roughly 3h) now it all works without issues.

> Non-standard vendor extensions should be enabled with user attention, so - invert logic and param name:
>
>        if (!enable_transparent_pmp_ports && pdev->vendor == PCI_VENDOR_ID_ASMEDIA) {
>                  switch (pdev->device) {
>                  case 0x1166:
>                          dev_info(&pdev->dev, "Limiting ASM1166 to its six physical ports\n");
>                          hpriv->saved_port_map = 0x3f;
>                          break;

I agree with Andrey on this one: As the number of users like me are
likely not that much the override should work like he mentioned:
default to limit the port count with the override to not limit them.
Nice solution - would love to see that get merged soon into upstream
as compile the kernel and zfs from source just takes quite a long
time.

Have a nice weekend everyone.

Greetings from Germany

Matt
