Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA5A54739
	for <linux-ide@vger.kernel.org>; Mon, 26 May 2025 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748260307; cv=none; b=Nt5JrsO74sJu3A9H8KySxkdextgCdh6fUIrkl66UPLeXqDh79+VRp0ApaFVmkgW5ofVHCYMelKwT16xsFDGsyCpoupoG/lflPWMkEK1WXLZrX68J9lp+IFWW/IXur9hMeSh+V4u32pkYuvaQ6vY2LJUjyF194H7tT3VdAaI+Jkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748260307; c=relaxed/simple;
	bh=eVe7gzDvYkF/v7+yXapTB41J01zj8EULcLXAJYEXPmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZbgzfVkOJ8XOLamSKLmTS1h/ADtCXZfi73nqwlGLwxFe4/lzfRUU4othbZ8qvpC7fph4URYigyNkMMfv7KTBO6OdBz7q8RMn6qFNr7c1i8rs1FaiZYwDO8H5+R5ljkRqfF5BS4/eFfRTKQHN4EL8xycFxhM5pRr92ENKEXjywY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgL0wDew; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgL0wDew"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-52dbcd398f9so1464580e0c.0
        for <linux-ide@vger.kernel.org>; Mon, 26 May 2025 04:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748260305; x=1748865105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vk7I/TjZus1WfjiLul9K4l43bV0WtVtb36G6wrfsiH4=;
        b=ZgL0wDewzad+sjLGrTodrMbBrGDcwwQu2VhZPTiMRS8yp5S9jeQvWm/SNb8pUgT5FJ
         OpaAPqBChVNI+Ymq2K/yJDU7SmIT966mZcTGxXsTZXqFriEyy43d/VK6K2E8xTxZjH3s
         U62kL9CeeWYKdBw8etgqHHqwezA/Pr8uigxl/tG6hxtLZHfXhtt9Ji2LB+M0JIuIZJWo
         XFK5zNwJjRzruel+tetDp0k6FLFWdhXcwqaNptz3ijurXSIEXwSnDyqyzPwbc0RWWmqU
         VxY2CTCW5HjXfyBZMVp1U9qh+laOYur+MZ3prUVO5JS4IxljMPhbnoGh0U9jP3p6lA0H
         /f4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748260305; x=1748865105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vk7I/TjZus1WfjiLul9K4l43bV0WtVtb36G6wrfsiH4=;
        b=Nqd5QX3xhJlZlZeuEp8DIlyco7nmVTdq4thxBysiVhdo/LoQ0OZCGssfkEB9qD1lz+
         JFpFuL0agOG+2oGTwb+SVn68iTziDWuOip+Cx4oXVZ1B6p17YT6YtGPXzLWzGNL6c+Hw
         W0laUtwDJkdYIWN/SFbUdE88oPgt2NGru/Ffo81107wHXXm57uX2biqsqE93yU121fTC
         aAM6d9vabPC4i2V+Wp3bzlr0Ag6G6y4s/ybPW9QOzFmf5HMVK5ojgJ+9eqH05ry3opWB
         e50whpHDmWmH+an65xf9zDVZFsTuh7M9kZH7BxVtO06NP5xavHynN6e9IZUI0BJfTFmb
         A2Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXaSyJfGg5/a32EIA3NRFtysU6QST3bvTrHbMaBBPXgTRAmIE1v/q9UkeF2rWVIdaBTW76i/rZQ+zY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1idFbWLfoCO8Us95dsQnhdJOiLgmxBcRAJe7AfGHXC4GMRyBa
	4OEZIgtNUc2vJk4GvXzwG+hN/VRBHz3RcCN6cTm2jtG+uPQ0Pf8UinJw3nJZqscEk7GH8sgs6mC
	7d6vRpJFJDtGhkUywuA9k7mtmAsAxVKw=
X-Gm-Gg: ASbGncsVGcNvhjX1Yh1gNxa/mit06fecKAt4svhr2IBPSuSnF0H5mqgb45oHyucV/Ck
	iBY+vGdaSx00cK4vH+0PeXtj78bva0KwTi8XWYryBahG0rIVuARwGH2VdJ7chCBNzmtIu5JiyB7
	31q3kmy/SuYPhOsVRTifiydD0fXUNWxPdcwJReFaVmLH783z/cd698PwDR1Bga4txrPg==
X-Google-Smtp-Source: AGHT+IEJff5k2A8k6P3iag0uEos2mJDRIGeS8NhKRZjyRef4636hA/5M4HMNpMmn3C4cZE82rze+xiVAJ/76kykfQIw=
X-Received: by 2002:a05:6122:2007:b0:52d:bcd1:ab55 with SMTP id
 71dfb90a1353d-52f1ed6fa19mr10025557e0c.2.1748260305247; Mon, 26 May 2025
 04:51:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325155613.352680-1-p.pisati@gmail.com> <aCSBV_L-NcNX4n7G@akinoame>
 <30ba2e36-8957-4dc0-a5d7-85ba71ad0a59@kernel.org>
In-Reply-To: <30ba2e36-8957-4dc0-a5d7-85ba71ad0a59@kernel.org>
From: Paolo Pisati <p.pisati@gmail.com>
Date: Mon, 26 May 2025 13:51:34 +0200
X-Gm-Features: AX0GCFvO8Va9CeULMkFesSsZFw4wit0oh9MQ_2DCVFRYVjrkbWKkIl8KYMha6qQ
Message-ID: <CAMmgNdZ0RT+GTrK_mmeG3d=Khtck80gE9itrjSQbOrtKB=_U2w@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] m68k: pata_cswarp: Add Amiga cslab ata support
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

any chance you could give us an update on this?

On Wed, May 14, 2025 at 3:38=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 5/14/25 13:41, Paolo Pisati wrote:
> > On Tue, Mar 25, 2025 at 04:56:11PM +0100, Paolo Pisati wrote:
> >> Here is a driver (and the subsequent defconfig change) for the pata/CF=
 socket in
> >> the CS-Lab Warp series of Amiga boards.
> >>
> >> Changes in v4:
> >>  - refactor pata_cswarp_data_xfer()
> >>  - ioremap WARP_OFFSET_ATA region
> >>
> >> Changes in v3:
> >>  - suppress a comment
> >>  - properly return ata_host_activate() error code
> >>
> >> Change in v2:
> >>  - fix style, remove duplicate swap macro, driver version, etc
> >>  - rework the zorro attach mechanism
> >>  - remove the unnecessary zorro ids refactor
> >
> > Gentle ping about this one: can i get an ACK or a NACK?
>
> Sorry, this fell through the cracks.
> This looks OK to me.
>
> Geert,
>
> Any comment / ack ? Or do you prefer to take these through the m68k tree =
?
>
> --
> Damien Le Moal
> Western Digital Research



--=20
bye,
p.
