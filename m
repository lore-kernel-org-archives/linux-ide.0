From: Michael Schmitz <schmitz@biophys.uni-duesseldorf.de>
Subject: Re: [PATCH 1/4] ide: remove IDE_ARCH_INTR
Date: Thu, 29 Jan 2009 05:22:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901290521300.7218@zirkon.biophys.uni-duesseldorf.de>
References: <20090127180246.28089.2981.sendpatchset@localhost.localdomain>
 <20090127180252.28089.70513.sendpatchset@localhost.localdomain>
 <393174.25588.qm@web52403.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-m68k-owner@vger.kernel.org>
In-reply-to: <393174.25588.qm@web52403.mail.re2.yahoo.com>
Sender: linux-m68k-owner@vger.kernel.org
To: "David D. Kilzer" <ddkilzer@kilzer.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Schmitz <schmitz@debian.org>, linux-m68k@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,

> 
> -            (void)ide_ack_intr(hwif);
> +            if (hwif->ack_intr(hwif))
> +                hwif->ack_intr(hwif);
> 
> Shouldn't that be:
> 
> -            (void)ide_ack_intr(hwif);
> +            if (hwif->ack_intr)
> +                hwif->ack_intr(hwif);

Seconded. No point in ack'ing the int twice (not to mention the other side 
effects).

	Michael

