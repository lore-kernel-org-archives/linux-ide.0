From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Libata state machine error in 2.6.18.1
Date: Mon, 14 May 2007 12:38:55 -0400
Message-ID: <4648909F.7020809@garzik.org>
References: <DCEAAC0833DD314AB0B58112AD99B93B02E898EB@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38892 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754689AbXENQi7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 May 2007 12:38:59 -0400
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B02E898EB@ismail.innsys.innovsys.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rune Torgersen <runet@innovsys.com>
Cc: linux-ide@vger.kernel.org

Rune Torgersen wrote:
> Hi
> We're running 2.6.18 on an inhouse devloped embeded board.
> CPU is a Freescale 8280, and we have a SIL3124 controller talking to a
> Hitachi 320GB (Hitachi HDT725032VLA360) disk.
> 
> Once in a while we get the following error while formatiing the drive:
> 
> ata2: illegal qc_active transition (00000002->00000008)
> ata2.00: exception Emask 0x2 SAct 0x2 SErr 0x0 action 0x2 frozen
> ata2.00: tag 1 cmd 0x61 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
> ata2: soft resetting port
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
> ata2.00: revalidation failed (errno=-5)
> ata2: failed to recover some devices, retrying in 5 secs
> ata2: hard resetting port
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: configured for UDMA/100
> ata2: EH complete

What are the results from 2.6.22-rc1?

You're running an ancient kernel that has seen a great many bug fixes 
since 2.6.18.

	Jeff



