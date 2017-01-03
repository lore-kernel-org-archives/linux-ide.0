From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/3] ata: add m68k/Atari Falcon PATA support
Date: Tue, 3 Jan 2017 11:49:16 +0100
Message-ID: <CAMuHMdVpnhTNSRZ1h-q8+d0wjDKSHtev0eyVoVxYWhf0DCD+zg@mail.gmail.com>
References: <CGME20161230140139epcas5p160eda5a6a77be084e21f12002c85cc2a@epcas5p1.samsung.com>
 <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tejun Heo <tj@kernel.org>, Michael Schmitz <schmitzmic@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hi Bartlomiej,

On Fri, Dec 30, 2016 at 3:01 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> This patchset adds m68k/Atari Falcon PATA support to libata.

Thanks for your series!

That leaves us with 4 to go ;-)

    CONFIG_BLK_DEV_GAYLE
    CONFIG_BLK_DEV_BUDDHA
    CONFIG_BLK_DEV_MAC_IDE
    CONFIG_BLK_DEV_Q40IDE

Note that using libata instead of the legacy IDE driver increases kernel size.

After enabling libata:

    CONFIG_ATA=y
    CONFIG_ATA_VERBOSE_ERROR=y
    CONFIG_ATA_SFF=y
    CONFIG_PATA_FALCON=y

an atari_defconfig kernel grew by:

    add/remove: 775/0 grow/shrink: 753/41 up/down: 98999/-242 (98757)

After disabling CONFIG_IDE:

    add/remove: 0/589 grow/shrink: 0/12 up/down: 0/-62835 (-62835)

So the net result is:

    add/remove: 775/589 grow/shrink: 749/51 up/down: 98886/-62964 (35922)

Disabling CONFIG_ATA_VERBOSE_ERROR saved 1380 bytes, which is less than the
value advertised by Kconfig (6KB).

> The major difference in the new libata's pata_falcon host
> driver when compared to legacy IDE's falconide host driver is
> that we are using polled PIO mode and thus avoiding the need
> for STDMA locking magic altogether.

I'll let the Atari experts (Michael?) comment on that...

> Tested under ARAnyM emulator.

Works indeed fine on ARAnyM.
Unfortunately I can't test it on real hardware...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
