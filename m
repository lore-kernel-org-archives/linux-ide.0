From: Wes Newell <w.newell@verizon.net>
Subject: Re: libata and PATA devices
Date: Thu, 11 Aug 2005 15:19:14 -0500
Message-ID: <42FBB2C2.8060100@verizon.net>
References: <200508071949.03782.inform@tiker.net>	<42F6B8CD.4050100@gmail.com>
 <20050808030239.GA27502@havoc.gtf.org>
 <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca>
 <42FACCA8.6050408@pobox.com> <42FB853E.4070100@rtr.ca>
 <42FB889F.50607@pobox.com> <1123789132.4422.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:29868 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S932421AbVHKUOU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Aug 2005 16:14:20 -0400
Received: from [192.168.0.2] ([71.244.9.153])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0IL2004OHQVT1VG9@vms042.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Thu, 11 Aug 2005 15:14:18 -0500 (CDT)
In-reply-to: <1123789132.4422.30.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux.ide" <linux-ide@vger.kernel.org>

On Thu, 2005-08-11 at 13:19 -0400, Jeff Garzik wrote:

>>Mark Lord wrote:
>>    
>>
>>>Jeff Garzik wrote:
>>>      
>>>
>>>>currently no one should be using libata for PATA support.
>>>>        
>>>>
>>>We emailed back and forth extensively about how this has
>>>not been true since early this year.  Modern laptops are
>>>using libata for the ICH6M support, simply because libata
>>>claims that chipset, and the IDE driver does not.
>>>These laptops are using PATA drives (eg. "FUJITSU MHV2100AH").
>>>      
>>>
>>This sounds like a misconfigured kernel.  The IDE driver should pick up 
>>the PATA port, and libata should pick up the SATA port.  Anything else 
>>is a bug, and should be addressed by me or Bart.
>>    
>>

While ya'll are talking about pata support, has anyone got a driver that 
supports the pata ports of the SIS180 yet? And I don't care which 
way.:-) As you might recall, I tried patching the 5513 driver, but had 
limited success with constant lost interrupts. I'm not a C programmer 
and don't know much about the whole IDE layout, but I'm willing to test 
on a Jetway S755MAX Board, that constist of the standard pata ports off 
the sis755 and a secondary SIS180 with 2 ports of sata and 1 channel 
pata (2 drives). I'm running the 2.6.11 kernel, but can install whatever 
you would want to test with on another drive.

