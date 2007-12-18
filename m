From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 3/9] libata: xfer_mask is unsigned int not unsigned long
Date: Mon, 17 Dec 2007 21:49:06 -0500
Message-ID: <47673522.5080706@garzik.org>
References: <200712140001.lBE01dxT025432@imap1.linux-foundation.org>	<476722B9.5080601@garzik.org> <20071217184425.1b6dc8c0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51255 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743AbXLRCtJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Dec 2007 21:49:09 -0500
In-Reply-To: <20071217184425.1b6dc8c0.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, htejun@gmail.com

Andrew Morton wrote:
> On Mon, 17 Dec 2007 20:30:33 -0500 Jeff Garzik <jeff@garzik.org> wrote:
> 
>> akpm@linux-foundation.org wrote:
>>> From: Tejun Heo <htejun@gmail.com>
>>>
>>> xfer_mask is unsigned int not unsigned long.  Change ->mode_filter to
>>> take and return unsigned int.
>>>
>>> While at it, rename @adev of ata_pci_default_filter() to @dev for
>>> consistency.
>>>
>>> [akpm@linux-foundation.org: fix types]
>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>> ---
>>>
>>>  drivers/ata/libata-sff.c       |    5 +++--
>>>  drivers/ata/pata_acpi.c        |    2 +-
>>>  drivers/ata/pata_ali.c         |    2 +-
>>>  drivers/ata/pata_amd.c         |   10 +++++-----
>>>  drivers/ata/pata_hpt366.c      |    2 +-
>>>  drivers/ata/pata_hpt37x.c      |    4 ++--
>>>  drivers/ata/pata_pdc2027x.c    |    4 ++--
>>>  drivers/ata/pata_scc.c         |    2 +-
>>>  drivers/ata/pata_serverworks.c |    4 ++--
>>>  include/linux/libata.h         |    9 +++++----
>>>  10 files changed, 23 insertions(+), 21 deletions(-)
>> patch is outdated...
>>
> 
> What does this mean??
> 

following discussion, was superceded by

commit 52fc241b4c5ef60d73327d9468634694a1f7d359
Author: Tejun Heo <htejun@gmail.com>
Date:   Tue Nov 27 19:43:42 2007 +0900

     libata: xfer_mask is unsigned long not unsigned int

which has been in netdev#upstream for a few weeks, and probably at least 
one -mm release.
