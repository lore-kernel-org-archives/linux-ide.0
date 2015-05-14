From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: Add support for EEH error recovery
Date: Thu, 14 May 2015 11:48:04 -0400
Message-ID: <20150514154804.GK11388@htj.duckdns.org>
References: <1431567319-3380-1-git-send-email-wenxiong@linux.vnet.ibm.com>
 <20150514151331.GI11388@htj.duckdns.org>
 <5554C2D2.7040700@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33831 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933238AbbENPsM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 May 2015 11:48:12 -0400
Received: by qkgx75 with SMTP id x75so52039842qkg.1
        for <linux-ide@vger.kernel.org>; Thu, 14 May 2015 08:48:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5554C2D2.7040700@linux.vnet.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian King <brking@linux.vnet.ibm.com>
Cc: wenxiong@linux.vnet.ibm.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, Wen Xiong <wenxiong@us.ibm.com>

Hello, Brian.

On Thu, May 14, 2015 at 10:44:18AM -0500, Brian King wrote:
> So, on the Power platform, the pci_error_handlers map to our EEH recovery.

What's EEH?

> In that case, without this patch, if we hit any sort of PCIe error, we
> won't be able to recover and we'll lose all access to the ahci disks.
> This could be the adapter trying to access an invalid DMA address due
> to a transient hardware issue, or it could be due to a driver bug giving
> the adapter an invalid address. It could also be other various PCIe
> errors that cause our PCIe bridge chip to isolate the device and
> place it into the EEH "frozen" state. When this occurs, if the driver
> associated with the hardware does not have these handlers registered,
> powerpc arch kernel code will hotplug remove the adapter, recover the
> adapter, then hotplug add it back. This works OK for some devices,
> but generally not so well for storage devices with mounted filesystems,
> which would tend to go readonly in this case.

I think the above, with more details on how the error handling
actually works (IOW what it does), should be in the patch description
and comments.  Wen, can you please update the patch with more
information?

Thanks.

-- 
tejun
