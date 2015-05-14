From: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH] ahci: Add support for EEH error recovery
Date: Thu, 14 May 2015 11:09:56 -0500
Message-ID: <5554C8D4.8080400@linux.vnet.ibm.com>
References: <1431567319-3380-1-git-send-email-wenxiong@linux.vnet.ibm.com> <20150514151331.GI11388@htj.duckdns.org> <5554C2D2.7040700@linux.vnet.ibm.com> <20150514154804.GK11388@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:52046 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965086AbbENQKC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 May 2015 12:10:02 -0400
Received: from /spool/local
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-ide@vger.kernel.org> from <brking@linux.vnet.ibm.com>;
	Thu, 14 May 2015 10:10:02 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 860CF1FF0030
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2015 10:01:10 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4EG9WxN32505938
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2015 09:09:32 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4EG9xuD018673
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2015 10:10:00 -0600
In-Reply-To: <20150514154804.GK11388@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: wenxiong@linux.vnet.ibm.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, Wen Xiong <wenxiong@us.ibm.com>

On 05/14/2015 10:48 AM, Tejun Heo wrote:
> Hello, Brian.
> 
> On Thu, May 14, 2015 at 10:44:18AM -0500, Brian King wrote:
>> So, on the Power platform, the pci_error_handlers map to our EEH recovery.
> 
> What's EEH?

It stands for "Extended Error Handling". 

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/PCI/pci-error-recovery.txt
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/powerpc/eeh-pci-error-recovery.txt

> 
>> In that case, without this patch, if we hit any sort of PCIe error, we
>> won't be able to recover and we'll lose all access to the ahci disks.
>> This could be the adapter trying to access an invalid DMA address due
>> to a transient hardware issue, or it could be due to a driver bug giving
>> the adapter an invalid address. It could also be other various PCIe
>> errors that cause our PCIe bridge chip to isolate the device and
>> place it into the EEH "frozen" state. When this occurs, if the driver
>> associated with the hardware does not have these handlers registered,
>> powerpc arch kernel code will hotplug remove the adapter, recover the
>> adapter, then hotplug add it back. This works OK for some devices,
>> but generally not so well for storage devices with mounted filesystems,
>> which would tend to go readonly in this case.
> 
> I think the above, with more details on how the error handling
> actually works (IOW what it does), should be in the patch description
> and comments.  Wen, can you please update the patch with more
> information?

Agreed.

Thanks,

Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center


