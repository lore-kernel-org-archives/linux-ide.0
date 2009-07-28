From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Add AMD SB900 SATA/IDE controller device IDs
Date: Tue, 28 Jul 2009 16:52:23 +0900
Message-ID: <4A6EAE37.70703@kernel.org>
References: <1248762566.3437.7.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42100 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324AbZG1HuQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Jul 2009 03:50:16 -0400
In-Reply-To: <1248762566.3437.7.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shane.huang@amd.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Shane Huang wrote:
> Add AMD SB900 SATA/IDE controller device IDs.
> 
> Signed-off-by: Shane Huang <shane.huang@amd.com>

Acked-by: Tejun Heo <tj@kernel.org>

> +	/* AMD */
> +	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD SB900 */
> +	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> +	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci }, /* AMD RAID */

Adding a comment declaring that AMD is committed to use RAID class
only for ahci controllers would be nice.

Thanks.

-- 
tejun
