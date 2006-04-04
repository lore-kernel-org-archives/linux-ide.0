From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: convert ATAPI_ENABLE_DMADIR to module parameter
Date: Tue, 04 Apr 2006 12:07:23 +0900
Message-ID: <4431E2EB.9040703@gmail.com>
References: <1br232p2g092l611qrqvmvpuus2bqp7bc2@4ax.com> <4431CF4D.6000806@gmail.com> <4431D5F5.4010905@tw.ibm.com> <4431D6D1.9020206@gmail.com> <4431E08E.8040108@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.177]:54807 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964985AbWDDDH2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Apr 2006 23:07:28 -0400
Received: by pproxy.gmail.com with SMTP id f25so1496417pyf
        for <linux-ide@vger.kernel.org>; Mon, 03 Apr 2006 20:07:27 -0700 (PDT)
In-Reply-To: <4431E08E.8040108@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Jonathan Blake Benson <airbatica@verizon.net>, linux-ide@vger.kernel.org, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> Convert the ATAPI_ENABLE_DMADIR compile time option needed
> by some SATA-PATA bridge to runtime module parameter.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
