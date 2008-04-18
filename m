From: "Edward Shao" <laface.tw@gmail.com>
Subject: set pio timing in pata_atiixp.c
Date: Fri, 18 Apr 2008 13:21:54 +0800
Message-ID: <ff05f3d00804172221x232ae8bdx25b4e0f979d245d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.242]:61470 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751158AbYDRFVy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Apr 2008 01:21:54 -0400
Received: by rv-out-0506.google.com with SMTP id k29so215966rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 17 Apr 2008 22:21:54 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,
I read linux-2.6.25 stable

In function drivers/ata/pata_atiixp.c:atiixp_set_pio_timing()
	I see
 	pci_read_config_word(pdev, ATIIXP_IDE_PIO_TIMING, &pio_timing_data);
	pio_mode_data &= ~(0xFF << timing_shift);
	pio_mode_data |= (pio_timings[pio] << timing_shift);
	pci_write_config_word(pdev, ATIIXP_IDE_PIO_TIMING, pio_timing_data);

	but I think it should be

 	pci_read_config_word(pdev, ATIIXP_IDE_PIO_TIMING, &pio_timing_data);
	pio_timing_data &= ~(0xFF << timing_shift);
	pio_timing_data |= (pio_timings[pio] << timing_shift);
	pci_write_config_word(pdev, ATIIXP_IDE_PIO_TIMING, pio_timing_data);
	
	and I right?
-- 
Best Regards,
Edward
