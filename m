From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] libata DMADIR support
Date: Mon, 17 May 2004 17:04:05 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <7F0B4194-A856-11D8-8828-003065635034@ieee.org>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com>
	 <1084819720.4328.86.camel@patibmrh9>  <40A90D96.2040002@pobox.com><108482
	 8	840.3211.26.camel@patibmrh9>  <40A92F69.6030309@pobox.com> <1084831524.3
	2 11.67.camel@patibmrh9> <40A93E85.4010904@pobox.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:36531 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S263100AbUEQXEY
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 May 2004 19:04:24 -0400
In-Reply-To: <40A93E85.4010904@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

>>> word 62
>> Ouch, ouch, ouch.
>> I just dug up the fact that mask x0707 of word 62 used to mean single
>> word DMA e.g. in page 54 of 111, ATA-2 of 1996-03-18, d0948r4c.pdf.
>> t13.org ATA/PI 7 redefining word 62 to mean DMADIR may become a
>> pernicious way of searching out anyone who still thinks SWDMA exists.
>
> SWDMA never existed for ATAPI devices.  Word 62 has -always- been 
> reserved, until now.

To SFF we owe many perniciously slight binary incompatibilities.  Re 
ops xEC/A1 "IDENTIFY" we have:

----- http://www.google.com/search?q=storage+cornucopia
----- http://www.bswd.com/cornucop.htm
----- SFF-8020i, Rev. 2.6: ATAPI for CD-ROMs (old and antiquated)
----- http://www.bswd.com/sff8020i.pdf

... January 22, 1996 ...

----- page 80 of 224

7.1.7.9  Single Word DMA Transfer (Word 62) The low order byte 
identifies by bit all of the modes which are supported, e.g., if Mode 0 
is supported, bit 0 is set. The high order byte contains a single bit 
set to indicate which mode is active, e.g., if Word 0 is active, bit8 
is set.

-----

Pat LaVarre

