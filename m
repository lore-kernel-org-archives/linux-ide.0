From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata-tj and SMART
Date: Thu, 18 May 2006 11:54:50 -0400
Message-ID: <446C98CA.50008@garzik.org>
References: <e4b02t$e9b$1@sea.gmane.org> <44690B0F.90200@gmail.com> <e4bvsb$s9m$1@sea.gmane.org> <4469893A.10901@gmail.com> <e4g3or$jbm$1@sea.gmane.org> <446BF147.4040904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51331 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751096AbWERPy4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 May 2006 11:54:56 -0400
In-Reply-To: <446BF147.4040904@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Nicolas STRANSKY <Nico@stransky.cx>, linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>

Tejun Heo wrote:
> It seems that HSM_ST needs to handle !DRQ && ERR case before the first 
> iteration (or maybe it should be pushed into HSM_ST_FIRST?).  Does my 
> analysis make sense?

Agreed, though we should check for ERR on ATAPI path first, too, IMO.

	Jeff



