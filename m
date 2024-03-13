Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FE010A24
	for <linux-ide@vger.kernel.org>; Wed, 13 Mar 2024 06:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710311775; cv=none; b=GbpgtaOHj25Bi4dOhAkMNZ1gkImd+EziFYAEzpYZCtTKEGHBy23LTQ/S8vEj5xgKy9AnnynOr5zHEPLFVXtq5xT3V3Q2tsTRgvYwg+lKe0j5Mc/Nr4a25rvoX7Hf7zT896rPdLE/fl/wqqX3rnrYIOWI/diNQBMoAOmLsKZckzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710311775; c=relaxed/simple;
	bh=7TraIeRGwYjlb1JcA69hPlQCa06Q14YJMUIV5DJ6mlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZpXd6FmJd/fPUorHt5Qdl55vOrFUzYU9aLPcA4NKK//i+Y2JRZeB4YpQa6sfJY5cWD8po8rhE2x3MguOO2msFJEQXhwmjuANx7I2xgeKAIft6jjK3cT7a/mHs29ZVjFKmG0SjB4avmXecZ3bpw6ebR5k93SKo0CAbiqnGF6cZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ya9qDZn+; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya9qDZn+"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78850ab4075so32305185a.1
        for <linux-ide@vger.kernel.org>; Tue, 12 Mar 2024 23:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710311773; x=1710916573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TraIeRGwYjlb1JcA69hPlQCa06Q14YJMUIV5DJ6mlY=;
        b=Ya9qDZn+vYHGnAxvctQNQ34c+IYJq8n2GcpflT2Om2HntfbGhiQ7RdW5DFTSMi8CxG
         slFdwBM5++8k/1lCzXMLWYVZf/TTAai4tpD27QgYEemVs2rWy3jv4FaA5K/qjEZOuewD
         OV4PHHHvtG/3yUZ2rEwjVFoNQRAPkx3gj8KW2xRa3xZFl0qHq4J/in+f3I6kK7Qzahc7
         mA4SQ/cCKvUYuyNZErOJPNW8oROBHNl6iFzNwpQM7qa2l3snZ5O4egNIpLBH+O9O5nSQ
         qrkrAUs5yVzKVF6/E0HCEg+bh53aCnqmdRhaFInQ45kyKhXccQFCkkPWKlUCsy/jFJOP
         2kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710311773; x=1710916573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TraIeRGwYjlb1JcA69hPlQCa06Q14YJMUIV5DJ6mlY=;
        b=rWM2wqfKqVZcpWUHKgxf0UdErcvZsXfyt4OJbnY5+PX0ylncoJBBT/cUxhrCsFEywI
         wSzGFA1xRbbrj4d2i+fLKWm8Tu6Co5nN7XpH+ENezDPVlAbimJnnHz9WX0yCJdr9GvAL
         Z60cBIwnl556tnTVVeESJh+1tSVCIKDGgWARh3cdzK0s6WHt84XNUM4vzW+kt7f3aXvz
         +0XoRmEyXU6BIDKUknimTafCg2grzzrMLEbljaZXnFRjNinuWr0bjYFkp2Sa43dgqknx
         IbS7siwDbgiK7/e/nS8GVD2pP8CiLZMZ2d24X4j/0tLBFUTYuWhQFnLcGIu7nONzawOq
         BTWw==
X-Forwarded-Encrypted: i=1; AJvYcCWcspghII7TQ0fLQMimoZSGDy2fek2RIIrCs/o1JnOXOV8DHtZVHeTk26N2wJs8gaEdrzim2T8MJtW2mus928229HILxAiovIAY
X-Gm-Message-State: AOJu0YwpRYPTvviWKsAcn3eIrRDC/eMXRO60Wp7Emh+DRqt11Qt3MOek
	W5SOAhtS8TTpv943adtIE1UW1UjF2sfDvrBpQLcRhycIeru7vcofEGHO2UdzaJ9zX9gSox90h5O
	eFXYxZ3xnNXgab2K7cJkxsD0Y5N0=
