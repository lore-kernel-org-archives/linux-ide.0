Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADE630F80C
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779887716; cv=none; b=Lva5DTXJ7bH81Fcu+P5/3zJV5euaU7geJ9EFTExSel5rQI5vcSd4ib+rQRCJO6+NqbXWzHsGFUjnfExmx4L1fpPFAZ9IbiI2w1QwyrzpCzVdS+fKzEAyfhrn0xPJrZb560tH/PmxjSP8sq87ZoGx0B9S0rsrk/ynYCjzW07puAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779887716; c=relaxed/simple;
	bh=NuNvxIHEMMpLcTwcLN317lzyiSS9qhMROyeREEechDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YaWL5M9o9Nc720XkioguNCDa11sfvtj09gs3L3DQYIhciFdbzTYoJtXb+OjrIrJt4xtWdL/yUu0MGWkOauv2kDzSHUjNEMqeH7t8oo7+DI3mMx0nHzR5o5D00rMxHdOMTMwGkthQbk8E7ovKtgFaO03nGgKt7KrPRagfYvRg9KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5945b781ddfso564217e0c.0
        for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 06:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779887714; x=1780492514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VJbyg3CmiTY5UdW1iNZoeveCs0jnc1uKWTBV/g2Zt+o=;
        b=JDUC8EMWEwnzymR8w0OoXI4ibEfiPdjRxzNbzACKt0k3lGW3mIIzNnqCVPxE/x9FPn
         AkMbURI6B5BW45aE0qcT2r0sKfVXnBTnA8RTXg6ssF5X5wu3FsNGW9eqN8QuntJAbM3a
         eK6TCZjzNu53PvQwj7WRMjx7UvwMnZyoCTcZ3aJo1Wgl9Wl82ewRDkRpkdFBGMc71yBY
         1KPLFvRqn6rJ987g0j9mAARotCIAd4cmKcJhi9Y0/j3mqKfSXSD69+RS+g5I0X60HgYL
         /F7RBGVy3uCbjH6dzKqWB+CUoDr+79TAEaTYk7eOXs05NuU1QYnpIYY1tubekdjBFI0c
         kbvg==
X-Forwarded-Encrypted: i=1; AFNElJ8mPORCPmLDVHutVGvSKLfH4AVb28EUQi2BitA8ZalP0gNoITKPvBHhtj51TxJez9i993gN8IO0yI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/jyLOhuXnOXAXZhmCzo0T4LHcyu6ORX5rTM1IlxddfA95Wejg
	ypz1sOLwzNqgvynIr8aTo/Dvn4UK0pIe2BnsfSU2RrFZC3B6pkRsuR/mEf7TUq0Pkw4=
X-Gm-Gg: Acq92OFjEV1/UXJ956ydFEq168OLy+dZp3GZhXmcL0lkL81ZhqIfP3VQFv6rINsptzq
	0IA8fb72efsma7KPdQjTNRbUSbUIuX4SilxYYCm5ww1yhxWWrdKjPAwOsDF63wzi7zS7cQNgYxk
	/wmbqLw53f5mzB5Q1+LUp89ihg8GayrT66amjAQPpAC9kGL3dioV1kQ3Vb2wG5nlBboC9lj9uFw
	x9wMUkt19q2+kVoTs4COZAtzwF7cNtvowNUCcMDXSo3aZ3QTvqxh3WqYSx7wODzI9quQH4nQgVd
	N/bmo7+n+TimZU7rzZjbvuHDvOgkP8WXrUUWtuTDZrXpqnU8IS9Bc7t+zrir+Mt8PqWDYiDyncL
	V+AVAYvOnwVUZlOP7eDCSNQBX2c+R1C5XMojCXQzAvXIGj2WGPF5pVkVsi0PJl/QsUBja5pfyw7
	CazzXwJ8nnfzWb+/G5uS1iopgufYuiH1tA3kr+CVN7Mv553li2ErYIWfEB9PWQ
X-Received: by 2002:ac5:ca9d:0:b0:58a:2844:d8ad with SMTP id 71dfb90a1353d-58b8f2bdfeamr4324121e0c.5.1779887713815;
        Wed, 27 May 2026 06:15:13 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586ec46c8ddsm20738793e0c.0.2026.05.27.06.15.13
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 06:15:13 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-6312bdd281eso10662428137.0
        for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 06:15:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9keR6gh8WyjkmRoUlmdcsqdhNIxClnHWBsiS72Hq2j7qCjZOKLCPSIeA8eD40+Nbnb+BFoa91Nb6I=@vger.kernel.org
X-Received: by 2002:a67:e905:0:b0:6b1:c09:4202 with SMTP id
 ada2fe7eead31-6b10c094452mr280240137.5.1779887712838; Wed, 27 May 2026
 06:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com> <a20f52aeee9dfcacfaea43ff280fa1867878cbbe.1779803053.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <a20f52aeee9dfcacfaea43ff280fa1867878cbbe.1779803053.git.u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 May 2026 15:15:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWJpPZ2DhrUE7cpF20Dg2+wWqXRL4D6cfDca8XLQegOVw@mail.gmail.com>
X-Gm-Features: AVHnY4JNlHO3xU2ToNfirnyHdNDRJnjKIw-cP8vUt0A5y3NPzppIp4JL0RDJSno
Message-ID: <CAMuHMdWJpPZ2DhrUE7cpF20Dg2+wWqXRL4D6cfDca8XLQegOVw@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] ata: pata_budda: Use named initializer for zorro_device_id
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, "Christian A. Ehrhardt" <lk@c--e.de>, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 26 May 2026 at 16:18, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
> Using named initializers is more explicit and thus easier to parse for a
> human.
>
> It's also more robust to changes in the struct definition. This robustnes=
s
> is relevant for a planned change to struct zorro_device_id that replaces
> .driver_data by an anonymous union.
>
> This change doesn't introduce changes to the compiled zorro_device_id
> array.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
