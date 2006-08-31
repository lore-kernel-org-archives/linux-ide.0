From: "Mark Odell" <modell@netezza.com>
Subject: RE: Cache Coherency in PIO Read/Write
Date: Thu, 31 Aug 2006 13:30:17 -0400
Message-ID: <4D87F853B8020F4888896B1507DC0F09A2C433@mail2.netezza.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hudson.netezza.com ([12.148.248.137]:27071 "HELO
	mail2.netezza.com") by vger.kernel.org with SMTP id S932261AbWHaRaT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Aug 2006 13:30:19 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

For PIO mode transfers, you should not have cache coherency issues since
the CPU core is doing the read from/write to hardware.

> -----Original Message-----
> From: linux-ide-owner@vger.kernel.org 
> [mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Fajun Chen
> Sent: Thursday, August 31, 2006 1:03 PM
> To: linux-ide@vger.kernel.org
> Cc: htejun@gmail.com
> Subject: Cache Coherency in PIO Read/Write
> 
> Hi,
> 
> We use sg/libata for data read/write test in ARM XScale 
> platform (VIVT cache).  We experienced data miscompare issue 
> during heavy testing on both DMA and PIO read/write.  In this 
> particular application, data buffer is allocated inside sg 
> using alloc_pages() and mmapped to user space.
>  So essentially this buffer can be accessed by user space, 
> kernel for PIO and hardware for DMA.  After changing mmapped 
> vma to noncache, we haven't seen any data miscompare in DMA 
> read/write, but data miscompare in PIO read/write still 
> exists sporadically.  I suspect this is caused by kernel 
> cache alias during PIO read/write.  What I want to know is 
> how the cache coherency is ensured in PIO read/write.
> As an alternative, is there any way to make the kernel access 
> to this data buffer uncached?
> 
> Thanks,
> Fajun
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-ide" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 
