Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573329;
	b=4hPUmIzFgesm3WZBW+/t7OXK6OR8kpO6pnaNq+Pg1ZLOxe7HQZC6c4VycL1mPZXNNBRX
	 8P96bZfGA2QT9VlfFNlTjJz+SOhHIxBLy9kT41jp72DYXXf/G+rT/wRVjJ6FMhGFmEHwA
	 TzlJC6H9U/+zmqqkNqTwH20U5vdiO+qvpXOCLeAZHmH4qBkPYisIPY2rD5+9Q6rl9Cdrb
	 /ZcfIJHgytmSo5fr2n68qvwfGlTP1smEKXhdPA5LpqcqSAJKqDWTgI9QQm5/1EFMlJX1T
	 qamW4ZrqggD8t+cX7YtLxfYsGMODqnqeIY2G3tJzm16hgfVGhMCQjI0FzYT0oFIpqkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573329;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=T4cci4gJNuFTfolxn/J6fu+B818vlNle5g1andJTAjs=;
	b=YDqMk3NmWPrJO7RN0YLyCSVeqliGweAHaE+P2mBTj4LpvbX8yOVLI65Tfg8AardxmT0j
	 bJMHfA7RdYb5FAPGSeEf1zHhC8U2hPp7Wsl3Yfji/xHuGRCXwbPm5hDna4Hi4t1xctHtR
	 1VEMAs0j4fLbJpA5S41D4kxQjzUI/mmB6d0djGxIAAtZhYRK/WOVKPEADzi19FZMPTDUi
	 RgaxPNIqDPDXZfIGZFpnT4HBZhbsUxHKpoL1svqmyxOqco4Tqlf0rs1tFlQqMepVh6Dcw
	 c7UdIrQ4rgSQcC+8PNYTz0nwkzN6NWdGeJPOvAbdoPhWI+ONzupexcYbIRKPl//E1ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A93606A31E
	for <linux-ide@vger.kernel.org>; Wed, 21 Oct 2026 09:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70A93606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7cc91ddf447so151016137.2
        for <linux-ide@vger.kernel.org>; Wed, 21 Oct 2026 02:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792573328; x=1793178128;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T4cci4gJNuFTfolxn/J6fu+B818vlNle5g1andJTAjs=;
        b=Jg4YvJS1CuE8tvrcmA8jwgrfeMxjoF7ig1pYUAOJp0Kq7BWOjyYldNubWrVWZvOl3n
         J22R6SnkDtr1xJCfJVIe7oi0XdA9IOoB62+51vqma+k7zHjcsxseXhRDgCcRf84WvBLP
         0enh8YE6JUqnGaZI0kNtpatLYLc0D87h7QCvEY0YlIWDXY2h9NpsW03mPeg+JcmAt7dr
         b3Dcav6dWULa0n2NGOw8Caj1fp6P0e54lhje39Tk0esA44ZiDLWfbfd8WaYrfM7Lywio
         9rkV+RwU/IO7YF22LSF8RKwQXmKZspNsmoI6F12/UN6UlEWK3rxE+xyG+IViePCF+/Y3
         45Jw==
X-Forwarded-Encrypted: i=1; AKwUvBzrV2fLFkzHGq0g6x0M1pk8Hh8zHl/uLO2piyd+8Uc+K05TsddmeQ+8PxhSOnTKAhXY/syI3N71OOQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1sSBNsGhTVFY9h+U3DE2J+r9+FMilG3cpRf+1v7o58xIS9XlS
	D6lbBaPA9fd25YzrlmLPht772cP9SFZP1EadWSl8iO+5zCNYBaE0T+Bm/RFf5LpOH0Y=
