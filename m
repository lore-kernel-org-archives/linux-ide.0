From: "kiran vedere" <vederekiran@gmail.com>
Subject: libata-core.c
Date: Wed, 24 Sep 2008 18:11:38 -0400
Message-ID: <679aeaf0809241511yf6cd812oa1ed5f3a1a37cfba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:60813 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756132AbYIXWLk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Sep 2008 18:11:40 -0400
Received: by wf-out-1314.google.com with SMTP id 27so156782wfd.4
        for <linux-ide@vger.kernel.org>; Wed, 24 Sep 2008 15:11:39 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi Jeff:

I am working on enabling Compact Flash support on an ARM embedded
Platform. I implemented the Host Controller driver for the ARM
Platform. I was going through the linux pcmcia subsystem and found
that there is an existing pata_pcmcia.c client driver to support
ATA/IDE emulation for PCMCIA/Compact Flash cards. This uses the
libata-core.c helper library for ATA. I had a couple of questions in
regard to this which I thought you might be the best person to ask:

1. Is this library generic for all platforms or is it specific to PC
because it seems to reference PCI in some places. If I have my host
controller driver, is the current pata_pcmcia.c (and libata helper
libraries) sufficient to use the Compact Flash in True-IDE mode or
something additional is needed.
2. The CF TrueIDE mode supports Multiword DMA and Ultra DMA modes of
data transfer. Your libata-core.c seems to have support for these
modes. However I assume I will need to provide the DMA Buffer to
facilitate this. Do I need to provide call back functions to do this
or I need to implement a seperate Client Driver to support these
modes? I assume the pata_pcmcia.c uses PIO mode by default? Correct me
if I am wrong.

Thanks in advance.

Regards,
kiran
