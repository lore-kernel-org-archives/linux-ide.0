From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: + via-pata-controller-xfer-fixes.patch added to -mm tree
Date: Sun, 02 Jul 2006 15:06:45 +0200
Message-ID: <44A7C4E5.6020202@free.fr>
References: <200606242214.k5OMEHCU005963@shell0.pdx.osdl.net> <449DBE88.5020809@garzik.org> <449DBFFD.2010700@garzik.org> <449E5445.60008@free.fr> <44A4CE21.30009@tw.ibm.com> <1151654134.44a4d8f6dc320@imp5-g19.free.fr> <44A4E01D.8020604@tw.ibm.com> <44A78599.9060405@free.fr> <44A7A0C8.80108@free.fr> <44A7C00A.7040001@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1-g19.free.fr ([212.27.42.27]:20192 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751274AbWGBNGs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Jul 2006 09:06:48 -0400
In-Reply-To: <44A7C00A.7040001@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, B.Zolnierkiewicz@elka.pw.edu.pl, htejun@gmail.com, Linux Kernel <linux-kernel@vger.kernel.org>, Unicorn Chang <uchang@tw.ibm.com>, Doug Maxey <dwm@maxeymade.com>

Hi,

Albert Lee wrote:
> Hi Matthieu,
> 
> Thanks for the log. But could you please keep the 
> VPRINTK() in the entrance of ata_host_intr()
If I do that, everything works correctly : the printk should take more 
than 3 us, and the altsatus is not busy when we read it.
Here is the log without moving the printk : 
http://castet.matthieu.free.fr/tmp/ata_log.orig

The only thing I could do is to move the printk between altstatus and 
status check and add one in idle_irq.

Will it be usefull for you ?


Matthieu.

