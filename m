From: Mathias Anselmann <mathias.anselmann@googlemail.com>
Subject: Failed to set xfermode DVR-215
Date: Wed, 4 Jan 2012 00:30:50 +0100
Message-ID: <20120103233050.GA30476@junkynutte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47411 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab2ACXda (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jan 2012 18:33:30 -0500
Received: by eekc4 with SMTP id c4so16285494eek.19
        for <linux-ide@vger.kernel.org>; Tue, 03 Jan 2012 15:33:29 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,
Since month I have an issue with my dvd writer: when I boot I (just
sometimes) get up to three times this message (currently using kernel
3.1.7):

ata4.00: failed to set xfermode (err_mask=0x4)

Here
https://bugs.archlinux.org/task/21606
I was told that this is a common problem with some Pioneer dvd writers
and can be fixed by you, here are my device Informations from dmesg:

ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATAPI: PIONEER DVD-RW  DVR-215, 1.22, max UDMA/66
ata4.00: configured for UDMA/6

So it would be great if you could add my device to this patch,
greetings
 Mathias Anselmann
