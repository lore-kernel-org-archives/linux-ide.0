From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 0/3] ata: add m68k/Atari Falcon PATA support
Date: Mon, 09 Jan 2017 17:11:12 +0100
Message-ID: <3908219.8toGAOhnv9@amdc3058>
References: <CGME20161230140139epcas5p160eda5a6a77be084e21f12002c85cc2a@epcas5p1.samsung.com>
 <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
 <CAMuHMdVpnhTNSRZ1h-q8+d0wjDKSHtev0eyVoVxYWhf0DCD+zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAMuHMdVpnhTNSRZ1h-q8+d0wjDKSHtev0eyVoVxYWhf0DCD+zg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tejun Heo <tj@kernel.org>, Michael Schmitz <schmitzmic@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org


Hi,

On Tuesday, January 03, 2017 11:49:16 AM Geert Uytterhoeven wrote:
> Hi Bartlomiej,
> 
> On Fri, Dec 30, 2016 at 3:01 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > This patchset adds m68k/Atari Falcon PATA support to libata.
> 
> Thanks for your series!
> 
> That leaves us with 4 to go ;-)
> 
>     CONFIG_BLK_DEV_GAYLE
>     CONFIG_BLK_DEV_BUDDHA
>     CONFIG_BLK_DEV_MAC_IDE
>     CONFIG_BLK_DEV_Q40IDE

They should be easy to port to libata, one just needs to remember to
use ->qc_defer for ports that require serialization.

> Note that using libata instead of the legacy IDE driver increases kernel size.
> 
> After enabling libata:
> 
>     CONFIG_ATA=y
>     CONFIG_ATA_VERBOSE_ERROR=y
>     CONFIG_ATA_SFF=y
>     CONFIG_PATA_FALCON=y
> 
> an atari_defconfig kernel grew by:
> 
>     add/remove: 775/0 grow/shrink: 753/41 up/down: 98999/-242 (98757)
> 
> After disabling CONFIG_IDE:
> 
>     add/remove: 0/589 grow/shrink: 0/12 up/down: 0/-62835 (-62835)
> 
> So the net result is:
> 
>     add/remove: 775/589 grow/shrink: 749/51 up/down: 98886/-62964 (35922)

SATA-specific code is not needed on legacy PATA systems so it should be
possible to reduce the size by adding new config option (i.e. SATA_HOST) and:

- covering SATA only code with CONFIG_SATA_HOST ifdefs

- making SATA_HOST to be selected by SATA host drivers in drivers/ata/KConfig

> Disabling CONFIG_ATA_VERBOSE_ERROR saved 1380 bytes, which is less than the
> value advertised by Kconfig (6KB).

If it is only ~1kB nowadays I would vote for making the error logging always
verbose and just removing CONFIG_ATA_VERBOSE_ERROR, Tejun?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
