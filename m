From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: qc timeout on a marvell 88F6282 board
Date: Sun, 3 Jul 2011 15:52:56 +0300
Message-ID: <CAMAG_ef0y=Jg=8eQSWj_e8kwGAtFwJXsvPATiL1fkq57kVzubA@mail.gmail.com>
References: <4E0AEAB1.4090106@malgn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45435 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab1GCMw5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Jul 2011 08:52:57 -0400
Received: by vws1 with SMTP id 1so3172870vws.19
        for <linux-ide@vger.kernel.org>; Sun, 03 Jul 2011 05:52:56 -0700 (PDT)
In-Reply-To: <4E0AEAB1.4090106@malgn.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Kang <turquesa@malgn.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

2011/6/29 Richard Kang <turquesa@malgn.com>:
> Hello.
>
> I have a sil3132 pci-e card and a DB-88F6282-A-BP(Marvell development
> board based on Arm9).
> I compiled sata_sil24 driver as a module with a cross-compiler.
>
> But, when loading the driver, qc timeout error was occurred during
> ata_read_dev_id.
> What is wrong, IRQ or DMA ?
looks to me this is DMA issue, can you force pio mode? you can do that
by adding "libata.dma=0" to the kernel command line.
saeed

> I have 2.6.31.8
