From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] AHCI PCI ID for MacBook Pro
Date: Sat, 10 Feb 2007 08:17:19 -0500
Message-ID: <45CDC5DF.9060306@gmail.com>
References: <82530.66623.qm@web25412.mail.ukl.yahoo.com>	 <45CC3FE5.2010408@gmail.com> <1171035949.23440.4.camel@localhost>	 <200702091841.45125.rootkit85@yahoo.it> <1171102758.19041.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.224]:33270 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbXBJNRg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Feb 2007 08:17:36 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1161927wxd
        for <linux-ide@vger.kernel.org>; Sat, 10 Feb 2007 05:17:35 -0800 (PST)
In-Reply-To: <1171102758.19041.5.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Matteo Croce <rootkit85@yahoo.it>, linux-ide@vger.kernel.org

Soeren Sonnenburg wrote:
> On Fri, 2007-02-09 at 18:41 +0100, Matteo Croce wrote:
>> On Friday 09 February 2007 16:45:49 you wrote:
>>> On Fri, 2007-02-09 at 04:33 -0500, Tejun Heo wrote:
>>>> Root Kit wrote:
>>> [...]
>>> Hmmhh I cannot really reproduce this benchmark. Matteo, with which
>>> benchmarking program did you produce this ?
>>> [...]
>> bonnie++ from ubuntu repos
> 
> OK, I reran bonnie++ -d /tmp/ on a unencrypted partition - results are
> here http://nn7.de/bench/ahci.html . Looks like it is slightly faster
> for sequential block write (2MB/s faster) and sequential read using
> putc()  (1MB/s faster), though putc() is slowed down by 6MB/s.

I suspect the difference is caused by either the io scheduler in use or 
disk drive itself.

> However what may make it worth is that I don't see any errors on
> suspend/resume anymore...

Hmm... So, ata_piix fails to suspend/resume properly on your machine? 
It should work.  Can you describe how it fails?

-- 
tejun
