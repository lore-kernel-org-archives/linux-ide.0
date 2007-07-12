From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/7] libata: remove irq_on from ata_bus_reset() and ata_std_postreset()
Date: Thu, 12 Jul 2007 16:12:35 -0400
Message-ID: <46968B33.2070406@garzik.org>
References: <468F3949.5050800@tw.ibm.com> <468F3A15.5060404@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55597 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755999AbXGLUMl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Jul 2007 16:12:41 -0400
In-Reply-To: <468F3A15.5060404@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Maxey <dwm@enoyolf.org>, Mark Lord <mlord@pobox.com>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
>   It seems irq_on() in ata_bus_reset() and ata_std_postreset()
> are leftover of the EDD reset. Remove them.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

applied


