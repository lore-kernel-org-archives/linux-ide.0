From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: workaround DRQ=1 ERR=1 for ATAPI tape drives
Date: Tue, 13 Nov 2007 15:14:59 +0000
Message-ID: <20071113151459.086ffcae@the-village.bc.nu>
References: <471C6C44.2030607@gmail.com>
	<471CEDD4.5040201@garzik.org>
	<471D25D0.9020702@rtr.ca>
	<47397784.9070205@tw.ibm.com>
	<47397CC0.1070401@tw.ibm.com>
	<4739AB5B.7000703@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59252 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752936AbXKMPRU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 10:17:20 -0500
In-Reply-To: <4739AB5B.7000703@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

> NAK.  There's no guarantee that the next command after an error
> will always be REQUEST_SENSE.   Or is there?

For that device over ATAPI I believe the guarantee is there, the same as
for SCSI.

Alan
