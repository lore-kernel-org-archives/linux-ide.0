From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: System freezes with kernel >2.6.19 - sata_nv [added crash info
 kern 2.6.21.1]
Date: Tue, 01 May 2007 17:57:46 -0600
Message-ID: <4637D3FA.2070403@shaw.ca>
References: <46351BE2.70901@yahoo.de> <4635BF4A.3050509@gmail.com>
 <46367F58.7000609@shaw.ca> <4636A4DC.8070606@gmail.com>
 <4637CCEA.8020202@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:30224 "EHLO
	pd3mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946089AbXEAX5v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 May 2007 19:57:51 -0400
Received: from pd3mr1so.prod.shaw.ca
 (pd3mr1so-qfe3.prod.shaw.ca [10.0.141.177]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JHD00675ZWFY730@l-daemon> for linux-ide@vger.kernel.org; Tue,
 01 May 2007 17:57:51 -0600 (MDT)
Received: from pn2ml7so.prod.shaw.ca ([10.0.121.151])
 by pd3mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JHD006SSZWFY260@pd3mr1so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Tue, 01 May 2007 17:57:52 -0600 (MDT)
Received: from [192.168.1.113] ([70.64.1.86])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JHD00J1QZWEGDL0@l-daemon> for linux-ide@vger.kernel.org; Tue,
 01 May 2007 17:57:50 -0600 (MDT)
In-reply-to: <4637CCEA.8020202@yahoo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan <gentoopower@yahoo.de>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Stefan wrote:
> Okay, I had time to set this up. I'm attaching the log messages I got
> via netconsole.
> 
> 
> I tested about 20h with adma disabled, the crash won't occur.
> 
> If I remove
> 
> sata_nv.adma=0
> 
> from boot options again it doesn't take long until my machine locks up.
> 
> [Attached dmesg output with 2.6.21.1 kernel + crash info I got via
> netconsole]
> 
> 
> I hope this is useful to you guys.

It looks like you've got SError bits set from the controller, 0x200000 
means link layer CRC error (btw, we really should be decoding that error 
and printing it in human readable form rather than making people pore 
through the SATA spec and count bits). First thing you should try is 
replacing the SATA cable to that drive.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


