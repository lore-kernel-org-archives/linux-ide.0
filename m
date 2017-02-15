From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/3] ata: add m68k/Atari Falcon PATA support
Date: Wed, 15 Feb 2017 09:45:53 +0100
Message-ID: <CAMuHMdWX-PT_8a==rqAvc5Hx_1PNWPwvLGPeERUXvsMcEarziQ@mail.gmail.com>
References: <CGME20161230140139epcas5p160eda5a6a77be084e21f12002c85cc2a@epcas5p1.samsung.com>
 <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:34176 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdBOIpz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2017 03:45:55 -0500
In-Reply-To: <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tejun Heo <tj@kernel.org>, Michael Schmitz <schmitzmic@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>

On Fri, Dec 30, 2016 at 3:01 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> This patchset adds m68k/Atari Falcon PATA support to libata.
> The major difference in the new libata's pata_falcon host
> driver when compared to legacy IDE's falconide host driver is
> that we are using polled PIO mode and thus avoiding the need
> for STDMA locking magic altogether.
>
> Tested under ARAnyM emulator.
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>
>
> Bartlomiej Zolnierkiewicz (3):
>   ata: allow subsystem to be used on m68k arch
>   ata: pass queued command to ->sff_data_xfer method
>   ata: add Atari Falcon PATA controller driver

drivers/ata/pata_falcon.c:57:18: error: 'struct request' has no member
named 'cmd_type'
drivers/ata/pata_falcon.c:57:32: error: 'REQ_TYPE_FS' undeclared
(first use in this function)

http://kisskb.ellerman.id.au/kisskb/buildresult/12936876/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
