From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] libata: Add Intel SCH PATA Support
Date: Tue, 06 May 2008 15:50:21 +0400
Message-ID: <482045FD.9000001@ru.mvista.com>
References: <20080505172356.636649e6@dxy.sh.intel.com>	<481EE284.2010708@ru.mvista.com>	<20080505224420.44730838@dxy.sh.intel.com>	<481F2144.5000409@ru.mvista.com> <20080506094131.4bd70c8a@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:54215 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753012AbYEFLu6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 May 2008 07:50:58 -0400
In-Reply-To: <20080506094131.4bd70c8a@dxy.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alek Du <alek.du@intel.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello.

Alek Du wrote:

> I modified the driver again according to comments from Sergei, please help to review it.

    You even were somewhat over-zealous. ;-)

> This patch adds Intel SCH chipsets (AF82US15W, AF82US15L, AF82UL11L) PATA controller
> support.

> Signed-off-by: Alek Du <alek.du@intel.com>

> diff --git a/drivers/ata/pata_sch.c b/drivers/ata/pata_sch.c
> new file mode 100644
> index 0000000..84a2384
> --- /dev/null
> +++ b/drivers/ata/pata_sch.c
> @@ -0,0 +1,244 @@
[...]
> +/**
> + *	sch_set_piomode - Initialize host controller PATA PIO timings
> + *	@ap: Port whose timings we are configuring
> + *	@adev: um

    Hm, I'm seing the same "um" un ata_piix, and wondering what it means. :-)
do_pata_set_dmamode at least calls this "drive in question"...

> + *
> + *	Set PIO mode for device, in host controller PCI config space.
> + *
> + *	LOCKING:
> + *	None (inherited from caller).
> + */
> +
> +static void sch_set_piomode(struct ata_port *ap, struct ata_device *adev)
> +{
> +	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
> +	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
> +	unsigned int port	= adev->devno ? D1TIM : D0TIM;
> +	unsigned int data;
> +
> +	pci_read_config_dword(dev, port, &data);
> +	/* see SCH datasheet page 351 */
> +	/* set PIO mode without PPE */
> +	data &= ~(PM | PPE);
> +	data |= pio;

    I didn't mean you shouldn't ever set PPE, what I meant was:

         if (adev->class == ATA_DEV_ATA)
                 data |= PPE;

MBR, Sergei
