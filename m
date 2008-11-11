From: Tejun Heo <tj@kernel.org>
Subject: Re: Kernel 2.6.27: Problems with DVD drive/nVidia MCP51
Date: Tue, 11 Nov 2008 17:56:29 +0900
Message-ID: <491948BD.7040800@kernel.org>
References: <490B0FE7.1020107@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50040 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755846AbYKKI4i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Nov 2008 03:56:38 -0500
In-Reply-To: <490B0FE7.1020107@uwaterloo.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elad Lahav <elahav@uwaterloo.ca>
Cc: linux-ide@vger.kernel.org

Elad Lahav wrote:
> After upgrading from 2.6.26.5 to 2.6.27.4, my DVD drive started having
> problems during boot time. Here is the relevant part from dmesg:
> 
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata2.00: ATAPI: HL-DT-ST DVD+/-RW GSA-T11N, A103, max UDMA/33
> ata2.00: applying bridge limits
> ata2.00: Drive reports diagnostics failure. This may indicate a drive
> ata2.00: fault or invalid emulation. Contact drive vendor for information.
> ata2.00: configured for UDMA/33
> scsi 0:0:0:0: Direct-Access     ATA      ST3250820AS      3.AD PQ: 0
> ANSI: 5
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata2.00: cmd a0/00:00:00:24:00/00:00:00:00:00/a0 tag 0 pio 36 in
>          cdb 12 00 00 00 24 00 00 00  00 00 00 00 00 00 00 00
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata2.00: status: { DRDY }
> ata2: hard resetting link
> [continue ad inifitum....]
> 
> The drive is reported as "HL-DT-ST DVD+/-RW GSA-T11N, A103", connected
> to an nVidia MCP51 controller. Googling around, I found similar
> complaints in the past for other nVidia controllers using the sata_nv
> driver (though I couldn't find anything about the MCP51). I tried
> compiling the version of sata_nv that comes with 2.6.26.5, but that did
> not solve my problems.
> 
> I can provide further details if necessary.

Does 2.6.27.5 make any difference?

-- 
tejun
