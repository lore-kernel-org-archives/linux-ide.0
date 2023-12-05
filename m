Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDRJRetf"
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512D2AA
	for <linux-ide@vger.kernel.org>; Tue,  5 Dec 2023 02:00:08 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5d7692542beso28751887b3.3
        for <linux-ide@vger.kernel.org>; Tue, 05 Dec 2023 02:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701770407; x=1702375207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i93Z/CqJ+EBecddDOnAmVzRbIcIUtO0ehOz5S54CfrQ=;
        b=YDRJRetfQA80jrjZYAlfT90vA6kpOsfF70/ktTGJ25Lk4nxospYByarCuZVETKVEX+
         T04DRfvWpjz7YsT/JikHiUPmjRMxckzN8B9eEohxgMhuq7QUvCZndWlRA1q+zTiXqVk8
         raIS3RFBgbsMdp/iYKWaZ6ehoAazJ2aYoUu+BtQviPhvZxEdC8ELMogHqNsWrplpuegX
         K/cI+VioTMwDX2wVOK7t+zmNadxVEtG6WgHcaC2menF1zD2agwrSdmG6LpvYGQH7xrhb
         l6V0g+FLpDsl8+R0qUAVUTFj57n7Ilf6hVnNXQfX7hiOzM/b6Ti9kN1yK9VZvctCVCrZ
         KiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701770407; x=1702375207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i93Z/CqJ+EBecddDOnAmVzRbIcIUtO0ehOz5S54CfrQ=;
        b=eYVFGLPSpQlq4g0FdTSZ69k9TVWpQ8bwfIQkw9SR4y6i1kb+f67+CfQyh6A/XTAc/d
         sdZhShBLkOUkCsCiEGHm9LNe6L03NdcITwnHacGiBEEWeZjzH1AieLry4ig+QV3xSCQh
         WmaXx7jhi3NYB/Ec7HQ5crtVn7xs0bSWMveVjUAh/SpNxhTV3inMbqGw+WLEnP2z8RNV
         FljP6XOdLT0psLlLB/pxOZON8DUGdAJLzkGpQMaP9MsqIbechmay3/o74IY5EgmAgUig
         p4Ry3f7837bexJ+NOP8IA5L7/pfzgBNVmTnL5xhBgDKv+iXFhs6leyh0JIT1pivHYMFX
         X0rQ==
X-Gm-Message-State: AOJu0YyCkkp67PhvqTPmX2xP+wpA9azJGPcmVlfoPuKRzAQXoNqd65Og
	ooHevt3cgY4AU/OETprD6sidN26/7TcdCy11EMVyHw==
X-Google-Smtp-Source: AGHT+IH5eTb2gwdS22rkWHvbJD/nbpWagDnymfw80erU7E8T3kEYsszdXZXrJ4vDy/yEfDwBBs/YnsUIOf3GGpmbFhk=
X-Received: by 2002:a0d:ccd6:0:b0:5d7:1940:53d6 with SMTP id
 o205-20020a0dccd6000000b005d7194053d6mr4529462ywd.78.1701770407103; Tue, 05
 Dec 2023 02:00:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701768028.git.ysato@users.sourceforge.jp> <1fafcf1c70ee4e38847bac1379bcb4555a237505.1701768028.git.ysato@users.sourceforge.jp>
In-Reply-To: <1fafcf1c70ee4e38847bac1379bcb4555a237505.1701768028.git.ysato@users.sourceforge.jp>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 5 Dec 2023 10:59:54 +0100
Message-ID: <CACRpkdbFNyEn_ub3moh9f6zbBKzTBt-CPRykUfexd5fXjpKE3Q@mail.gmail.com>
Subject: Re: [DO NOT MERGE v5 17/37] dt-bindings: interrupt-controller:
 renesas,sh7751-intc: Add json-schema
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Lee Jones <lee@kernel.org>, 
	Helge Deller <deller@gmx.de>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, David Rientjes <rientjes@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Guo Ren <guoren@kernel.org>, 
	Javier Martinez Canillas <javierm@redhat.com>, Azeem Shaikh <azeemshaikh38@gmail.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Bin Meng <bmeng@tinylab.org>, 
	Max Filippov <jcmvbkbc@gmail.com>, Tom Rix <trix@redhat.com>, 
	Herve Codina <herve.codina@bootlin.com>, Jacky Huang <ychuang3@nuvoton.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Sam Ravnborg <sam@ravnborg.org>, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
	Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-ide@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yoshinori,

thanks for your patch!

On Tue, Dec 5, 2023 at 10:46=E2=80=AFAM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:

> +  renesas,icr-irlm:
> +    type: boolean
> +    description: If true ICR.IRLM=3D1

That's a bit hard to understand. I suppose it's something that need to some=
times
be changed for a system so would be good to document it properly.

> +  renesas,ipr-map:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      IRQ to IPR mapping definition.
> +      1st - INTEVT
> +      2nd - Register
> +      3rd - bit index

Isn't this table always the same for a certain SoC, e.g. compatible
"renesas,sh7751-intc"?

Then don't keep it in the device tree, just look it up per-soc from a
table in the driver.

Other than that it looks good to me.

Yours,
Linus Walleij
