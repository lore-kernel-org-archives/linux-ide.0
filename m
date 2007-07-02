From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/1] libata: pata_pdc2027x PLL input clock fix
Date: Mon, 02 Jul 2007 10:14:21 -0400
Message-ID: <4689083D.3030500@garzik.org>
References: <7ac1e90c0706210447k7c1bdb26y43d62e930ce7728e@mail.gmail.com>	<467A9923.6010203@ru.mvista.com>	<467F5127.4060006@tw.ibm.com> <20070625101009.48269d6e@the-village.bc.nu> <46809EA7.5090005@tw.ibm.com> <4680A773.2020009@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51864 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754793AbXGBOOc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Jul 2007 10:14:32 -0400
In-Reply-To: <4680A773.2020009@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bahadir Balban <bahadir.balban@gmail.com>, linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>, Doug Maxey <dwm@enoyolf.org>

Albert Lee wrote:
> Recently the PLL input clock of pata_pdc2027x is sometimes detected
> higer than expected (e.g. 20.027 MHz compared to 16.714 MHz).
> It seems sometimes the mdelay() function is not as precise as it
> used to be. Per Alan's advice, HT or power management might affect
> the precision of mdelay().
> 
> This patch calls gettimeofday() to mesure the time elapsed and
> calculate the PLL input clock accordingly.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> ---
> 
> Did more test. For mdelay(100) the usec_elapsed is usually 99287.
> However, sometimes the usec_elapsed is 118934, longer than expected.
> 
> Jun 26 12:12:29 p4ht-s kernel: [ 9156.490991] ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNK1] -> GSI 10 (level, low) -> IRQ 10
> Jun 26 12:12:29 p4ht-s kernel: [ 9156.610175] usec_elapsed[118934]
> Jun 26 12:12:29 p4ht-s kernel: [ 9156.610511] pata_pdc2027x 0000:02:05.0: PLL input clock 16817 kHz
> 
> After the patch, the PLL input clock detected looks more accurate.
> For your review, thanks.

applied


