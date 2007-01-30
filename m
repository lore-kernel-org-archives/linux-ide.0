From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Tue, 30 Jan 2007 16:32:34 +0900
Message-ID: <45BEF492.9000000@gmail.com>
References: <200612111003.39928.kovid@theory.caltech.edu> <4588877D.1000400@gmail.com> <20061220032941.GA8903@us.ibm.com> <4588B3D5.4030406@gmail.com> <20061221171035.GC6171@us.ibm.com> <20070130015507.GA30069@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:24544 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965417AbXA3Hcq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 02:32:46 -0500
Received: by wr-out-0506.google.com with SMTP id i22so1147637wra
        for <linux-ide@vger.kernel.org>; Mon, 29 Jan 2007 23:32:45 -0800 (PST)
In-Reply-To: <20070130015507.GA30069@us.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gary Hade <garyhade@us.ibm.com>
Cc: Kovid Goyal <kovid@theory.caltech.edu>, linux-ide@vger.kernel.org, lcm@us.ibm.com, Jeff Garzik <jgarzik@pobox.com>, konradr@us.ibm.com

Hello, Gary.

Gary Hade wrote:
>>> If they verify your fix (ie,
>>> GoVault sometimes take more than 150ms to transmit the first D2H Reg FIs
>>> after SRST), I'll push similar patch upstream.
>> Thanks.  If you think that changes to increase the delays are
>> the way to go (at least until we can find a better solution)
>> I can provide patches.
> 
> Tejun, 
> I haven't heard anything from you on this so I'm including a delay
> increase patch against 2.6.20-rc6 for the 'ata-piix' case below.  
> I hope that you, Jeff, and others find this acceptable.

Sorry about being unresponsive.  The thing is that the change adds
unnecessary 2 secs of delay to a lot of other normal device-not-present
cases, so I was hesitant to ack the patch.  I'll give it more thoughts
(and respond timely this time :-)

> With respect to the 'ahci' case w/2.6.20-rc6 the GoVault device is 
> useable following boot although the below messages are being logged 
> during initialization.  Please let me know if you have any thoughts 
> on this.  
>   scsi1 : ahci
>   ata2: softreset failed (port busy but CLO unavailable)
>   ata2: softreset failed, retrying in 5 secs
>   ata2: port is slow to respond, please be patient (Status 0x80)
>   ata2: port failed to respond (30 secs, Status 0x80)
>   ata2: COMRESET failed (device not ready)
>   ata2: hardreset failed, retrying in 5 secs
>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>   ata2.00: ATAPI, max UDMA/66
>   ata2.00: configured for UDMA/66

The above should have been fixed in 2.6.20-rc6.  Please test it.  It was
caused by the ahci driver incorrectly clearing ahci CAP register and
fixed recently.

Thanks.

-- 
tejun
