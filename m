From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_pcmcia/ide-cs: move IDs table to
 <linux/pata_pcmcia_ids.h>
Date: Thu, 13 Oct 2011 13:55:12 +0100
Message-ID: <20111013135512.42719bcf@lxorguk.ukuu.org.uk>
References: <201110131312.14498.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201110131312.14498.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, 13 Oct 2011 13:12:14 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] pata_pcmcia/ide-cs: move IDs table to <linux/pata_pcmcia_ids.h>
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ata/pata_pcmcia.c       |   74 +---------------------------------------
>  drivers/ide/ide-cs.c            |   74 +---------------------------------------
>  include/linux/pata_pcmcia_ids.h |   70 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 75 insertions(+), 143 deletions(-)

Acked-by: Alan Cox <alan@linux.intel.com>
