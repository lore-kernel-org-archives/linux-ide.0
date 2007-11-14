From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_nv: fix ADMA ATAPI issues with memory over 4GB
Date: Wed, 14 Nov 2007 10:57:58 +0900
Message-ID: <473A5626.7040008@gmail.com>
References: <4738DE21.8090702@shaw.ca> <47390B2F.7090105@gmail.com> <47392768.3030509@shaw.ca> <47392B3D.1020101@gmail.com> <4739B0E5.2010303@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757561AbXKNB6m@vger.kernel.org>
In-Reply-To: <4739B0E5.2010303@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>
List-Id: linux-ide@vger.kernel.org

Mark Lord wrote:
> Tejun Heo wrote:
>> Robert Hancock wrote:
>>> Tejun Heo wrote:
> ..
>>> Yes, it should likely do something with these return values. Though
>>> theoretically it shouldn't fail, since the DMA mask is either 32-bit,
>>> which shouldn't fail, or one that was successfully set before. Also I
>>> don't think the SCSI layer actually checks the slave_config return
>>> value.. sigh.
>>
>> Then please at least add WARN_ON() && another reason why allocating /
>> deallocating resources from ->slave_config isn't such a good idea.
> ..
> 
> The entire point of "slave_configure" is to provide a point for the LLD
> to do per-device data structure allocation/init.
> 
> And yes, SCSI does check the return code.  Whether the code around that
> check
> is buggy or not is another question, but it's always worked for me.

I see but I still prefer having PRD, pad buf allocation/release in
->port_start/stop() primarily for consistency.  Robert, what do you think?

-- 
tejun
