From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.8-rc2] sata_nv.c
Date: Thu, 05 Aug 2004 17:53:15 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4112AC4B.9010702@pobox.com>
References: <DBFABB80F7FD3143A911F9E6CFD477B03F9620@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52650 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267900AbUHEVyw
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Aug 2004 17:54:52 -0400
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B03F9620@hqemmail02.nvidia.com>
List-Id: linux-ide@vger.kernel.org
To: Andrew Chew <achew@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Andrew Chew wrote:
> Attached is a patch to the sata_nv driver that accounts for a few
> differences between the nForce3 and CK804/MCP04 SATA controllers.
> 
> A minor change to libata-core.c needs to accompany this patch.  This is
> in regards to the function ata_pci_remove_one(), where the
> host_set->ops->host_stop(host_set) needs to occur before the
> iounmap(host_set->mmio_base).  This is because sata_nv's host_stop
> callback needs access to the iomapped region.

Do you want to send a separate patch for this?  I don't see that change 
in the attached patch.

	Jeff


