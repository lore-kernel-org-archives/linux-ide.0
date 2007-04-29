From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata-acpi: fix _GTF command protocol for ATAPI devices
Date: Sat, 28 Apr 2007 23:13:50 -0400
Message-ID: <46340D6E.9010404@garzik.org>
References: <20070422170646.GM10619@htj.dyndns.org> <46339824.5000107@garzik.org> <4634082F.4030603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55896 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754295AbXD2DNv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 23:13:51 -0400
In-Reply-To: <4634082F.4030603@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> ATA_PROT_ATAPI_NODATA is used for PACKET command without CDB.  ACPI _GTF
> never contains PACKET command.  It's always ATA commands.

Ah yes.  Thanks for the reminder about the code I wrote :)

	Jeff


