Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAEA8F49
	for <linux-ide@vger.kernel.org>; Sat, 17 May 2025 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747499554; cv=none; b=icdvnxnhBSrtp5aUhGoCbTowLKmmcPYN9mwjnGVc4H+2PznXJyXEp4uSoLghUs1E1PPVYkjDC3N5FgYpqYDAsZDUVN8CZLKoFYb2Mn2b8W0PdiwMOZdy51WrJX8PLeOBnEi9Iq7S6zeU7va7VpJetXndLF10OhidD1Lj7yjId30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747499554; c=relaxed/simple;
	bh=2FVQ8EOvEAWnJvggcp3uQ089Gyx5LwfK88my8nBuRbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=octMz7VAsIk6lfY5e1p3aKVizHbXiq7IvdeyJK++FwrGSUcsbRHQ2A8hmXJq0sXEWxbSnIgpAfZQyqeDBpxPBaJQVEWfsMWQ5xxzCIlLVp7s4nIO0NG/SlUuGrkNBX5vGRUYqyIJzJ7X7xgI6iyzdofIkdz4F4R4dXsEXt1ZQwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTiL02el; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTiL02el"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e733a6ff491so2871888276.2
        for <linux-ide@vger.kernel.org>; Sat, 17 May 2025 09:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747499552; x=1748104352; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wcqXHsVxEE4rCuAYnJJKC/dXoeW2C0BIRnswReGOQrg=;
        b=cTiL02elcwnZ/6EtpBazPts8Ver8imgQW0DF5SUxQdwroeGEMLRKgIkD3Bwmh16OxD
         GDEsGFC1xATrdwtAWZPPKiOtteat0+IL5SIdaarogycedmC1RzcCf8zqgCWDROmVQkp7
         B0g6t50fL18GGQFRRwDLTVue7ccG05sVAkxaUEJzXx9/w+gr/Hx+Uy/Q/U/b6KjjHc9Z
         tlCw+LRSEzg6QXQYDgrRya889wO8Xx+XmA1ph8UUQpS40BJAiSNMLUT/8E+psfH7v66F
         xCi/NSsnJhepD6JUrjSP9ZeMDnrNuPW2IL86dsRxuNqUFuhsMV7z+1XlpJaldoF9iwma
         HM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747499552; x=1748104352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcqXHsVxEE4rCuAYnJJKC/dXoeW2C0BIRnswReGOQrg=;
        b=ww0AXHqbGsEXiJjEyEfONjtyIE1WfH0EqD9+OdpQD9VldZu6CGz0FdFHqaMm+kTBSK
         NmB05h2b2kBc1NC1wmxEbWaLbIxCUaLTatrrQSZrk0uJveyzHEXOo73wZmb2hNrA6N4Z
         0knVDfzU42h7++WUU0QwVOlCHEOgZkTEK7CVv/hR1vFy7VCG0NZjC/2ml6zCWeXUXmvM
         bpW7lmrcQ+/t+iPJGdPCh3esmHFj7pZviOKelsR/vxzR/QQtvP7OMqtoeNfW53mBkvSQ
         PUCMax1y55PvlXWwu9BEk/aQfMI8Ym5QZp3f6f4/KAw8PcI+kaJmg95ljlUEmowaT2F2
         8dnw==
X-Forwarded-Encrypted: i=1; AJvYcCUun4lA/BUEWXq2F/AuIa8sfDn3BzQ+A1by8Frhx7W21bbJ0sIpXBZ+4nLJnJG9h4fdMLUqmQgpi5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9GTAiv3V72kUYjJ+B18oA9wsyRamjIcT/T8DJqUb7bXwbwWBY
	hiSCD52N/+FFB1YD4Y1pYRhugYhz0KrjQZX6nSfqihk8K1ucz60N4M6/GtnTbfDE4mGuCV8Msnc
	4ZZMFHKd/5n/nYH0hYfZ6jrD7986TOok=
