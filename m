From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: HPA and failed opcode was: 0x37 ?
Date: Tue, 30 Jan 2007 17:46:16 +0100
Message-ID: <45BF7658.1090204@imc-berlin.de>
References: <45BF5003.3000503@imc-berlin.de> <20070130164401.295f9913@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:4177 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965578AbXA3QqS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 11:46:18 -0500
In-Reply-To: <20070130164401.295f9913@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan,

>> hda: Host Protected Area detected.
>>         current capacity is 78140160 sectors (40007 MB)
>>         native  capacity is 185074430006016 sectors (94758108163 MB)
> 
> This comes from the identify data (bit 10 of the
> cfs_enable_1/command_set_1 fields in drivers ide) indicate the drive has
> an HPA so we try and read it. As there is no error report it seems the
> drive replied fine and we turn it into a rather bizarre value, but all our
> endian and the like code appears correct here.
> 
> Is your IDE controller LBA48 capable ?

Well TBH I have no contoller. As I said I am using an embedded ARM board.
The HDD is connected via a FPGA. The internal HDD registers simply memory
mapped. Works fine. Usually. By now we seem to have trouble with that
Seagate drive...

So I don't see any problems with LBA48 ...

>> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
>> hda: task_no_data_intr: error=0x04 { DriveStatusError }
>> ide: failed opcode was: 0x37
> 
> We try and set the disk size to 185074430006016 sectors.. it objects
> unsuprisingly to this proposal.
;-)

Steven
