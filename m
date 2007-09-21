From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Set transfer sizes properly for ATAPI
Date: Fri, 21 Sep 2007 18:34:07 -0400
Message-ID: <46F446DF.2050806@garzik.org>
References: <20070920150144.4772e18d@the-village.bc.nu>	<46F2DC54.8040908@garzik.org> <20070921231416.795da300@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41986 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764692AbXIUWeJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Sep 2007 18:34:09 -0400
In-Reply-To: <20070921231416.795da300@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> On Thu, 20 Sep 2007 16:47:16 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> Alan Cox wrote:
>>> In theory this isn't needed. In practice it seems to matter now and then
>>> and was also done by the old IDE DMA layer.
>>>
>>> Signed-off-by: Alan Cox <alan@redhat.com>
>> applied a modified version (attached)
> 
> NAK your version on testing. Mine works, yours doesn't.

Yeah I already reverted it from #upstream


