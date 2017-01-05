From: Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH 0/3] ata: add m68k/Atari Falcon PATA support
Date: Fri, 6 Jan 2017 10:01:49 +1300
Message-ID: <CAOmrzkJP6s34DPOHd4OFFx=CXko35Kt=CfeDZthOPvKDJy-9YA@mail.gmail.com>
References: <CGME20161230140139epcas5p160eda5a6a77be084e21f12002c85cc2a@epcas5p1.samsung.com>
 <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tejun Heo <tj@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, Linux/m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hi Bartlomiej,

thanks for caring to support our legacy PATA systems!

On Sat, Dec 31, 2016 at 3:01 AM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Hi,
>
> This patchset adds m68k/Atari Falcon PATA support to libata.
> The major difference in the new libata's pata_falcon host
> driver when compared to legacy IDE's falconide host driver is
> that we are using polled PIO mode and thus avoiding the need
> for STDMA locking magic altogether.

I don't suppose this is the default libata mode for PIO?

How is polling implemented in libata? Sleeping for something
approximating the average seek latency shouldn't hurt but spinning
wont be acceptable for a low performance single CPU architecture like
the Falcon.

> Tested under ARAnyM emulator.

Not sure that the emulator is really feature complete enough - I'll
get this tested on my Falcon in the next few weeks. I'm a bit worried
about IDE still generating interrupts on seek completion (did you spot
anything like that, Geert?).

Cheers,

  Michael
