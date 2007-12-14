From: Mark Lord <liml@rtr.ca>
Subject: Re: Best way to segments/requests
Date: Fri, 14 Dec 2007 10:34:45 -0500
Message-ID: <4762A295.80008@rtr.ca>
References: <8b67d60712131459q35c3ef0dpe1347028112343fd@mail.gmail.com>	 <47629B9F.90108@gmail.com> <8b67d60712140722s7f579f30t978a8a8b926587f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090506040901050108060402"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2735 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752468AbXLNPeq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Dec 2007 10:34:46 -0500
In-Reply-To: <8b67d60712140722s7f579f30t978a8a8b926587f5@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian McMenamin <lkmladrian@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090506040901050108060402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adrian McMenamin wrote:
> On 14/12/2007, Tejun Heo <htejun@gmail.com> wrote:
>> Hello,
> 
>> There just isn't much room for maneuver w/ just one segment.  Large
>> contiguous memory region isn't too common these days.  That said, there
>> was a bug recently spotted by Mark Lord which made contiguous memory
>> regions even rarer.  Which kernel version are you using?
>>
> 
> Bang up to date latest git, ie -rc5-gitX
..

Not in -git yet, but it is in -mm.
Attached here for your convenience.

>>> Is that right? What is the best way to go here?
>> If you can spare some memory and cpu cycles, preparing a contiguous
>> buffer and staging data there might help.  It will eat up some cpu
>> cycles but it won't be too much compared to PIO cycles.
>>
> 
> OK, I'll try it
..

That's probably your best bet, even though it will mean copying
to/from your big bounce buffer with each I/O.

The code could be clever, I suppose, and only bounce when the supplied
I/O region is smaller than XXX pages.

Cheers


--------------090506040901050108060402
Content-Type: text/x-patch;
 name="13_fix_page_alloc_for_larger_io_segments.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="13_fix_page_alloc_for_larger_io_segments.patch"

"Improved version", more similar to the 2.6.23 code:

Fix page allocator to give better chance of larger contiguous segments (again).

Signed-off-by: Mark Lord <mlord@pobox.com
---

--- old/mm/page_alloc.c	2007-12-13 19:25:15.000000000 -0500
+++ linux-2.6/mm/page_alloc.c	2007-12-13 19:43:07.000000000 -0500
@@ -760,7 +760,7 @@
 		struct page *page = __rmqueue(zone, order, migratetype);
 		if (unlikely(page == NULL))
 			break;
-		list_add(&page->lru, list);
+		list_add_tail(&page->lru, list);
 		set_page_private(page, migratetype);
 	}
 	spin_unlock(&zone->lock);

--------------090506040901050108060402--
