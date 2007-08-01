From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_sis: fix MWDMA for <= UDMA66 chipsets and UDMA for
 UDMA33 chipsets
Date: Wed, 01 Aug 2007 10:02:36 -0400
Message-ID: <46B0927C.10408@garzik.org>
References: <200707312202.41856.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933069AbXHAOCy@vger.kernel.org>
In-Reply-To: <200707312202.41856.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> * Fix MWDMA timings setup in sis_old_set_dmamode() and sis_66_set_dmamode().
> 
>   The old timings were overclocked (even worse behavior than sis5513 IDE driver
>   which depends on BIOS to program correct timings), the new timings are taken
>   from the datasheet (they match timings from ATA spec).
> 
> * Fix UDMA timings setup in sis_old_set_dmamode().
> 
>   Misplaced pci_write_config_word() call resulted in UDMA timings never
>   being set.
> 
> * Fix comments for sis_133_early_set_dmamode() and sis_133_set_dmamode():
>   - only the former function handles early SiS 961 bridges
>   - both functions lack MWDMA timings setup
> 
> * Fix typos in sis_100_set_piomode() and sis_133_set_piomode() comments.
> 
> * Bump driver version.
> 
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> Sergei: Yes, I'm working on sis5513 IDE driver. :)
> 
>  drivers/ata/pata_sis.c |   20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)

applied to #upstream-fixes
