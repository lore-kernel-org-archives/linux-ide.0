From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH] ata: add Amiga Gayle PATA controller driver
Date: Mon, 12 Feb 2018 15:18:44 +0100
Message-ID: <CAOFm3uFP8bot3b6zRq5WBUxvr-u8TFbPfn4o5rOgRf4duSbOkQ@mail.gmail.com>
References: <CGME20180212134949epcas2p37f0bdae15608340bc21dbb2358db8df3@epcas2p3.samsung.com>
 <2188399.T539WJDZNr@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2188399.T539WJDZNr@amdc3058>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tejun Heo <tj@kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Michael Schmitz <schmitzmic@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Mon, Feb 12, 2018 at 2:49 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Add Amiga Gayle PATA controller driver. It enables libata support
> for the on-board IDE interfaces on some Amiga models (A600, A1200,
> A4000 and A4000T) and also for IDE interfaces on the Zorro expansion
> bus (M-Tech E-Matrix 530 expansion card).
>
> Thanks to John Paul Adrian Glaubitz and Michael Schmitz for help
> with testing the driver.
>
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

<snip>
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */

Do you mind using the new SDPX ids? (well not so new anymore). [1]

<snip>
> +
> +MODULE_AUTHOR("Bartlomiej Zolnierkiewicz");
> +MODULE_DESCRIPTION("low-level driver for Amiga Gayle PATA");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:amiga-gayle-ide");
> +MODULE_VERSION(DRV_VERSION);
>

.... and while doing it please make sure your MODULE_LICENSE matches
the license.
Here for instance it is not clear to me if this a GPL-2.0 or a GPL-2.0+


Thanks!
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
-- 
Cordially
Philippe Ombredanne

+1 650 799 0949 | pombredanne@nexB.com
DejaCode - What's in your code?! - http://www.dejacode.com
AboutCode - Open source for open source - https://www.aboutcode.org
nexB Inc. - http://www.nexb.com

CONFIDENTIALITY NOTICE:  This e-mail (including attachments) may
contain information that is proprietary or confidential. If you are
not the intended recipient or a person responsible for its delivery to
the intended recipient, do not copy or distribute it. Please
permanently delete the e-mail and any attachments, and notify us
immediately at (650) 799 0949.
