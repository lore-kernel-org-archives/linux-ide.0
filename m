Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BB43DC4CB
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888349; cv=none; b=ZN2uxou8LBNKZ8r9gAKA3RHtq0kKPQi7L5KM9FEapG+YNVPMM3jxt61LRLlMLsHXCQbBrlHEsLhPRH/VChtm19nvUVicz3SjoPp2zR1ZJhcvyNCXCoksa9l4jxdGZlL8qO3xHw3/MAtZRCNyyrK19Ytd6qIwr7hIwnwgMurC2sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888349; c=relaxed/simple;
	bh=tmDU4VguE+cwpfpInPS+PXjfh3XEe4XV+vkqOU8kHK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLQXGuKCqGhw2VAyBKeE3HrYJLOpHtxnMIi42P6+DoPaMNBPRB7Asgsyvzca+5MOOhIGoiCzdpLrIkWSZqePr8l83rO/UN6ryIQa+qhxBZJ8Ys+O/j0DjE+wDygCS7+drl6QZzefxxux2w+RlnY3vgBqHCskqeC4MZuuZYayqcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e5fd39cf11so4718302a34.0
        for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 06:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779888347; x=1780493147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9MuSPc8y576tayBCaWdrNcab8/lH09ziazVq9lwM/2k=;
        b=po1MUpch2iy6Js/dCfCBoEg/hBUco5twaRFtCdfv5GkxElroP6i6/IbedMdl5ozHZ5
         dApbN3B4xMkTj9MxBs8XFCUTWszflNyI3vyMtNlN7JyNGoEnKYA3bJR6/1q98U4znagQ
         qGMglFrTmgX2Ru4mtjEIOkGNTQVIcXwm4ucGQcqTpB8KIy/RR1FYHsy5Rgx8ovLX+fYH
         dKwfN7+4Ro9H5Vorae2H3E6Y5NOEBVUdW8BFjPCSV5sWWlahurJtDOx6ikR8LPV8HIjs
         /70XgHSEmmViRRGOoCuBAaie0Sj5Y0nuUueUGw3Vj90lXC7GX0SAMAHA1BCHrtFuIOkY
         0pjA==
X-Forwarded-Encrypted: i=1; AFNElJ8ouP2CT7ezzs9gYbp9ggSwOVCF2hjHG6G6nRGmnOKVV080opCYNhdJW/NOHxP19CFCkaVfTUeGu08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4KopopT0twfIStLb4chEbyJliCAhZrhhMjhRbD+xRkF8BBv4T
	s8NFUyu2298IO89sRVjn9ccF+1CeeQEhaKU4Todl5pONTcZZ5QeUczFdqfqbTr2tecg=
X-Gm-Gg: Acq92OG3z3phkIQNIp6wdfkOK4bxKtabxvPHfQJ2ZX5q5jxyX5zlWU4vXdUdmD8P0l+
	+uPenlON8SfAiPYJN760KsZDbQkiIcmOFhd4o/vmJDkNp6CBHgP/Hxlc8WkFxCZg63TUHTQVolT
	qrwWORIqAV9HYExKUCPI8NC6YITynp13sdaszMRe2B4afrxl5c2AIyRGR/CGDXYQjFB69ehA9RM
	0ilxD8VdMuUm9clWsjmkBfSEqN+MQQMPJTY0YF/Ac5muASdnHpOIyzocPSj8n/oR+0ATi0FuBwA
	wVGAQvxK2QUdmZeLn6bTX1s5wo/hnvnxDaxpvwcEtUneUNdBmtG8WG8kBuSmD6lv0txJypLBcZF
	G6R+IIgXRZXCcQpBZgZbsjTPAR5/qU/EGtYjGgPvsQCKuNGRiFabPpbp0/K1DOQDXKhtZoIAp03
	uanBBEGr20UDYzPFv3SZeic3qkAkQ3oAvw+0Mpua8Fxp/a0zgtX4FBsN8N2+1uNY7ynvqXgVFmP
	M0=
X-Received: by 2002:a05:6830:673a:b0:7cf:da97:57d6 with SMTP id 46e09a7af769-7e5fec80414mr14713557a34.6.1779888347288;
        Wed, 27 May 2026 06:25:47 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e60666bb5fsm11694001a34.25.2026.05.27.06.25.47
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 06:25:47 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-479eb8bcacbso7406175b6e.1
        for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 06:25:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+r8z8c4FjMGto/xP+BGz8J19ogvYzWKy6ns7cj7kYF7A7n++fZTSsD+FuOGjtAY0LcslRSbNSESLo=@vger.kernel.org
X-Received: by 2002:a05:6122:3102:b0:56e:e9cf:7134 with SMTP id
 71dfb90a1353d-5865ee6c055mr11675886e0c.3.1779887909452; Wed, 27 May 2026
 06:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com> <49576a7501128c93ef318566ed7faefce163f1fd.1779803053.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <49576a7501128c93ef318566ed7faefce163f1fd.1779803053.git.u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 May 2026 15:18:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUFCGKUCDBLiX70bLBUGxU7iZRGT0hEipkrM2FkjE3v6Q@mail.gmail.com>
X-Gm-Features: AVHnY4K9MKooRiuSGEh5fNQ2eTKctG0rOT_zroLTx4bk0lQkHEgucmZG57_gNvg
Message-ID: <CAMuHMdUFCGKUCDBLiX70bLBUGxU7iZRGT0hEipkrM2FkjE3v6Q@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] zorro: Simplify storing pointers in device id struct
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Max Staudt <max@enpas.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Helge Deller <deller@gmx.de>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, "Christian A. Ehrhardt" <lk@c--e.de>, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, netdev@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 26 May 2026 at 16:18, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
> Technically it is fine (on all current Linux architectures) to store a
> pointer in an unsigned long variable. However this needs explicit
> casting which is an easy source for type mismatches.
>
> By replacing the plain unsigned long .driver_data in struct
> zorro_device_id by an anonymous union, most of the casting can be
> dropped. There is still some implicit casting involved (between a void *
> and a driver specific pointer type), but that's better than the approach
> to store a pointer in an unsigned long variable as this doesn't lose the
> information that the data being pointed to is const.
>
> All users of struct zorro_device_id are initialized in a way that is
> compatible with the new definition, so no adaptions are needed there.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

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
