From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: workaround DRQ=1 ERR=1 for ATAPI tape drives
Date: Tue, 13 Nov 2007 19:35:10 +0900
Message-ID: <47397DDE.70201@gmail.com>
References: <471C6C44.2030607@gmail.com> <471CEDD4.5040201@garzik.org> <471D25D0.9020702@rtr.ca> <47397784.9070205@tw.ibm.com> <47397CC0.1070401@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:42097 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbXKMKfT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 05:35:19 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1343879rvb
        for <linux-ide@vger.kernel.org>; Tue, 13 Nov 2007 02:35:18 -0800 (PST)
In-Reply-To: <47397CC0.1070401@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Albert Lee wrote:
> After an error condition, some ATAPI tape drives set DRQ=1 together with ERR=1
> when asking the host to transfer the CDB of the next packet command (i.e. request sense).
> This patch workarounds the problem by ignoring the ERR bit and proceed REQUEST SENSE.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Mark Lord <liml@rtr.ca>

Looks okay to me.  Or anyone thinks the condition should be more strict?

-- 
tejun
