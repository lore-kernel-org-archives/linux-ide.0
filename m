From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] sata_nv: fix ATAPI issues with memory over 4GB (v3)
Date: Wed, 14 Nov 2007 12:05:42 +0000
Message-ID: <20071114120542.02b0b6da@the-village.bc.nu>
References: <473A7677.6080007@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38388 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751926AbXKNMGp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 07:06:45 -0500
In-Reply-To: <473A7677.6080007@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

On Tue, 13 Nov 2007 22:15:51 -0600
Robert Hancock <hancockr@shaw.ca> wrote:

> This fixes some problems with ATAPI devices on nForce4 controllers in ADMA mode
> on systems with memory located above 4GB. We need to delay setting the 64-bit
> DMA mask until the PRD table and padding buffer are allocated so that they don't
> get allocated above 4GB and break legacy mode (which is needed for ATAPI
> devices).
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>

Acked-by: Alan Cox <alan@redhat.com>
