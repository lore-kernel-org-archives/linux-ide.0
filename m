From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 12/33] docs: ide: convert docs to ReST and rename to *.rst
Date: Sun, 9 Jun 2019 09:50:21 +0200
Message-ID: <CAMuHMdV9Xy7MKAY9tU4WTe=tvuLpnXQE5GMNmtEXgCj6YNhRYg@mail.gmail.com>
References: <cover.1560045490.git.mchehab+samsung@kernel.org> <472757a7481a8645837092f0f257f37996af6299.1560045490.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <472757a7481a8645837092f0f257f37996af6299.1560045490.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Borislav Petkov <bp@alien8.de>, Jens Axboe <axboe@kernel.dk>, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>
List-Id: linux-ide@vger.kernel.org

On Sun, Jun 9, 2019 at 4:27 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
> The conversion is actually:
>   - add blank lines and identation in order to identify paragraphs;
>   - fix tables markups;
>   - add some lists markups;
>   - mark literal blocks;
>   - adjust title markups.
>
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

>  arch/m68k/q40/README                          |   2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