X-Google-Smtp-Source: AGHT+IGj398paHfLQ1BsFgaRB4fJZSIWeFIYcT3tqyO/GRsK0aLaHyvoYdGtI3Xd+Wubw/UW0qVAH8JI1Iyailjx1W8=
X-Received: by 2002:a05:622a:146:b0:42f:30ec:aa36 with SMTP id
 v6-20020a05622a014600b0042f30ecaa36mr5622284qtw.45.1710311772939; Tue, 12 Mar
 2024 23:36:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFDm6W19R3KHDO09c94Uwry9mdG+whAVy=u4Sdpt30A2MK1KPA@mail.gmail.com>
In-Reply-To: <CAFDm6W19R3KHDO09c94Uwry9mdG+whAVy=u4Sdpt30A2MK1KPA@mail.gmail.com>
From: Andrey Melnikov <temnota.am@gmail.com>
Date: Wed, 13 Mar 2024 09:36:02 +0300
Message-ID: <CA+PODjqxYcBMc=R792uOava1u0EYZtrWTOw9HvKUBG4=zYbzcg@mail.gmail.com>
Subject: Re: ASMedia ASM1166/ASM1064 port restrictions will break cards with port-multipliers
To: Cryptearth <cryptearth@googlemail.com>, linux-ide@vger.kernel.org
Cc: conikost@gentoo.org, hdegoede@redhat.com, cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 12 =D0=BC=D0=B0=D1=80. 2024=E2=80=AF=D0=B3. =D0=B2 21:14, Cry=
ptearth <cryptearth@googlemail.com>:
>
> Hello there,
>
> I've recently seen a topic on the arch forums about a user reporting
> some drives went missing on thier ASM1166 HBA. A reply figured out:
> It's patch to limit the ports.
> As I use a rather similar card with an ASM1064 I guessed: Well, could
> this also affect me? And as I've just looked up: Yes, 6.8 will affect
> me.

How? Where are boot logs with working/not working conditions?

And see official documentation on ASMedia site
https://www.asmedia.com.tw/product/A58yQC9Sp5qg6TrF/58dYQ8bxZ4UR9wG5

[....]
SATA interface

AHCI SPEC Rev. 1.4
Four SATA Gen3 (6GBps) ports
Support NCQ
Support SATA LED
Supported port multiplier command based switching
[....]

Four ports. Nothing more, nothing less.

> Why? Because my card not just has one ASM1064 but also 4x JMicron
> JMB575 s-ata port-multipliers which fan out the 4 root ports provided
> by the ASM1064 to 20 actual usable ports, which I currently have 8
> drives connected to.

Yes, if it connects each of its ports to four or five JMB575 into PMP
mode - it's able to provide 16/20 SATA ports. And this patch changed
nothing there.

> As the user on the arch forums reports: Using the current arch kernel
> with this "patch" makes the drives disappear - using older kernels it
> works. I expect the same: Whenever this "patch" hits the arch standard
> kernel I'll find myself with ZFS failing to import my pool - breaking
> most of my system.
>
> In contrast to what's noted in the bug report, that the ASM chips
> wrongly report more ports than they offer, or that the "patch" to just
> limit the number of usable ports would "fix" anything actual does
> break a lot of ASM chips - at least the two currently in the new
> ahci.c file.
>
> As someone affected by this (I haven't tried any 6.8-rc yet - but just
> from pure logic adding 1 and 1 still comes out to 2 - I can already
> see what will happen) and looking at the sales numbers how popular
> HBAs which uses port-multipliers are as they're quite cheap compared
> to SAS controllers I highly request this "patch" to be reverted - or
> at least to be gated behind a kernel flag to be able to set at boot to
> disengage this port number enforcement when someone like me does use
> such a weird chinese port-multiplier card.
>
> I don't want to argue about thier drawbacks and issues and risks - but
> when comparing options getting 20 standard sata3 ports on a pci-e 3.0
> x1 card for less than 100 bucks shipped is the way to go when the
> other end of the spectrum are SAS HBAs require at least a x4 slot and
> special sff-cables and often come with RAID firmware not suitable for
> ZFS - and yet cost at least 300 bucks USED for only 8 drives.
>
> Please don't force users like me to compile thier own kernel or stay
> back at older versions just because someone reported some feature as a
> bug - which is very likely not the ASM design itself but rather some
> generic firmware shipped along with the capability to support
> port-multipliers.
>
> Again, if you want to keep it at least add an option to disable it.
>
> Thank you for reading.
>
> Greetings from Germany
>
> Matt
