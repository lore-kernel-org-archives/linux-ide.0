From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Cache Coherency in PIO Read/Write
Date: Thu, 31 Aug 2006 11:02:49 -0600
Message-ID: <8202f4270608311002s3fab8b5awca10bf74a826d6d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:53255 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932389AbWHaRCu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Aug 2006 13:02:50 -0400
Received: by py-out-1112.google.com with SMTP id n25so847291pyg
        for <linux-ide@vger.kernel.org>; Thu, 31 Aug 2006 10:02:49 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: htejun@gmail.com

Hi,

We use sg/libata for data read/write test in ARM XScale platform (VIVT
cache).  We
experienced data miscompare issue during heavy testing on both DMA and
PIO read/write.  In this particular application, data buffer is
allocated inside sg using alloc_pages() and mmapped to user space.
 So essentially this buffer can be accessed by user space, kernel for
PIO and hardware for DMA.  After changing mmapped vma to noncache, we
haven't seen any data miscompare in DMA read/write, but data
miscompare in PIO read/write still exists sporadically.  I suspect
this is caused by kernel cache alias during PIO read/write.  What I
want to know is how the cache coherency is ensured in PIO read/write.
As an alternative, is there any way to make the kernel access to this
data buffer uncached?

Thanks,
Fajun
