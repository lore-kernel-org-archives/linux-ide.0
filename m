From: Raja Appuswamy <raja.btl@gmail.com>
Subject: regarding NCQ implementation
Date: Fri, 5 Aug 2011 15:54:15 +0200
Message-ID: <CAJbmVfc8icgOciAi=d8XCUJhPok3G8r6TTk7utZgoFZ5Y=AYRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:33285 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867Ab1HENyQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Aug 2011 09:54:16 -0400
Received: by qwk3 with SMTP id 3so1531344qwk.19
        for <linux-ide@vger.kernel.org>; Fri, 05 Aug 2011 06:54:15 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hey guys,
   Over the past few days i've been trying to work on modifying the
AHCI driver for an experimental research operating system to support
NCQ. I already have a fully functional AHCI driver without command
queuing. But when i try to  READ FPDMA QUEUED command instead of the
READ DMA command, i get an interrupt with the P0IS register containing
the mask 0x45000008 (TFES, OFS and SDBS bits set). SERR reports
3000400 which is a protocol violation error with the DIAG field
reporting an unknown FIS.
On dumping the log page, i get 41h as status (DRDY and ATA_ERR if i am
right)  and 84h as
feature/error. The non-ncq driver works just fine without any issues
and there is absolutely no way the hardware is at fault this time. I
have checked out the linux code and a 84h error refers to the ICRC and
ATA_ABORTED bits if i am not mistaken. I would really appreciate any
help from devs regarding how to debug this issue further. Also, are
any of the other values i get back from REAL LOG EXT useful for
debugging? If so, how do i interpret them?  I know this is not a linux
related question. So if you think i should be targeting a different
mailing list, i'd really appreciate it if you could please point me in
the right direction and i'll definitely stop bugging you guys.
Thanks in advance,
Raja
