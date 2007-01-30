From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: HPA and failed opcode was: 0x37 ?
Date: Tue, 30 Jan 2007 16:44:01 +0000
Message-ID: <20070130164401.295f9913@localhost.localdomain>
References: <45BF5003.3000503@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50794 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752666AbXA3QcK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 11:32:10 -0500
In-Reply-To: <45BF5003.3000503@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linux-ide@vger.kernel.org

> hda: max request size: 1024KiB

Sane so far, LBA48 disk

> hda: Host Protected Area detected.
>         current capacity is 78140160 sectors (40007 MB)
>         native  capacity is 185074430006016 sectors (94758108163 MB)

This comes from the identify data (bit 10 of the
cfs_enable_1/command_set_1 fields in drivers ide) indicate the drive has
an HPA so we try and read it. As there is no error report it seems the
drive replied fine and we turn it into a rather bizarre value, but all our
endian and the like code appears correct here.

Is your IDE controller LBA48 capable ?

> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }
> ide: failed opcode was: 0x37

We try and set the disk size to 185074430006016 sectors.. it objects
unsuprisingly to this proposal.

Alan
