From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: System freezes with kernel >2.6.19 - sata_nv [added crash info
 kern 2.6.21.1]
Date: Wed, 02 May 2007 17:46:30 -0600
Message-ID: <463922D6.3040105@shaw.ca>
References: <46351BE2.70901@yahoo.de> <4635BF4A.3050509@gmail.com>
 <46367F58.7000609@shaw.ca> <4636A4DC.8070606@gmail.com>
 <4637CCEA.8020202@yahoo.de> <4637D3FA.2070403@shaw.ca>
 <463878E5.4020607@gmail.com> <46390AFE.8000800@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:23027 "EHLO
	pd2mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767243AbXEBXrt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 May 2007 19:47:49 -0400
Received: from pd3mr4so.prod.shaw.ca
 (pd3mr4so-qfe3.prod.shaw.ca [10.0.141.180]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JHF00AZ3U1VF600@l-daemon> for linux-ide@vger.kernel.org; Wed,
 02 May 2007 17:46:43 -0600 (MDT)
Received: from pn2ml1so.prod.shaw.ca ([10.0.121.145])
 by pd3mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JHF0076MU1P2PL0@pd3mr4so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Wed, 02 May 2007 17:46:37 -0600 (MDT)
Received: from [192.168.1.113] ([70.64.1.86])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JHF00956U1O6E90@l-daemon> for linux-ide@vger.kernel.org; Wed,
 02 May 2007 17:46:36 -0600 (MDT)
In-reply-to: <46390AFE.8000800@yahoo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan <gentoopower@yahoo.de>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Stefan wrote:
>>> First thing you should try is replacing the SATA cable to that drive.
>>>     
>> Yeap, please apply some hardware debugging techniques - replacing /
>> reseating SATA cables and connecting it to different power connector.
>> But it's disturbing to see machine lock up even if CRC error occurs.
>> sata_nv non-adma interface locks the whole machine up too after certain
>> error conditions but I thought adma was saner than that.  I hope we can
>> work around this somehow.
>>
>> Thanks.
>>
>>   
> I have just replaced the cables with brand new ones, still no change the
> machine freezes ~10min after boot.
> Sometimes I even have to completely power down the machine to be able to
> boot again.

Power problems would be another possibility..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
