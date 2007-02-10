From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] AHCI PCI ID for MacBook Pro
Date: Sat, 10 Feb 2007 12:17:46 -0500
Message-ID: <45CDFE3A.3020005@gmail.com>
References: <82530.66623.qm@web25412.mail.ukl.yahoo.com>	 <45CC3FE5.2010408@gmail.com> <1171035949.23440.4.camel@localhost>	 <200702091841.45125.rootkit85@yahoo.it>	 <1171102758.19041.5.camel@localhost>  <45CDC5DF.9060306@gmail.com> <1171123417.31813.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.226]:49820 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbXBJRSN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Feb 2007 12:18:13 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1215736wxd
        for <linux-ide@vger.kernel.org>; Sat, 10 Feb 2007 09:18:13 -0800 (PST)
In-Reply-To: <1171123417.31813.4.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Matteo Croce <rootkit85@yahoo.it>, linux-ide@vger.kernel.org

Soeren Sonnenburg wrote:
> well I am doing both benchmarks on a macbookpro1,1 -> 32bit mode (matteo
> does it on a macbook pro2, sth so he has a c2d and does it in 64bit ->
> amd64 mode).
> 
> So the io scheduler is the same or do you mean inside of ahci/piix ?

I meant the iosched (cfq/as/deadline...).

>>> However what may make it worth is that I don't see any errors on
>>> suspend/resume anymore...
>> Hmm... So, ata_piix fails to suspend/resume properly on your machine? 
>> It should work.  Can you describe how it fails?
> 
> Well I keep seeing this:
> 
> ata3.01: revalidation failed (errno=-2)
> ata3: failed to recover some devices, retrying in 5 secs
> ATA: abnormal status 0x7F on port 0x40DF
> ATA: abnormal status 0x7F on port 0x40DF
> ata3.01: configured for UDMA/133
> 
> but I am still on 2.6.20-rc6 ... so sorry if this is now fixed in .20.

Yeap, please give a shot at 2.6.20.  Maybe the TF clearing for IDENTIFY 
fixed the problem.

Thanks.

-- 
tejun