X-Gm-Gg: AYBFou2NKiNUmq1Q3kfEbDbbj894tWCAtMvwAG2rjTRvIkmfkWnTiFlDw97TFVaBuFz
	reUfIqbDN6cCRkQqP2btnQ1udP/feKUEX++oMUp1tMWz/6I0JlRdO8gtz0jB2KEuVfd4EGILwHW
	Js+KxunuTWcY/sixGFUZQSNLkIbtFrJBgbiB6eX1ROtLCwCztgZseDwHSSFSkand0wSauB/jrgk
	gKNQFZe4bwIg1UI9W/ud7CZWbEvKaPu0MlkYrV+2Q9krWWHHNv5WlOltzyJ0W7gg6D5ceMiE6+3
	NhrCXxdLNNyKWidnVxzXQQ4oLf6UtkCD6weH38czn4t0WDHrAEpiW+3lCZ8iwPHhAlE2b00aaDC
	PmWnluuBLzpYsiTQqGviivlrXE6rNcjuGey7w6JW3L8aLbz/7lL0Fk/3EqMy9Crss1C+7RFuLDv
	6x+VdWu/CsvYyGq2TZCjTp00SvcEL8FQqMRf7aKXHVuKJxlPOa74uIsnankxdzp2RK3h9iCAKTA
	zAlnJj5b6Sy1FrooOoScie4qmYPB7Pre4FrQm1HUUXCITbjgMrenW7As/Tfa/roqz+6zsqgVJwO
	+R3ipqwDbA8zzG7iBQ==
X-Received: by 2002:a05:6102:5348:b0:7ca:e2c1:9a09 with SMTP id ada2fe7eead31-7cc926e8af1mr450102137.20.1792573328354;
        Wed, 21 Oct 2026 02:02:08 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990d0e116a5sm2458364241.2.2026.10.21.02.02.07
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 02:02:07 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-990a39ba4fbso126169241.0
        for <linux-ide@vger.kernel.org>; Wed, 21 Oct 2026 02:02:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx4vbQSVOYo9iR/okCO1gtlE9XdCOrjKjOfcrrEGWw/S/8jrvu8VzRfQiCc3bkP+i1gjfbpRO0ykCk=@vger.kernel.org
X-Received: by 2002:a05:6102:3709:b0:7c8:268:ecd7 with SMTP id
 ada2fe7eead31-7cc92739b17mr365886137.23.1792573326757; Wed, 21 Oct 2026
 02:02:06 -0700 (PDT)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017041419.311921-1-daniel@0x0f.com> <CAJpaz4abKAkDznoi3gczYHNQMF-j5cSajtG07Jws8LkFY9DZFg@mail.gmail.com>
In-Reply-To: <CAJpaz4abKAkDznoi3gczYHNQMF-j5cSajtG07Jws8LkFY9DZFg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Oct 2026 11:01:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWZTwfbXqV=oiaSseGXZNKzWD-bptZVuhbCnXwkt7+WoA@mail.gmail.com>
X-Gm-Features: AclHuK8GyFWJnCZctU9cyAk5_YSIDGkWTC6HLWIJClGOfTDRGxXReM4AFtrnhJk
Message-ID: <CAMuHMdWZTwfbXqV=oiaSseGXZNKzWD-bptZVuhbCnXwkt7+WoA@mail.gmail.com>
Subject: Re: [PATCH 0/2] sh: Fix IDE on landisk
To: Colton Pawielski <colton.pawielski@gmail.com>
Cc: Daniel Palmer <daniel@0x0f.com>, ysato@users.sourceforge.jp, dalias@libc.org, 
	glaubitz@physik.fu-berlin.de, dlemoal@kernel.org, cassel@kernel.org, 
	linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, fuchsfl@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Colton,

On Wed, 21 Oct 2026 at 03:05, Colton Pawielski
<colton.pawielski@gmail.com> wrote:
> This is my first message to the mailing list so please correct me if I've
> done anything improper or non-standard.

Thanks, LGTM.

> In testing I could often lock up the board when transferring data over
> SSH. I don't believe it's related to this series and am fairly sure it's
> in the 8139cp driver. I have a candidate fix that I plan to send in
> a couple of days once I've tested it further and there's no more
> lockups on my hardware.

8139cp is udeed not very reliable, hence nfsroot didn't work well for me.

> Tested-by: Colton Pawielski <colton.pawielski@gmail.com> # 3x LANDISK
> HDL-U, ATP865 rev 06/07

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
