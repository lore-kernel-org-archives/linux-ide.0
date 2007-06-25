From: Tejun Heo <htejun@gmail.com>
Subject: Re: Porblem in sata_sil24
Date: Tue, 26 Jun 2007 00:21:15 +0900
Message-ID: <467FDD6B.2070309@gmail.com>
References: <20070625125733.M79854@csie.ntu.edu.tw> <467FBEAA.4090101@gmail.com> <467FC076.70102@gmail.com> <20070625145433.M87750@csie.ntu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:31027 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755869AbXFYPVX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jun 2007 11:21:23 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1854187wah
        for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2007 08:21:22 -0700 (PDT)
In-Reply-To: <20070625145433.M87750@csie.ntu.edu.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: r93072 <r93072@csie.ntu.edu.tw>
Cc: linux-ide@vger.kernel.org

r93072 wrote:
> On Mon, 25 Jun 2007 22:17:42 +0900, Tejun Heo wrote
>> Tejun Heo wrote:
>>> r93072 wrote:
>>>> Hello,
>>>>    I have some questions when using sata_sil24 for silicon image 3132.
>>>>    One port of this chip connects to silicon image 5723.  My kernel 
>>>>    version is 2.6.18.6.  When I turn on my eSATA device, some error 
>>>>    messages would be produced.
>>>>
>>>>     ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
>>>>     ata2: (irq_stat 0x00b00090, PHY RDY changed)
>>>>     ata2: waiting for device to spin up (8 secs)
>>>>     ata2: soft resetting port
>>>>     ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>>     ata2.00: qc timeout (cmd 0xec)
>>>>     ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
>>>>     ata2: hard resetting port
>>>>     ata2: softreset failed (port not ready)
>>>>     ata2: follow-up softreset failed, retrying in 5 secs
>>>>     ata2: hard resetting port
>>>>     ata2: softreset failed (port not ready)
>>>>     ata2: follow-up softreset failed, retrying in 5 secs
>>>>     ata2: hard resetting port
>>>>     ata2: softreset failed (port not ready)
>>>>     ata2: reset failed, giving up
>>>>     ata2: EH complete
>>>>
>>>>    It seems that driver would receive the interrupt signal from eSATA
>>>>    device but can not reset the chip.  Could you give any idea about
>>>>    it ?  Thanks a lot.
>>> * What's the failing device?  An external hard disk cage?
>       Yeah, it is an external hard disk cage.
> 
> 
>>> * Does any other port of the controller has some device attached and
>>> working?
>     Only the cage the sil5723. 

Okay two things.

1. Make sure IRQ works by attaching a regular hard disk.

2. PMP is not supported by the kernel you're using.  You need to patch
the kernel.

-- 
tejun
