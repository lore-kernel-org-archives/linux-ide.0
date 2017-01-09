From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] libata-eh: Use switch() instead of sparse array for
 protocol strings
Date: Mon, 9 Jan 2017 16:40:19 +0100
Message-ID: <CAMuHMdW6KPq6-7vmpTTv_M30zbqkdVbewgaOaCqYT+UzXpGU9Q@mail.gmail.com>
References: <1483973368-6828-1-git-send-email-geert@linux-m68k.org> <20170109152319.GA12827@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170109152319.GA12827@mtj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hi Tejun,

On Mon, Jan 9, 2017 at 4:23 PM, Tejun Heo <tj@kernel.org> wrote:
> On Mon, Jan 09, 2017 at 03:49:28PM +0100, Geert Uytterhoeven wrote:
>> Replace the sparse 256-pointer array for looking up protocol strings by
>> a switch() statement to reduce kernel size.
>>
>> According to bloat-o-meter, this saves 910 bytes on m68k (32-bit), and
>> 1892 bytes on arm64 (64-bit).
>>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Gees, thanks for catching that.
>
> Applied to libata/for-4.11.

Thanks!

There are two more that annoy me, but I don't know how to fix them:

ata_scsi_rbuf                                  -    4096   +4096
ata_force_param_buf                            -    4096   +4096

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
