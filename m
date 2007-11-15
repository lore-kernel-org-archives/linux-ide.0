From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/2] libata: workaround DRQ=1 ERR=1 for ATAPI tape drives
Date: Thu, 15 Nov 2007 09:32:29 +0900
Message-ID: <473B939D.2030504@gmail.com>
References: <471C6C44.2030607@gmail.com>	<471CEDD4.5040201@garzik.org>	<471D25D0.9020702@rtr.ca>	<47397784.9070205@tw.ibm.com>	<47397CC0.1070401@tw.ibm.com>	<4739AB5B.7000703@rtr.ca>	<20071113151459.086ffcae@the-village.bc.nu>	<4739DDDD.7060305@rtr.ca> <20071113181257.24ab95dd@the-village.bc.nu> <4739EB53.5010206@rtr.ca> <473A56CE.4080804@gmail.com> <473A91F1.1060003@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:5816 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbXKOAch (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 19:32:37 -0500
Received: by wa-out-1112.google.com with SMTP id v27so434502wah
        for <linux-ide@vger.kernel.org>; Wed, 14 Nov 2007 16:32:37 -0800 (PST)
In-Reply-To: <473A91F1.1060003@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Albert Lee wrote:
> After an error condition, some ATAPI tape drives set DRQ=1 together with ERR=1
> when asking the host to transfer the CDB of the next packet command (i.e. request sense).
> This patch, a revised version of Alan/Mark's previous patch, adds ATA_HORKAGE_STUCK_ERR
> to workaround the problem by ignoring the ERR bit and proceed sending the CDB.
> 
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Mark Lord <liml@rtr.ca>

applied to #tj-upstream-fixes.

-- 
tejun
