From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata-acpi: fix _GTF command protocol for ATAPI
 devices
Date: Sun, 22 Apr 2007 18:38:16 +0100
Message-ID: <20070422183816.42dad6d5@the-village.bc.nu>
References: <20070422170646.GM10619@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55676 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751208AbXDVRev (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Apr 2007 13:34:51 -0400
In-Reply-To: <20070422170646.GM10619@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Mon, 23 Apr 2007 02:06:46 +0900
Tejun Heo <htejun@gmail.com> wrote:

> _GTF command is never ATA_PROT_ATAPI_NODATA whether the device is
> ATAPI or not.  It's always ATA_PROT_NODATA.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>
