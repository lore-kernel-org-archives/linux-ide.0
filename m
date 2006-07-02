From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: + via-pata-controller-xfer-fixes.patch added to -mm tree
Date: Sun, 02 Jul 2006 22:17:21 +0800
Message-ID: <44A7D571.8030504@tw.ibm.com>
References: <200606242214.k5OMEHCU005963@shell0.pdx.osdl.net> <449DBE88.5020809@garzik.org> <449DBFFD.2010700@garzik.org> <449E5445.60008@free.fr> <44A4CE21.30009@tw.ibm.com> <1151654134.44a4d8f6dc320@imp5-g19.free.fr> <44A4E01D.8020604@tw.ibm.com> <44A78599.9060405@free.fr> <44A7A0C8.80108@free.fr> <44A7C00A.7040001@tw.ibm.com> <44A7C4E5.6020202@free.fr>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:7909 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751085AbWGBOR1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Jul 2006 10:17:27 -0400
In-Reply-To: <44A7C4E5.6020202@free.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: matthieu castet <castet.matthieu@free.fr>
Cc: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, B.Zolnierkiewicz@elka.pw.edu.pl, htejun@gmail.com, Linux Kernel <linux-kernel@vger.kernel.org>, Unicorn Chang <uchang@tw.ibm.com>, Doug Maxey <dwm@maxeymade.com>

matthieu castet wrote:
> Hi,
> 
> Albert Lee wrote:
> 
>> Hi Matthieu,
>>
>> Thanks for the log. But could you please keep the VPRINTK() in the
>> entrance of ata_host_intr()
> 
> If I do that, everything works correctly : the printk should take more
> than 3 us, and the altsatus is not busy when we read it.
> Here is the log without moving the printk :
> http://castet.matthieu.free.fr/tmp/ata_log.orig

Hmm, the Uncertainty principle also applies to kernel debugging. :)

> 
> The only thing I could do is to move the printk between altstatus and
> status check and add one in idle_irq.
> 
> Will it be usefull for you ?
> 
> 
> Matthieu.
> 
> 

>From your previous log, the timeout transacation is clearly logged
and it does look like early irq. Can compare/see both timeout and normal
behaviors of libata from both logs. So, the logs are good enough.

Thanks and appreciates for the logs, :)

Albert

