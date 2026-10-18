Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2734A6CF2
	for <linux-ide@vger.kernel.org>; Sun, 18 Oct 2026 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792334901; cv=none; b=EViicJQOftN7d1ydGRIfgWkejPZZKAvHxuh82n/LEsvDdlsMxHRNkIJPp6pN4cib5SMHIiVNwn/dr3C4JBg3by3SKeEfXqp7QiJz/gKfeclBW8mK6GoSk9x5YZUhefnGxg9yM6zlOqbsWDBetzPvZwdKjWzuaNX6RYDr1dvKQQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792334901; c=relaxed/simple;
	bh=Hj5hLisB54S1y/tYqExYUjuqnvH778SRo1sotusOCHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDcxg9Vg10hPat1OkCUoj1QuZpFAgoY164vGJGQZZONLrxzeHZCzLhAt9+TYHu6cwQoxci2TqlMTZcmP/g8OOpjrkpIfkEwLgm/RrHjkS4uE7gF7s5ycGupnSs+Rs8S3VN/Z6ncg8966dg3o7+RDLRnMg9jI3vjlHnifH2NpS5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5eaaa9b1591so827222e0c.3
        for <linux-ide@vger.kernel.org>; Sun, 18 Oct 2026 07:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792334899; x=1792939699;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i/+KfkD3prUE3gpbH6xDwZzQ4znjfDPPu+7aaw/E4IY=;
        b=ZQFxJSgpe/SWR6jRjZussVXI93XyMl1fDC9r4qZ+O7eCyibN1gIEyZtDeEPiR5rXTI
         +vweVJGm+VRoYqg+xBssmIvCNXnT6rUKnOJ9KIhpBihrAYW/xHgI2FdGbXw6GYKxWvVH
         JGs8A7wlzc4kVgLaMibHW9zKL1cREX0C0nr/ns4rT7wiRFGSuWlyQ5a/kAlw5kYmb5Dw
         q/+/gHcftbxyl9CfjHbtXfvYF+9vRn2n3KLWlcC4ma6CXGnfdhJpKszlc0MMOzrEKwmm
         tJy8S/W4RvXt0LnRXWwshi5v6aX3OqXwHHjSvx6FzNd2OCV+7g1LTxOlVXZl61WDWSsM
         CYuA==
X-Forwarded-Encrypted: i=1; AKwUvBxfrjBxBSyGG+Y8WhAlrofoYqnDJ2JjuLZq0BklC7W3XJo0j45eba5biBCn5QAbi/nA9iF36I7/KTA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuxPiCXPi8V2n8XmjhDE14AuzQzFOPRhkGnN8ZallnH53BCQTB
	TCfQ0Yk+jRvTsgjiYUOWKMgiJImZmUh3JXpsMG6K4dYdSpjMne0KeE3W2gKnmA6c
X-Gm-Gg: AYBFou0XWfHwj7ZGCaZG3NehQfyRSiYpL1b97GDOde7WRUR3WjnV7rZyOLMUGKv38ZV
	VaULhRslrqY0RTOsSkY46+nniy796jcC4piZkyf6gYWCHLmSOKyrntDXn411kKRChNLG4lz18tS
	89p6qt25gp9vIILD3M+XpbUzc+r+KJhs8fEC4OC+uke1nUHmftmMwloTjCzVoLAvG7KKG2q7BWv
	31KwPmFDWJzHjrFPIuomY2RVIpVu9t7wKcMDRH2iI5ik7GlZX0JSPmTnu3O/9Vd/1vwexmWjV7y
	+dSQBjuHJIVKtzIP2EETtyIKX0jAF5qksjaG4vW2aS2ELIknGrbyV5uJEQVtDreRyrqIQmX34Eh
	IxpfUwVnWHV3PPOH5jkqqoSk0f6R9Dt4OGdvbjfdLZHN3N4N/rjdXOTFjCc+BdR9YUwsDe/RBam
	jR1bPmj+ldwiZxsgaTfXP+VXThgq76NWToxmd+0Vb8VAkTGrzHsVZpHtNl4ql/anohT6wtjaO0a
	utgTCJjIlSYhCyJ85cLfTTo/e+xHGUV+z5gnqAX5whqYpU=
