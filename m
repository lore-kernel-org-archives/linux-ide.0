Received: from mail-ua2-f38.google.com (mail-ua2-f38.google.com [74.125.226.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA133CCFAC
	for <linux-ide@vger.kernel.org>; Sun, 27 Sep 2026 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790512167; cv=none; b=X72nPGNAf4Tb+ZNfD58RQTGWnuVQMATE4KDtFRCeSIVQ7hQKYm9vFYor3Rr/RK9N9dSFsp9QyXUKAUvrz+cCmLVuUywvmQPRBIOV8YAYs657BqHzseeUPwKG05r5s8TVnYyok6unW2hrWG472r79GmssZC90WuEDB6Yz7oVGrI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790512167; c=relaxed/simple;
	bh=HDboq6EhNxHP1SC0MpV70Cq5drBQD4KcY81w33QxDHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ct3AtPmQYKQTaQSIdxspQ8NvxCb7xQ938anoPCFIkyifrSSawRwqKbH95U9iCQjcqakJRoEgjcKESsuuSOEztyCAs4uyqN8y6wcZUtOHnL8baktfWxvpr3BnIp6tOicBg9Gf0CR12fkDbWN6+jRmDT8BlxedHl7tgz8VpZi5p98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.226.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua2-f38.google.com with SMTP id a1e0cc1a2514c-986de33cd6cso1037483241.3
        for <linux-ide@vger.kernel.org>; Sun, 27 Sep 2026 05:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790512165; x=1791116965;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Rt/VmvtxGRMo80r5H6ofmpt3nn/BIq11DVjtj9mgh+c=;
        b=vTgnvN5LTcTNbjaJixUjebU+EQPmCyupzayVqZxS9Ey3QqtHJaEn/tZLpvtRMvMx/L
         lHOf9eh/LOOx5DARYY3kKEHvkg8V90XsLBoQK5ln1EJx/VZSY1FqTX2QxL48tMn5+Qrw
         wQCw4UnnJ9qS1pZyjhJKNXV22x5GRfaph4TuiiKrZC3i1h8cjMOa3ZtEeOkD2ITFHqCy
         q7TH7SKsk3p7RaiE1SvSjNKZ35K6AETZZWqVEEhE3FGmRL4rCF1JNhVyHPg5JdzjrQTJ
         Q3/WLL2imO5Vph7tkq0hQSsX/VliZHIW5D9bPGruH6QaSsVvXT0kLidmwK6DiY13wDdJ
         18NA==
X-Forwarded-Encrypted: i=1; AKwUvBwEK0MueMkUoGrkCPIHnyD0DkmYWvKGvZrhDTf5GgO8R+JdyzHXy2GS+Zz5pSTbT5mSJFAmVx25aGQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQ6geevncVAzu2PWZgcBUgiQIr6wgyWEC4O4nQjIB42rEFTyL3
	geB0vG5gvBaqglikhpAdP3IZr6TGvFzvOHXUXgS72a+haDtDOBVXTZZNIDi+7y0T
X-Gm-Gg: AYBFou2Lzn7PZnwxjtmY+bTDcjaJKWGjdyUPb99i5e6PL+r0WDWb3UBssut4hjIFKqT
	tQeCcT9YaOZwddXygNIYzv2M5mDSbrXvwsVSO0qm8jmyGelhRMLyOfzVdv+0vr5ooGkFkNVFkQS
	S+q/zFMovblFNvlQhIv2yM2ll9HlAuyu2IMC9NJ+3VAn8Siysmnvkpo+VNSvhF7ueD7I+qW4U/g
	/D1LNliTYxm6SVgqzQfZ8GO8TirVcJqpjUP324z9KJjuzRr1nFjwZu6teWBwHE41bfM/Pf9IUub
	iT3/89K4/yC9RO0NkssuQNv/0TfVHjh+kZ7f/6qevA4O3+sXPgf/Pxyb+Wzu4XXfYd2Apan0zun
	mZCxdtx2rj1mA+Qv0un06XIDu6p5/1ds1jxo2WG0Vp3qBdp1AOmCxbEmo9ndo0zYKhampmKbvzO
	c8xxfB7gvcV20EUl0Z6fnAaTXvu/9DD2F14ojDhflJF8vZa/jmYveBi/p86gB1l7H5qg/l6U8P8
	lTVJe3lZzKmOT34tKho10pNU5G3ckJxzxTMMQ==
X-Received: by 2002:a05:6102:4b12:b0:7a7:19aa:8a84 with SMTP id ada2fe7eead31-7af1edec48amr4026000137.31.1790512165598;
        Sun, 27 Sep 2026 05:29:25 -0700 (PDT)
Received: from mail-ua2-f34.google.com (mail-ua2-f34.google.com. [74.125.226.226])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b9af306sm5341757137.9.2026.09.27.05.29.24
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 05:29:24 -0700 (PDT)
Received: by mail-ua2-f34.google.com with SMTP id a1e0cc1a2514c-982db8d3ab8so1152794241.1
        for <linux-ide@vger.kernel.org>; Sun, 27 Sep 2026 05:29:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwgtASBSq1wSwBJ04iWV+4ORxMgHHVJ10ZTf/i77fnU9rBfaWlN/13N8bHrH6m666PTHCF/j04V/R4=@vger.kernel.org
X-Received: by 2002:a05:6102:d8a:b0:7a7:19aa:8a86 with SMTP id
 ada2fe7eead31-7b38f5c21b2mr1195489137.33.1790512163780; Sun, 27 Sep 2026
 05:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826160911.460165-1-p.pisati@gmail.com> <20260826160911.460165-3-p.pisati@gmail.com>
 <b959b6d9-2fd1-4eeb-bc45-4968321b3ff1@kernel.org>
In-Reply-To: <b959b6d9-2fd1-4eeb-bc45-4968321b3ff1@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 27 Sep 2026 14:29:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXNcDgK-3JTU_TO4V0uhQswR=yE6=pL46Z9gsP2PBnKyQ@mail.gmail.com>
X-Gm-Features: AclHuK80N3Huj581BdS3l7h66uNHbFmlTSJwMV0kOgIhzBn2ANIPVZOF_CQgtV4
Message-ID: <CAMuHMdXNcDgK-3JTU_TO4V0uhQswR=yE6=pL46Z9gsP2PBnKyQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] m68k: defconfig: enable PATA_CSWARP
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Paolo Pisati <p.pisati@gmail.com>, Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Aug 2026 at 04:45, Damien Le Moal <dlemoal@kernel.org> wrote:
> On 8/27/26 01:09, Paolo Pisati wrote:
> > Enable the new CS-Lab Warp PATA driver in the Amiga and multi defconfigs.
> >
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Assisted-by: Claude_Code:claude-opus-5
> > Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v7.4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
