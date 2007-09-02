From: Tejun Heo <htejun@gmail.com>
Subject: Re: CF as IDE on ICH6M using libata
Date: Sun, 02 Sep 2007 22:08:45 +0900
Message-ID: <46DAB5DD.80807@gmail.com>
References: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:55282 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965116AbXIBNKJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 09:10:09 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1570979wah
        for <linux-ide@vger.kernel.org>; Sun, 02 Sep 2007 06:10:08 -0700 (PDT)
In-Reply-To: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eddie Hung <eddie.hung@gmail.com>
Cc: linux-ide@vger.kernel.org

Eddie Hung wrote:
> Hello everyone,
> 
> In the hope of making myself a cheap SSD, I decided to replace my IDE
> HDD on my IBM Thinkpad X41 (non tablet) with a generic CF-IDE adaptor,
> and a Sandisk Extreme IV 4Gb CF, for reasonable prices off ebay. This
> was partly influenced by the report that one X41 Tablet user had it
> working successfully: http://forum.thinkpads.com/viewtopic.php?t=41568
> (last post on that page)
> 
> As some of you may know, the X41 uses a SATA controller, which goes
> into a SATA-PATA bridge, and then connects to a PATA HDD. This is a
> strange setup, and may go some distance as to explaining why it
> doesn't work.
> 
> The first I tried was the Ubuntu Feisty LiveCD, which uses 2.6.20, and
> libata picks the drive up correctly. A hdparm -I showed that the
> device was currently running at mdma2 - which was not what I expected
> - the Sandisk, as garnered from review websites, supports UDMA. A
> quick hdparm -t also revealed that I was only getting about 6MB/s.
> 
> Nonetheless, I tried to partition the disk - at which point mkfs.ext3
> froze. Looking at dmesg, I saw some timeout commands, looking
> something like:
> ata1: port is slow to respond, please be patient (Status 0xd0)
> ata1: soft resetting port
> ata1: ... exception ... res 40/00:00:00:00:00/00:00:00:00:00/a0 Emask
> 0x4 (timeout)

>From 2.6.22, please post the boot log and full error log (dmesg result)
and the result of 'hdparm -I /dev/sda'.

I don't think the device supports UDMA.  Supported transfer modes are
indicated in the IDENTIFY page (hdparm -I) and libata/ide would use UDMA
if the device reports so.  There's no black magic there.

Regarding MWDMA2 not working, are you sure that windows uses mwdma2?
We've had quite some number of reports about broken mwdma2 and till now
we thought those devices were broken and black listed them but it's also
possible that mwdma2 mode programming or something else is broken in
ata_piix.  If so, it really needs fixing.

Thanks.

-- 
tejun
