From: Frank-Michael Fischer <fmfischer@gmx.net>
Subject: ATA burner problem under 2.6
Date: Tue, 10 Aug 2004 09:53:57 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41187F15.4040706@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop.gmx.de ([213.165.64.20]:29356 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261500AbUHJHyF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Aug 2004 03:54:05 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: celestar <celestar@t-online.de>

when using kernel 2.6.5 the following command on any DVD:

dd if=/dev/hdc of=test.iso bs=2048

uses almost 6 times as much system time compared to:

dd if=/dev/sr0 of=test.iso bs=2048 under 2.4.21 (ide-scsi, identical 
hardware)

Moreover: when repeating the 2.6.5 dd command a couple of times the 
system comes to a complete lockup, with no logged error messages 
whatsoever. This never happens under 2.4.21. But I can reproduce this 
behaviour on another PC.

Another related problem:

When ripping an audio CD under 2.4.21 I get perfect results using cdrdao 
with --paranioa-mode 0. Ripping the same CD under 2.6.5 requires 
--paranioa-mode 3.

Is this a known bug of 2.6 kernels?

Regards,

Frank-Michael Fischer

