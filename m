From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Why toggle_bounce only for disks?
Date: Fri, 19 Aug 2005 12:07:44 +0200
Message-ID: <58cb370e05081903073d9a2b73@mail.gmail.com>
References: <20050806235615.GK3505@roadwarrior.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.198]:57726 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964922AbVHSKHs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Aug 2005 06:07:48 -0400
Received: by nproxy.gmail.com with SMTP id x37so161803nfc
        for <linux-ide@vger.kernel.org>; Fri, 19 Aug 2005 03:07:44 -0700 (PDT)
In-Reply-To: <20050806235615.GK3505@roadwarrior.mcmartin.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: linux-ide@vger.kernel.org, parisc-linux@lists.parisc-linux.org, Jens Axboe <axboe@suse.de>

Hi,

http://www.ussg.iu.edu/hypermail/linux/kernel/0209.1/1074.html

Jens, is this still true??

Bartlomiej

On 8/7/05, Kyle McMartin <kyle@parisc-linux.org> wrote:
> Ahoi,
> 
> The following patch fixes a crash caused by attempting to bounce buffer
> when an IDE CD-ROM is used on a machine with an IO-MMU. [At least, this
> patch fixes things so I can use my IDE CD-ROM behind an ns87415 on a
> HP PA-RISC workstation.]
> 
> Why was this only allowed for disks?
> 
> --- a/drivers/ide/ide-lib.c   18 Jul 2005 18:46:30 -0000
> +++ b/drivers/ide/ide-lib.c   6 Aug 2005 20:28:04 -0000
> @@ -410,7 +410,7 @@ void ide_toggle_bounce(ide_drive_t *driv
>  {
>         u64 addr = BLK_BOUNCE_HIGH;     /* dma64_addr_t */
> 
> -       if (on && drive->media == ide_disk) {
> +       if (on) {
>                 if (!PCI_DMA_BUS_IS_PHYS)
>                         addr = BLK_BOUNCE_ANY;
>                 else if (HWIF(drive)->pci_dev)
> 
> Cheers,
> --
> Kyle McMartin
