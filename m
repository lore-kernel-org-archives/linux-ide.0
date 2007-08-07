From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: implement BROKEN_HPA horkage and apply it to
 HDS724040KLSA80
Date: Tue, 7 Aug 2007 20:41:01 +0100
Message-ID: <20070807204102.17ba6f91@the-village.bc.nu>
References: <20070807054250.GQ13674@htj.dyndns.org>
	<20070807162529.1781b21c@the-village.bc.nu>
	<46B89177.2040209@gmail.com>
	<46B8BE07.5020005@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48117 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755988AbXHGTeh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 15:34:37 -0400
In-Reply-To: <46B8BE07.5020005@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org, kelk1@comcast.net, lcapitulino@mandriva.com.br

> There's also this Fedora bug:
> 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=251047#c2
> 
> ...where after an error on the slave device the master starts throwing
> HPA errors after the port is reset. Don't know if it's related or
> not...

Looks unrelated. You get a timeout

ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x43 data 12 in
         res 40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)

and then the entire system shits itself

ata2.00: qc timeout (cmd 0xf8)
ata2.00: failed to set xfermode (err_mask=0x40)

Looks like the bus didn't come back from whatever broke it.
