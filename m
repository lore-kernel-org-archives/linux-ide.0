From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 08/12] libata: convert drivers with combined SATA/PATA
 ports to new init model
Date: Fri, 9 Mar 2007 12:46:30 +0000
Message-ID: <20070309124630.50f1471c@lxorguk.ukuu.org.uk>
References: <1173438935540-git-send-email-htejun@gmail.com>
	<11734389362943-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60925 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1767202AbXCILmZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 06:42:25 -0500
In-Reply-To: <11734389362943-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

> * promise: SATA/PATA branches are converted into separate ops.
>   Remaining ones are converted to more standard ap->cbl ==
>   ATA_CBL_SATA check.

NAK this specifically

I've got some pending and needed patches to spot where drives report SATA
and the host is doing PATA cables. This is needed for various warped PATA
controller and glue variants and means that the PATA port probe may end
up returning with ap->cbl == ATA_CBL_SATA if it finds SATA devices on a
supposedly PATA port.

Alan
