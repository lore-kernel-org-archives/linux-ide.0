From: Jeff Garzik <jeff@garzik.org>
Subject: Re: set pio timing in pata_atiixp.c
Date: Fri, 18 Apr 2008 02:30:02 -0400
Message-ID: <48083FEA.6050305@garzik.org>
References: <ff05f3d00804172221x232ae8bdx25b4e0f979d245d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050305020809040306080807"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37988 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752868AbYDRGaF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Apr 2008 02:30:05 -0400
In-Reply-To: <ff05f3d00804172221x232ae8bdx25b4e0f979d245d2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Edward Shao <laface.tw@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

This is a multi-part message in MIME format.
--------------050305020809040306080807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Edward Shao wrote:
> Hi all,
> I read linux-2.6.25 stable
> 
> In function drivers/ata/pata_atiixp.c:atiixp_set_pio_timing()
> 	I see
>  	pci_read_config_word(pdev, ATIIXP_IDE_PIO_TIMING, &pio_timing_data);
> 	pio_mode_data &= ~(0xFF << timing_shift);
> 	pio_mode_data |= (pio_timings[pio] << timing_shift);
> 	pci_write_config_word(pdev, ATIIXP_IDE_PIO_TIMING, pio_timing_data);
> 
> 	but I think it should be
> 
>  	pci_read_config_word(pdev, ATIIXP_IDE_PIO_TIMING, &pio_timing_data);
> 	pio_timing_data &= ~(0xFF << timing_shift);
> 	pio_timing_data |= (pio_timings[pio] << timing_shift);
> 	pci_write_config_word(pdev, ATIIXP_IDE_PIO_TIMING, pio_timing_data);

Yes, it certainly appears you noticed a bug...

Presumably the attached patch fixes?

	Jeff




--------------050305020809040306080807
Content-Type: text/plain;
 name="patch.atiixp-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.atiixp-fix"

diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 408bdc1..780144f 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -93,8 +93,8 @@ static void atiixp_set_pio_timing(struct ata_port *ap, struct ata_device *adev,
 	pci_write_config_word(pdev, ATIIXP_IDE_PIO_MODE, pio_mode_data);
 
 	pci_read_config_word(pdev, ATIIXP_IDE_PIO_TIMING, &pio_timing_data);
-	pio_mode_data &= ~(0xFF << timing_shift);
-	pio_mode_data |= (pio_timings[pio] << timing_shift);
+	pio_timing_data &= ~(0xFF << timing_shift);
+	pio_timing_data |= (pio_timings[pio] << timing_shift);
 	pci_write_config_word(pdev, ATIIXP_IDE_PIO_TIMING, pio_timing_data);
 }
 

--------------050305020809040306080807--
