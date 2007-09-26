From: "Berck E. Nash" <flyboy@gmail.com>
Subject: Re: 2.6.23-rc7-mm1 AHCI ATA errors -- won't boot
Date: Wed, 26 Sep 2007 08:22:33 -0600
Message-ID: <46FA6B29.3030807@gmail.com>
References: <46F7FBCB.4030803@gmail.com> <46F9E2CB.9000002@garzik.org> <46FA2E84.90708@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:56991 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760442AbXIZOWl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Sep 2007 10:22:41 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2803236wah
        for <linux-ide@vger.kernel.org>; Wed, 26 Sep 2007 07:22:41 -0700 (PDT)
In-Reply-To: <46FA2E84.90708@t-online.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bernd Schmidt <bernds_cb1@t-online.de>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Bernd Schmidt wrote:
> One of these appears in my system as well (ASUS P5W-DH Deluxe
> mainboard).  Here's the hdparm output:

Yup, same mainboard here.

> Since about 2.6.17 or 2.6.18, it has been causing long delays while
> booting:
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: qc timeout (cmd 0xec)
> ata2.00: failed to IDENTIFY (I/O error, err_mask=0x5)
> ata2: port is slow to respond, please be patient (Status 0x80)
> ata2: COMRESET failed (errno=-16)
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: ATA-6: Config  Disk, RGL10364, max UDMA/133
> ata2.00: 640 sectors, multi 1: LBA
> ata2.00: configured for UDMA/133

And yup, same problem with the painful boot delays since 2.6.18.  Tejun
indicated that a fix would get merged with 2.6.23, but that didn't
happen.  Here's hoping something makes it into .24!

Berck
