From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.8.1] sata_nv.c
Date: Sat, 28 Aug 2004 19:30:55 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <413115AF.4010306@pobox.com>
References: <4125106A.2020903@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58779 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268129AbUH1XbH
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Aug 2004 19:31:07 -0400
In-Reply-To: <4125106A.2020903@nvidia.com>
List-Id: linux-ide@vger.kernel.org
To: achew <achew@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

achew wrote:
> This patch fixes a problem introduced when CK804 support was added.  
> mmio_base can only be set in the CK804 case,
> else libata will attempt to iounmap mmio_base, which isn't iomapped for 
> the non-CK804 case.  Still need the bar 5
> address, so steal from host_set->ports[0]->ioaddr.scr_addr.  Jeff, let 
> me know if this is a bad thing to do.

applied.

PLEASE use a descriptive subject line.

The email subject, after stripping '\[.*]', becomes a one-line summary 
of the change, and is directly injected into the BK changelog.

	Jeff



