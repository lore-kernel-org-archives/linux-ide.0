From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] Unbreak build of PMP with ACPI disabled
Date: Fri, 13 Jul 2007 17:30:05 -0600
Message-ID: <46980AFD.3000503@shaw.ca>
References: <20070713065600.GB8320@vana.vc.cvut.cz> <46972519.80703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:11879 "EHLO
	pd2mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762179AbXGMXaR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 19:30:17 -0400
Received: from pd3mr1so.prod.shaw.ca
 (pd3mr1so-qfe3.prod.shaw.ca [10.0.141.177]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JL50019B592ODD0@l-daemon> for linux-ide@vger.kernel.org; Fri,
 13 Jul 2007 17:29:26 -0600 (MDT)
Received: from pn2ml5so.prod.shaw.ca ([10.0.121.149])
 by pd3mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JL500CTR56U2SB0@pd3mr1so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Fri, 13 Jul 2007 17:28:06 -0600 (MDT)
Received: from [192.168.1.113] ([70.64.1.86])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JL500MK756S5Z30@l-daemon> for linux-ide@vger.kernel.org; Fri,
 13 Jul 2007 17:28:05 -0600 (MDT)
In-reply-to: <46972519.80703@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Petr Vandrovec <petr@vandrovec.name>, linux-ide@vger.kernel.org

Tejun Heo wrote:
>> Only problem I've noticed is that smartctl on drives connected to sata_nv
>> needs '-T permissive', while if same drive is connected to sata_sil24's PMP,
>> it works without problem.  
>>
>> Error SMART Status command failed
>> Please get assistance from http://smartmontools.sourceforge.net/
>> Values from ATA status return descriptor are:
>>  00     09 0c 00 00 00 00 00 00  00 00 00 00 00 50
>> A mandatory SMART command failed: exiting. To continue, add one or more '-T permissive' options.
> 
> Yeah, we seem to have some problem with passing result TF to userland in
> sata_nv (cc'ed Robert).
> 
> Thanks.

I've seen that report, but it's a bit of a mystery to me. Apparently the 
problem still happens if ADMA is disabled, and in that mode we just use 
the standard ata_tf_read function, so it's not clear how it could not be 
working on that controller but work on others..

Also I haven't noticed any SMART problems on my machine with ADMA 
enabled.. maybe it's drive or motherboard dependent?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

