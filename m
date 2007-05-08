From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: disable_irq() during polling IDENTIFY (take 2)
Date: Tue, 8 May 2007 13:00:25 +0100
Message-ID: <20070508130025.7693980c@the-village.bc.nu>
References: <463EAB4D.3000309@tw.ibm.com>
	<463ED8B9.4060501@gmail.com>
	<463F0B25.40103@tw.ibm.com>
	<463F0DAD.5060307@gmail.com>
	<463F1374.1010100@tw.ibm.com>
	<463F1509.30100@gmail.com>
	<46405F50.5090901@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55752 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S967312AbXEHL4d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 07:56:33 -0400
In-Reply-To: <46405F50.5090901@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: albertcc@tw.ibm.com, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

On Tue, 08 May 2007 19:30:24 +0800
Albert Lee <albertcc@tw.ibm.com> wrote:

> Problem:
>   Kernel got "irq 5: nobody cared" when using
>   libata + polling IDENTIFY + Promise 20275 adapter + Benq DW1620 drive.
> 
>   Detail message available in bug 8441 (http://bugzilla.kernel.org/show_bug.cgi?id=8441).
> 
> Cause:
>   The Benq DW1620 drive raises INTRQ during polling IDENTIFY PACKET DEVICE, 
>   even if nIEN = 1.
> 
> Proposed fix:
>   Ack the possibly unexpected irq in ata_interrupt().
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

NAK

We can't do this. A PIO data transfer could take far far too long to be
under IRQ block (its already a problem on a big 32bit box when we bounce
buffer it sometimes).

Alan
