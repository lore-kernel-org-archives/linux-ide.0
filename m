From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] ide_tape: convert jiffies with jiffies_to_msecs
Date: Fri, 20 Mar 2015 10:54:49 +0100
Message-ID: <CAMuHMdWAfTusuuwZsSAjeVH_KVcetw9jwh_HL-Ta3eZjBTE3Vw@mail.gmail.com>
References: <1425379971-12641-1-git-send-email-hofrat@osadl.org>
	<54F5C101.9070409@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54F5C101.9070409@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, "David S. Miller" <davem@davemloft.net>, Joe Perches <joe@perches.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Tue, Mar 3, 2015 at 3:11 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>>   drivers/ide/ide-tape.c |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>
>
>    The driver is called ide-tape.c, yet your subject prefix is "ide_tape:".

FWIW, modprobe considers dashes and underscores identical,
so if it's compiled as a module, it can be loaded using both
"modprobe ide-tape.ko" and "modprobe ide_tape.ko".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
