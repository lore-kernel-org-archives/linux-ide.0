From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] libata: workaround DRQ=1 ERR=1 for ATAPI tape
 drives
Date: Wed, 14 Nov 2007 12:19:25 +0000
Message-ID: <20071114121925.0c9eb5ce@the-village.bc.nu>
References: <471C6C44.2030607@gmail.com>
	<471CEDD4.5040201@garzik.org>
	<471D25D0.9020702@rtr.ca>
	<47397784.9070205@tw.ibm.com>
	<47397CC0.1070401@tw.ibm.com>
	<4739AB5B.7000703@rtr.ca>
	<20071113151459.086ffcae@the-village.bc.nu>
	<4739DDDD.7060305@rtr.ca>
	<20071113181257.24ab95dd@the-village.bc.nu>
	<4739EB53.5010206@rtr.ca>
	<473A56CE.4080804@gmail.com>
	<473A91F1.1060003@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33755 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752194AbXKNMWn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 07:22:43 -0500
In-Reply-To: <473A91F1.1060003@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: albertcc@tw.ibm.com, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

On Wed, 14 Nov 2007 14:13:05 +0800
Albert Lee <albertcc@tw.ibm.com> wrote:

> After an error condition, some ATAPI tape drives set DRQ=1 together with ERR=1
> when asking the host to transfer the CDB of the next packet command (i.e. request sense).
> This patch, a revised version of Alan/Mark's previous patch, adds ATA_HORKAGE_STUCK_ERR
> to workaround the problem by ignoring the ERR bit and proceed sending the CDB.
> 
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Mark Lord <liml@rtr.ca>

Acked-by: Alan Cox <alan@redhat.com>

for both 1/2
