From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/1] libata-dev: Remove ATA_PROT_PIO_MULT
Date: Tue, 21 Mar 2006 20:42:16 -0500
Message-ID: <4420AB78.5090305@pobox.com>
References: <441936FA.6060501@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:7355 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751964AbWCVBmR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 20:42:17 -0500
In-Reply-To: <441936FA.6060501@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: IDE Linux <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Remove the ATA_PROT_PIO_MULT protocol.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> 
> The ATA_PROT_PIO_MULT can be handled as ATA_PROT_PIO.
> Remove it.
> 
> Changes:
>   - Remove the ATA_PROT_PIO_MULT protocol
>   - Filter out the PIO multi commands in ATA pass through

applied.  it would be nice if you would move the text following 
"Changes:" from the Albert-comments section to the actual patch 
description.  Anything that can help describe the rationale behind the 
patch belongs in the main patch description.

The section after the "---" is for related comments, questions, worries, 
insults, etc.  :)

	Jeff



