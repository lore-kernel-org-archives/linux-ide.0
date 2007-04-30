From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: System freezes with kernel >2.6.19 - sata_nv
Date: Mon, 30 Apr 2007 17:44:24 -0600
Message-ID: <46367F58.7000609@shaw.ca>
References: <46351BE2.70901@yahoo.de> <4635BF4A.3050509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:12652 "EHLO
	pd2mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946132AbXD3Xo5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Apr 2007 19:44:57 -0400
Received: from pd2mr2so.prod.shaw.ca
 (pd2mr2so-qfe3.prod.shaw.ca [10.0.141.109]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JHC0087W4MB2N40@l-daemon> for linux-ide@vger.kernel.org; Mon,
 30 Apr 2007 17:44:35 -0600 (MDT)
Received: from pn2ml7so.prod.shaw.ca ([10.0.121.151])
 by pd2mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JHC00GI54M3SPK0@pd2mr2so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Mon, 30 Apr 2007 17:44:28 -0600 (MDT)
Received: from [192.168.1.113] ([70.64.1.86])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JHC003Q04M3B8N0@l-daemon> for linux-ide@vger.kernel.org; Mon,
 30 Apr 2007 17:44:27 -0600 (MDT)
In-reply-to: <4635BF4A.3050509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Stefan <gentoopower@yahoo.de>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Stefan wrote:
>> Hi folks,
>>
>> yesterday I upgraded  kernel 2.6.19 to 2.6.20 (gentoo kernel). Now my
>> box locks up about 10 min after boot.
>> After that I tested with a vanilla 2.6.21.1 it shows the same behavior.
>> I'm attaching a kern log file from the 2.6.20. The 2.6.21.1 locked up so
>> hard, that there was no trace left in the log file.
>> If I switch back to 2.6.19 everything is fine again.
>> If necessary I will hook up a laptop to this box, so I can capture
>> messages via netconsole.
> 
> Yes please.
> 
>> This machine is running an AMD X2 64, NFORCE4 (ASUS A8N-E)
>>
>> I haven't been following the development of libata for a while, but from
>> the 2.6.20 changelog It looks like there have been some major changes.
>>
>> Just let me know what kind of information you need in order to narrow it
>> down.
> 
> Does giving 'sata_nv.adma=0' kernel parameter make any difference?

If adma=0 words, then that means it's either an ADMA related problem or 
that SAMSUNG HD401LJ drive has some problems with NCQ (since ADMA off 
means NCQ off as well). I would say the latter is more likely.

We should really have some kind of "noncq" kernel parameter we can use 
to help debugging these problems. Though, later kernels are supposed to 
switch it off automatically after too many errors..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

