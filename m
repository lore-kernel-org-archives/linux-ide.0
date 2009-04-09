From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 13/14] lemote: fixup for FUJITSU disk
Date: Thu, 09 Apr 2009 15:53:56 +0400
Message-ID: <49DDE1D4.9080601@ru.mvista.com>
References: <49DD83CA.9000704@lemote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:15351 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756838AbZDILxQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Apr 2009 07:53:16 -0400
In-Reply-To: <49DD83CA.9000704@lemote.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: yanhua <yanh@lemote.com>
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>, =?GB2312?B?xe3Bwb31?= <penglj@lemote.com>, "zhangfx@lemote.com" <zhangfx@lemote.com>, linux-ide@vger.kernel.org

Hello.

yanhua wrote:

   The patch description wouldn't hurt, i.e. why this fixup is needed...

> diff --git a/drivers/ide/amd74xx.c b/drivers/ide/amd74xx.c
> index 77267c8..51b888f 100644
> --- a/drivers/ide/amd74xx.c
> +++ b/drivers/ide/amd74xx.c

   The IDE patches should be posted to linux-ide mail list.

> @@ -23,6 +23,11 @@
> 
> #define DRV_NAME "amd74xx"
> 
> +static const char *am74xx_quirk_drives[] = {
> + "FUJITSU MHZ2160BH G2",
> + NULL
> +};
> +
> enum {
> AMD_IDE_CONFIG = 0x41,
> AMD_CABLE_DETECT = 0x42,
> @@ -112,6 +117,20 @@ static void amd_set_pio_mode(ide_drive_t *drive,
> const u8 pio)
> amd_set_drive(drive, XFER_PIO_0 + pio);

   Your patches are seriously whitespace-damaged, i.e. all tabs seem to be
collapsed to a single space. You'll have to find a way to avoid that...

> }
> 
> +static void amd_quirkproc(ide_drive_t *drive, const u8 pio)

   Have you tried to compile this? The quirkproc() method only has one parameter.

> +{
> + const char **list, *m = (char *)&drive->id[ATA_ID_PROD];
> +
> + for (list = am74xx_quirk_drives; *list != NULL; list++)
> + if (strstr(m, *list) != NULL) {
> + drive->quirk_list = 2;
> + return;
> + }
> +
> + drive->quirk_list = 0;
> +
> +}
> +
> static void amd7409_cable_detect(struct pci_dev *dev)
> {
> /* no host side cable detection */
> @@ -194,6 +213,7 @@ static void __devinit init_hwif_amd74xx(ide_hwif_t
> *hwif)
> static const struct ide_port_ops amd_port_ops = {
> .set_pio_mode = amd_set_pio_mode,
> .set_dma_mode = amd_set_drive,
> + .quirkproc = amd_quirkproc,
> .cable_detect = amd_cable_detect,
> };
> 

MBR, Sergei
