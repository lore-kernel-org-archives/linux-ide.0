From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: rcar_sata DMA warnings on Salvator-X
Date: Fri, 26 Feb 2016 09:21:17 +0100
Message-ID: <CAMuHMdXkWTaJQaPj_J8z+7F7GoZhk33hNSiB-wMoNuoi7wawNw@mail.gmail.com>
References: <CAMuHMdU0=_TJVfy=-zXWHkfJSWH_fJULBrL8J9T60QS48WbYcQ@mail.gmail.com>
	<20160225214036.GI6092@mtj.duckdns.org>
	<CAOS58YMv+vBsCrG3ftJSPAxTXgo9gNmxaVeKv8xfNygJgrmSmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAOS58YMv+vBsCrG3ftJSPAxTXgo9gNmxaVeKv8xfNygJgrmSmA@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org, Harvey Hunt <harvey.hunt@imgtec.com>
List-Id: linux-ide@vger.kernel.org

Hi Tejun,

On Thu, Feb 25, 2016 at 10:42 PM, Tejun Heo <tj@kernel.org> wrote:
> On Thu, Feb 25, 2016 at 4:40 PM, Tejun Heo <tj@kernel.org> wrote:
>> Is this the problem fixed by the following patch from Harvey?
>>
>>  http://lkml.kernel.org/g/CAMuHMdU0=_TJVfy=-zXWHkfJSWH_fJULBrL8J9T60QS48WbYcQ@mail.gmail.com
>
> Oops, I meant
>
> http://lkml.kernel.org/g/1456327003-16295-1-git-send-email-harvey.hunt@imgtec.com

Thanks, looks plausible, I'll give it a try.

Note that I couldn't reproduce this at will, so I'll just let you know if I
see it again, despite this patch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
