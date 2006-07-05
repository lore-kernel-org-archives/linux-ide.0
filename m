From: "Yan Luo" <zaizailuo@gmail.com>
Subject: Via IDE Bus Master controller IRQ number?
Date: Tue, 4 Jul 2006 21:31:27 -0400
Message-ID: <2f9b85b70607041831kaccea64o8d1a4b2309ce03d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:14056 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932398AbWGEBcA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 21:32:00 -0400
Received: by py-out-1112.google.com with SMTP id t32so2017413pyc
        for <linux-ide@vger.kernel.org>; Tue, 04 Jul 2006 18:31:27 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I have a question on enabling DMA access to IDE hard disk using VIA
vt82c686 chipset. My platform is a single board computer AAEON
PCM-6892 (VIA C3 CPU, via vt82c686b chipset). I am working on a
IDE-DMA port to RTEMS.

I am trying to find which irq number the IDE bus master controller
(part of the vt82c686 chipset) uses. I read out PCI_INTERRUPT_PIN and
PCI_INTERRUPT_LINE from its PCI configuration space. The
PCI_INTERRUPT_PIN is found to be '0', and PCI_INTERRUPT_LINE as 'FF'. Does
it mean this controller does not support interrupt? If so, who do I
tell if the DMA transfer finishes??

The experiment I did is to send ATA_COMMAND_READ_DMA to IDE0 command
register (I/O address  0x1F7) and then write '1' to the last bit of
IDE BM controller's command register (first register in the BM IDE I/O
space) to start DMA transfer. But the DMA transfer hangs the system. I
have installed an interrupt handler for IRQ 14, which seems not
triggered.

Please advise.

Thanks,
Yan
