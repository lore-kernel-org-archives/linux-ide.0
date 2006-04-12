From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: libata-pata works on ICH4-M
Date: Wed, 12 Apr 2006 11:55:43 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0604121153060.12544@yvahk01.tjqt.qr>
References: <443B9EBB.6010607@gmx.net>  <Pine.LNX.4.61.0604112044340.25940@yvahk01.tjqt.qr>
 <1144832990.1952.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from linux01.gwdg.de ([134.76.13.21]:39908 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932125AbWDLJzw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Apr 2006 05:55:52 -0400
In-Reply-To: <1144832990.1952.20.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


>> So libata has the overhead of using SCSI commands? At least 
>> that's what it suggests to the normal user.
>
>libata issues standard ATA commands to disks and CF cards, and ATAPI to
>other devices. The current tree knows how to use LBA28 commands
>opportunistically so its generating basically the same command stream as
>the old IDE layer

That sounds nice, but does hdparm also work with it? The last time I 
tried to hdparm a SCSI-style device (usb flash disk, /dev/sda), it did 
not work, only sdparm did the job. Will this also be the case with libata?

(BTW, did you mean LBA48?)


Jan Engelhardt
-- 
