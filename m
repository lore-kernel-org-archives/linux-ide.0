From: "Andrew Hall" <andrew.a.hall@gmail.com>
Subject: RE: CF flash IDE failure to attach with 2.6.20+
Date: Tue, 19 Jun 2007 09:23:52 +1000
Message-ID: <4677141c.1d1d640a.09ec.6a82@mx.google.com>
References: <11172839.post@talk.nabble.com> <46766BD3.4040702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:12535 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762556AbXFRXYN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 19:24:13 -0400
Received: by an-out-0708.google.com with SMTP id d31so367944and
        for <linux-ide@vger.kernel.org>; Mon, 18 Jun 2007 16:24:12 -0700 (PDT)
In-Reply-To: <46766BD3.4040702@gmail.com>
Content-Language: en-au
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, 'Alan Cox' <alan@lxorguk.ukuu.org.uk>, 'Jeff Garzik' <jeff@garzik.org>


> > ata1.00: configured for MWDMA2
> 
> For some reason, mwdma doesn't work in libata now.  I'm not sure why
> tho.  Alan, can you enlighten us?

If the CF is having trouble with DMA, how do I specifically turn off DMA
only on this one bus?

