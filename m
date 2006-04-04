From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: convert ATAPI_ENABLE_DMADIR to module parameter
Date: Tue, 04 Apr 2006 08:44:37 -0400
Message-ID: <44326A35.2090705@pobox.com>
References: <1br232p2g092l611qrqvmvpuus2bqp7bc2@4ax.com> <4431CF4D.6000806@gmail.com> <4431D5F5.4010905@tw.ibm.com> <4431D6D1.9020206@gmail.com> <4431E08E.8040108@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33996 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932437AbWDDMop (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Apr 2006 08:44:45 -0400
In-Reply-To: <4431E08E.8040108@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Tejun Heo <htejun@gmail.com>, Jonathan Blake Benson <airbatica@verizon.net>, linux-ide@vger.kernel.org, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> Convert the ATAPI_ENABLE_DMADIR compile time option needed
> by some SATA-PATA bridge to runtime module parameter.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> Before we can detect the bridge chips which need the ATAPI DMADIR workaround
> automatically, maybe using a module parameter is easier for the end users to
> turn on this option.

agreed, applied


