From: "Dave Kelly" <dave@ravelox.co.uk>
Subject: Re: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
Date: Sat, 22 Oct 2005 08:09:42 -0700
Message-ID: <435A5636.6030801@ravelox.co.uk>
References: <435994C2.6090701@ravelox.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1";
	format="flowed"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:6289 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751230AbVJVPJu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 22 Oct 2005 11:09:50 -0400
Received: from ravelox.co.uk (localhost.localdomain [127.0.0.1])
	by ravelox.co.uk (8.13.1/8.13.1) with ESMTP id j9MF9lRG017459
	for <linux-ide@vger.kernel.org>; Sat, 22 Oct 2005 08:09:47 -0700
Received: from ravelox.co.uk (root@localhost)
	by ravelox.co.uk (8.13.1/8.13.1/Submit) with ESMTP id j9MF9krG017455
	for <linux-ide@vger.kernel.org>; Sat, 22 Oct 2005 08:09:47 -0700
In-Reply-To: <4359DD1F.9010507@gmx.de>
References: <4359DD1F.9010507@gmx.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

thomas schorpp wrote:

>>/var/log/messages starts to fill with:
>>
>>Oct 15 02:30:03 desktop kernel: end_request: I/O error, dev hdc, sector
>>5028
>>Oct 15 02:30:03 desktop kernel: hdc: command error: status=0x51 {
>>DriveReady SeekComplete Error }
>>Oct 15 02:30:03 desktop kernel: hdc: command error: error=0x54 {
>>AbortedCommand LastFailedSense=0x05 }
>>    
>>
>
>  
>
>>Oct 15 02:30:03 desktop kernel: ide: failed opcode was: unknown
>>
>>    
>>
>(busmaster dma transfer?)
>
>try disabling dma and/or try the ide-scsi driver and report
>
>  
>

I mentioned in my original message that I have already done this and 
there is no improvement.

>>/dev/hdc:
>>
>> Model=SONY DVD RW DRU-810A, FwRev=1.0a, SerialNo=815005574810A U30507
>>    
>>
>
>this is a lite-on OEM? got a SOHW-832 reporting some "drive confused"
>messages but no problems with reading, maybe nvidia driver code bugs.
>
>latest stable manufacturer firmware on the drive? use such rpc-1 cracks
>on your own risk.
>  
>

There is no other firmware version for this drive. The regular places 
for getting RPC-1 cracks is waiting for Sony to release an update so 
they can work out how to backup the original.

Thanks for replying,

Dave
