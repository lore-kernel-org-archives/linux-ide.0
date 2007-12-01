From: Mark Lord <liml@rtr.ca>
Subject: Re: SAS v SATA interface performance
Date: Fri, 30 Nov 2007 22:06:31 -0500
Message-ID: <4750CFB7.7040400@rtr.ca>
References: <4750A523.7010501@clear.net.nz> <20071201001740.7ffce6f6@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1863 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757120AbXLADGc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Nov 2007 22:06:32 -0500
In-Reply-To: <20071201001740.7ffce6f6@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Richard Scobie <r.scobie@clear.net.nz>, linux-ide@vger.kernel.org

Alan Cox wrote:
>> The comment I saw, which I'm trying to verify, mentioned the SATA drives 
>> "held the bus" or similar longer than SAS ones.
> 
> SATA normally uses one link per device so the device side isn't contended
> unless you descend into the murky world of port multipliers. 
..

And that's where NCQ comes into it's own, allowing full bus release
so that other drives on the same port multiplier can burst as needed.

I've only had a port multiplier here for a few days, and used only a pair
of *notebook* SATA drives on it thus far.  Both drives can stream at full
rate without any slowdown -- that's 55MByte/sec from each drive, at the
same time, for sequential reading, 100MByte/sec total.  Notebook drives.

Cheers
