From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.23.11] sata_svw: Add support for HT1100 SATA controller
Date: Thu, 28 Feb 2008 19:05:33 -0500
Message-ID: <47C74C4D.6060402@pobox.com>
References: <1204243115.4504.25.camel@LTSJCW-ANANTH.sj.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58835 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752998AbYB2AFg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Feb 2008 19:05:36 -0500
In-Reply-To: <1204243115.4504.25.camel@LTSJCW-ANANTH.sj.broadcom.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ananth@broadcom.com
Cc: linux-ide@vger.kernel.org

Anantha Subramanyam wrote:
> This patch adds support (including ATAPI DMA) for HT1100 (aka BCM11000) SATA controller.
> 
> Signed-off-by: Anantha Subramanyam <ananth@broadcom.com>

applied

Since this does not change the behavior of the existing, 
already-supported chips (no regressions), I applied to the 
#upstream-fixes branch of libata-dev.git, which means it is queued for 
kernel 2.6.25.

