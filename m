From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/1] libata: let ATA_FLAG_PIO_POLLING use polling pio
 for ATA_PROT_NODATA
Date: Thu, 07 Dec 2006 07:22:38 -0500
Message-ID: <4578078E.1020601@pobox.com>
References: <45778C96.7010101@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37370 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032120AbWLGMWq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 Dec 2006 07:22:46 -0500
In-Reply-To: <45778C96.7010101@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Alessandro Zummo <a.zummo@towertech.it>, Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Even if ATA_FLAG_PIO_POLLING is set, libata uses irq pio for the ATA_PROT_NODATA protocol.
> This patch let ATA_FLAG_PIO_POLLING use polling pio for the ATA_PROT_NODATA protocol.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

applied


