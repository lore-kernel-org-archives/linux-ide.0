From: "J. Ryan Earl" <heretic@clanhk.org>
Subject: Re: Linux SATA RAID FAQ
Date: Sat, 14 Aug 2004 16:28:33 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <411E9211.8090108@clanhk.org>
References: <411B0F45.8070500@pobox.com>	 <20040812113413.GA19252@alpha.home.local>  <411D5D70.9070909@clanhk.org> <1092496912.27156.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:48568 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S266169AbUHNV2e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Aug 2004 17:28:34 -0400
In-Reply-To: <1092496912.27156.6.camel@localhost.localdomain>
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Willy Tarreau <willy@w.ods.org>, Jeff Garzik <jgarzik@pobox.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Alan Cox wrote:

>Be cautious what you measure. One of he problems until you reach PCI-X
>is PCI bandwidth. Thus software md5 can look good but the moment its
>combined with other PCI activity goes down the pan entirely.
>  
>
Right, which is why you'd think hardware based RAID would fair better, 
the parity information or mirror'd writes would only require one 
transfer/transaction across the PCI bus.  However, when benchmarking a 
3Ware 4-port ide raid controller (7000) we saw 40-50MB/sec read/write on 
4x160GB drives raid5.  With md raid5 (same controller, HDs, FS, etc)  we 
saw 100MB/sec read, 60MB/sec write.  This was using max 15% CPU on a 
2.4GHz Pentium4, with a 32bit/33MHz PCI bus.

>  
>
>>When the libata Marvell drivers come out, you'll have a cheap upgrade 
>>path for PCI-X boards if you want fast md raid: 
>>    
>>
>
>Agreed. PCI-X will change a lot of this for boxes that are not very
>cpu/memory limited.
>  
>
 From the testing I've done, interconnect bandwidth has always been the 
limiting factor for the md driver.  Using cheap ($~230) PCI-X 
motherboards--http://www.supermicro.com/products/motherboard/P4/E7210/P4SCT+.cfm--with 
dedicated gigE channels, you can make high density/price and 
performance/price NAS type appliances with no bottlenecks.  For <$3K you 
can build a 2TB NAS server that'll keep a 250MB/s gigE link saturated.

-ryan