X-Received: by 2002:a05:6122:469c:b0:5ea:c11b:431a with SMTP id 71dfb90a1353d-5eac11b4852mr469377e0c.9.1792334899167;
        Sun, 18 Oct 2026 07:48:19 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b474b2asm6939294e0c.4.2026.10.18.07.48.18
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 07:48:18 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-98c5876f2b0so696462241.2
        for <linux-ide@vger.kernel.org>; Sun, 18 Oct 2026 07:48:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByGY2e+/uQci7LvM+HdwLxF7a/tgjNRECRiRikQ0vbt4t4ncLraJZ2bau0t91XJh8CuE025a6XlRQ8=@vger.kernel.org
X-Received: by 2002:a05:6102:2c0d:b0:7c3:2f13:d905 with SMTP id
 ada2fe7eead31-7cc3670d3c9mr1798032137.3.1792334897916; Sun, 18 Oct 2026
 07:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261017041419.311921-1-daniel@0x0f.com> <4cdb2939264e0b7d767f44289fddffd40fddf504.camel@physik.fu-berlin.de>
In-Reply-To: <4cdb2939264e0b7d767f44289fddffd40fddf504.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 18 Oct 2026 16:48:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXmZash+8PmfSVrT=Wwob-mkq0x4umyRgX2-yikV9kaVA@mail.gmail.com>
X-Gm-Features: AclHuK8RBwZK_z43GrchRos_lydjyPBWt8zUJgcfKwlnh5NSKD4CTmW99AiE-yI
Message-ID: <CAMuHMdXmZash+8PmfSVrT=Wwob-mkq0x4umyRgX2-yikV9kaVA@mail.gmail.com>
Subject: Re: [PATCH 0/2] sh: Fix IDE on landisk
To: Daniel Palmer <daniel@0x0f.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, dalias@libc.org, dlemoal@kernel.org, 
	cassel@kernel.org, linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yoshinori Sato <yoshinori.sato@nifty.com>
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

On Sat, 17 Oct 2026 at 09:48, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Sat, 2026-10-17 at 13:14 +0900, Daniel Palmer wrote:
> > I dug out my landisk to look at kexec for Geert. Since I'm lazy and
> > LLMs are good at fixing bitrot I let my LLM work out how to get
> > it to boot again.
> >
> > There are some other issues (perf is apparently borken, there are
> > some issues with the decompresor and big kernels..) but this
> > seems to be the only thing stopping it booting with the defconfig.
> >
> > Disclaimer since we don't need to give LLM tags anymore:
> > - LLM debugged the issue.
> > - It has been checked on real hardware.
> > - I have checked the IDE driver patch, cleaned it up and
> >   cleaned out massive walls of text that LLMs seem to like
> >   to add but I have left its summary of the issue in the commit
> >   message.
> >
> > Daniel Palmer (2):
> >   ata: pata_artop: read the ATP865 mode register through pci_iomap
> >   sh: landisk_defconfig: enable PATA_ARTOP for the ATP865
> >
> >  arch/sh/configs/landisk_defconfig |  2 +-
> >  drivers/ata/pata_artop.c          | 12 ++++++++++--
> >  2 files changed, 11 insertions(+), 3 deletions(-)
>
> Great, thanks for fixing this. While I have LANDISK hardware myself,
> I cannot probably set it up fast enough now to test your patches as
> I don't know where I put it after moving places.
>
> I hope Geert can test and review your patches and I'll pick them up
> with his Reviewed-by and Tested-by signatures.

Sorry, I must have different hardware, as mine doesn't have an
ATP865 PCI device:

    # lspci
    00:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 20)
    00:02.0 USB Controller: NEC Corporation USB (rev 43)
    00:02.1 USB Controller: NEC Corporation USB (rev 43)
    00:02.2 USB Controller: NEC Corporation USB 2.0 (rev 04)

My CF rootfs uses pata_platform, which is enabled in my working .config.
landisk_defconfig lacks CONFIG_PATA_PLATFORM=y, so it hangs during
boot. After enabling that, the boot gets further, but it still hangs:

    INIT: Id "1" respawning too fast: disabled for 5 minutes
    INIT: Id "2" respawning too fast: disabled for 5 minutes
    INIT: no more processes left in this runlevel

Adding

    CONFIG_DEVTMPFS=y
    CONFIG_DEVTMPFS_MOUNT=y

to landisk_defconfig fixes that.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
