From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/2] Workaround for SB600 SATA ODD issue
Date: Wed, 08 Nov 2006 08:30:25 -0500
Message-ID: <4551DBF1.2080609@garzik.org>
References: <20061103190004.9ED8DCBD48@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:24453 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965737AbWKHNa2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Nov 2006 08:30:28 -0500
In-Reply-To: <20061103190004.9ED8DCBD48@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Luugi Marsan <luugi.marsan@amd.com>
Cc: linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Luugi Marsan wrote:
> From: conke.hu@amd.com
> 
> There was an ASIC bug in the SB600 SATA controller of low revision (<=13) and CD burning may hang (only SATA ODD has this issue, and SATA HDD works well). The patch provides a workaround for this issue.
> 
> Signed-off-by:  Luugi Marsan <luugi.marsan@amd.com>

ACK technical content, but it needs one revision:  like someone else 
(Alan or Tejun?) mentioned, this patch should be revised to use a 
separate ata_port_operations for the affected chip(s).

Copy ahci_ops to sb600_ops, add your check-atapi-dma function without 
the vendor/device ID check.  Move the vendor/device check to the 
pci_device_id table by creating a board_ahci_sb600 constant and 
associated table data.

I agree with other posters that we should move the revision check to 
more generic code, but such a move should not block this patch.  The two 
efforts can occur in parallel.

	Jeff


