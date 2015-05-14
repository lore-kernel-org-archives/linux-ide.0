From: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH] ahci: Add support for EEH error recovery
Date: Thu, 14 May 2015 10:44:18 -0500
Message-ID: <5554C2D2.7040700@linux.vnet.ibm.com>
References: <1431567319-3380-1-git-send-email-wenxiong@linux.vnet.ibm.com> <20150514151331.GI11388@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:56185 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932693AbbENPoZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 May 2015 11:44:25 -0400
Received: from /spool/local
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-ide@vger.kernel.org> from <brking@linux.vnet.ibm.com>;
	Thu, 14 May 2015 09:44:25 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id DAB0B19D8045
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2015 09:35:25 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4EFgGu621823612
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2015 08:42:16 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4EFiKTZ010671
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2015 09:44:21 -0600
In-Reply-To: <20150514151331.GI11388@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, wenxiong@linux.vnet.ibm.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Wen Xiong <wenxiong@us.ibm.com>

On 05/14/2015 10:13 AM, Tejun Heo wrote:
> Hello, Wen.
> 
> On Wed, May 13, 2015 at 08:35:19PM -0500, wenxiong@linux.vnet.ibm.com wrote:
>> From: Wen Xiong <wenxiong@linux.vnet.ibm.com>
>>
>> This patch adds the callback functions to support EEH error
>> recovery in ahci driver. Also adds the code in ahci_error_handler
>> to issue an MMIO load then check if it is in EEH. If it is in EEH,
>> ahci_error_handler will wait until EEH recovery is completed.
> 
> Can you please explain why we would want this?  What does it buy us?

So, on the Power platform, the pci_error_handlers map to our EEH recovery.
In that case, without this patch, if we hit any sort of PCIe error, we
won't be able to recover and we'll lose all access to the ahci disks.
This could be the adapter trying to access an invalid DMA address due
to a transient hardware issue, or it could be due to a driver bug giving
the adapter an invalid address. It could also be other various PCIe
errors that cause our PCIe bridge chip to isolate the device and
place it into the EEH "frozen" state. When this occurs, if the driver
associated with the hardware does not have these handlers registered,
powerpc arch kernel code will hotplug remove the adapter, recover the
adapter, then hotplug add it back. This works OK for some devices,
but generally not so well for storage devices with mounted filesystems,
which would tend to go readonly in this case.

-Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center


