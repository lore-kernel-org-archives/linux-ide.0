From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/1] IDE: fix ide.h compiler warning
Date: Fri, 21 Mar 2008 21:10:29 +0300
Message-ID: <47E3FA15.9000008@ru.mvista.com>
References: <1205683318-1409-1-git-send-email-jirislaby@gmail.com> <200803181419.08687.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760650AbYCUSJ2@vger.kernel.org>
In-Reply-To: <200803181419.08687.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: do complete DMA setup in ->init_dma method (tak=
e 2)

> * Make ide_hwif_setup_dma() return an error value.

> * Pass 'const struct ide_port_info *d' instead of 'unsigned long dmab=
ase'
>   to ->init_dma method and make it return an error value.

> * Rename ide_get_or_set_dma_base() to ide_pci_dma_base(),
>   change ordering of its arguments and then export it.

> * Export ide_pci_set_master().

> * Do complete DMA setup inside ->init_dma method and update ->init_dm=
a
>   users accordingly.

> * Sanitize code for DMA setup in ide_init_port().

> v2:
> * Fix for CONFIG_BLK_DEV_IDEDMA_PCI=3Dn configs
>   (from Jiri Slaby <jirislaby@gmail.com>):

>   Fix following compiler warning by returning EINVAL:

>   In file included from ANYTHING-INCLUDING-IDE.H:45:
>   include/linux/ide.h: In function =E2=80=98ide_hwif_setup_dma=E2=80=99=
:
>   include/linux/ide.h:1022: warning: no return statement in function =
returning non-void

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