X-Gm-Gg: ASbGncvC2DNV/XsbQyyJWs6Ju7OudvnalvAYEuCqtB4NYAgXfKtrXm4/G3mwjwoEze/
	LlmaJt0Xqef3ZbaeuegWWWAAxR8sn2Hike/phbiab8poy75ZdTVg7nwuqy4yghoW3O1mNnGz3S7
	5TBJ5+O95jK2C7O3goVWlqGcMpmFzOKdVtnw==
X-Google-Smtp-Source: AGHT+IEOIe1rQXVxJWarDz2h3HXzbuTVDz6uJVwglZJoPJzgUJcmwafEAb0NnBRgCZJrp9nMEUT5l+wrUCPh7lI9B3g=
X-Received: by 2002:a05:6902:1b81:b0:e73:71b:72f0 with SMTP id
 3f1490d57ef6-e7b6d3990b4mr8715830276.9.1747499552064; Sat, 17 May 2025
 09:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aB8_rITWsMzkTiyE@ryzen> <CAAZ0mTe7Tpf2F1cKbmr==43pXDUxcPP4Q2AydpyDFJUrFHzNHQ@mail.gmail.com>
 <98E34F63-CCAE-48C4-9584-9053C3D1A7FD@kernel.org> <CAAZ0mTdcAazi=133Dz0+OgSGOERe7WmCTr27ePudEVhkJj6VbA@mail.gmail.com>
 <48F49924-F5FE-4A91-8323-E2C789D1BEFB@kernel.org> <CAAZ0mTdtOVSidMeC76X9oZyHCtJdgyiu44+UEKqP5tSUaD9ZsQ@mail.gmail.com>
 <aCG-gS2f3uXKaQPj@ryzen> <CAAZ0mTfqE+w8BBCyVSg0KKQ6fYZwKaqvh_ND8dLCANg-oMaphA@mail.gmail.com>
 <aCHZg4tj6YwS9vph@ryzen> <CAAZ0mTeiVqZQvkWzJ8aFH4FUPCZwy5O+9hPBgDPhSgNNz+t6HA@mail.gmail.com>
 <aCTZkV5mRjDsYyeE@ryzen>
In-Reply-To: <aCTZkV5mRjDsYyeE@ryzen>
From: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Date: Sat, 17 May 2025 19:31:56 +0300
X-Gm-Features: AX0GCFsMOzZNKjoOIh_UUBKR0xWWSGapfLhU2cfERN5odJgCpY7S7OCLWlYK2ns
Message-ID: <CAAZ0mTfpQwO-dBzvqP9OFKDpo92aDqZx-g_BB8Zn2f35tDhnhQ@mail.gmail.com>
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ke 14.5.2025 klo 20.57 Niklas Cassel (cassel@kernel.org) kirjoitti:
> > Yes, but for some reason now I get different results. I wonder what's
> > Now with vanilla 6.14.5 and configuration:
> > sata ports 5,6 -> WDC WD5000AAKX-001CA0
> > sata ports 3,4 -> WDC WD20EFAX-68FB5N0
> > I get:
...
> Well we still see:
> > ATA device, with non-removable media
> >     Model Number:       WDC WD20EFAX-68FB5N0
> >     Firmware Revision:  82.00A82
> > Commands/features:
> >     Enabled    Supported:
> >        *    Host-initiated interface power management
> >             Device-initiated interface power management
>
> This drive supports HIPM and DIPM,
> but only HIPM has been enabled. (Which does not make sense since
> lpm-pol 3 includes DIPM...)
>
> I have no idea what is going on here...

Hello Niklas!

 I rebooted and exactly the same configuration gives now
Device-initiated interface power management on for both WD20EFAX. Also
tested on 6.8.12, on which Device-initiated interface power management
is off for both drives, as before.

> I would add some debug prints around:
> https://github.com/torvalds/linux/blob/v6.15-rc6/drivers/ata/libata-eh.c#L3512-L3520
Good idea there is something weird going on.

> Did you do something with this drive?
Nope.
> Was this perhaps the drive that got timeout? and for some reason
> the timeouts caused DIPM to get disabled?
No, no timeouts.
> Did you get any timeouts on the other drive of the same model (/dev/sda) ?
None!

Best regards,
Mikko
> even though it claims support for it, and you are using lpm-pol 3.
>
>
> Kind regards,
> Niklas
