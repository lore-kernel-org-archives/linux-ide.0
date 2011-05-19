From: Mark Lord <kernel@teksavvy.com>
Subject: Re: Support for dual-drive pmp?  0x197b:0x2352
Date: Thu, 19 May 2011 11:53:34 -0400
Message-ID: <4DD53CFE.9020801@teksavvy.com>
References: <4DD418EE.8020405@teksavvy.com> <20110519093948.GB627@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:40749 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933143Ab1ESPxf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 May 2011 11:53:35 -0400
In-Reply-To: <20110519093948.GB627@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On 11-05-19 05:39 AM, Tejun Heo wrote:
> Hello, Mark.
> 
> On Wed, May 18, 2011 at 03:07:26PM -0400, Mark Lord wrote:
>> But it also fails equally well without the patch.  :)
> 
> Awesome! :)
> 
>> The eSATA host controller is the ever-popular JMicron:
>>
>> 04:00.0 SATA controller: JMicron Technology Corp. JMB362/JMB363 Serial ATA
>> Controller (rev 02)
>> (197b:2363)
>>
>> Just about everything around here has one of those JMicron chips
>> for the eSATA ports, so I'm guessing that this problem may be
>> somewhat more widespread than just my home office.
> 
> Can you send me a link of the PMP device?

Here's the URL.  It's a dual-bay eSATA/USB2 dock.
I use these all over the place, with fans added on (by me):
    ncix.com/products/?sku=36051

>> So what next?
>> I suspect something isn't quite right in the JMicron AHCI driver code.
> 
> I have no idea.  I'll get one and see what's up with it.

Thanks!
Whatever the chip inside is, it is reasonably clever:

1. With just a single drive installed, it shows up
as a single-drive, not a PMP.

2. With two drives installed, it enumerates as a PMP.

3. When used over USB2 instead of eSATA, it shows up as a single dev with two LUNs,
rather than as a USB-hub with two devices.  Fine by me.  :)

4. Spins down the drives when the USB cable is detached (or host sleeps).

Cheers
