From: Paolo Ornati <ornati@fastwebnet.it>
Subject: Re: [PATCH] blacklist NCQ on Seagate Barracuda ST380817AS
Date: Sun, 30 Sep 2007 17:52:07 +0200
Message-ID: <20070930175207.5bfa89a8@localhost>
References: <20070930160548.235be972@localhost>
	<20070930152908.1f58d39d@the-village.bc.nu>
	<20070930164610.20818867@localhost>
	<46FFBB2D.6060004@garzik.org>
	<20070930172859.7fd44eab@localhost>
	<46FFC42A.9080300@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:36772 "EHLO
	aa012msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757473AbXI3PwR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Sep 2007 11:52:17 -0400
In-Reply-To: <46FFC42A.9080300@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Sun, 30 Sep 2007 11:43:38 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> > it isn't supported here:
> > sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA  
> 
> Did you actually try my suggestion?

Yes ("libata.fua=1" is ok I think, or it should just be "libata.fua"?):
...
[    0.000000] Kernel command line: root=/dev/sda6 ro vga=0x305 libata.fua=1
...
[  285.004166] ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
...


> 
> That message is normal, because libata defaults to FUA==off.

-- 
	Paolo Ornati
	Linux 2.6.23-rc8-ga64314e6 on x86_64
