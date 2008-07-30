From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: PIIX4: DMA timeout issue
Date: Wed, 30 Jul 2008 21:43:37 +0200
Message-ID: <200807302143.37693.bzolnier@gmail.com>
References: <488ED837.2060509@alcatel-lucent.com> <200807291713.29580.bzolnier@gmail.com> <488FBC6F.2080800@alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:4426 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731AbYG3TqK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2008 15:46:10 -0400
Received: by fk-out-0910.google.com with SMTP id 18so131605fkq.5
        for <linux-ide@vger.kernel.org>; Wed, 30 Jul 2008 12:46:09 -0700 (PDT)
In-Reply-To: <488FBC6F.2080800@alcatel-lucent.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gshan <gshan@alcatel-lucent.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>, "Maciej W. Rozycki" <macro@linux-mips.org>

On Wednesday 30 July 2008, gshan wrote:

[...]
 
> The IRQ routing issue has been fixed. IRQ routing system
> on my board is somewhat complicated: i8259->mlba (FPGA based
> PCI device)->MV64460(system controller). I forgot to set MV64460
> IRQ pin to level sensitive and edge sensitive was used, which caused
> interrupt lost finally. After changing this to level sensitive, everything
> seems fine. Now, the problem isn't interrupt lost, but suspending DMA
> operations.

Thanks for explaining this.

> > Also is the problem still present in 2.6.26 or 2.6.27-rc1?
> >
> > [ I don't see an information about the kernel version that is
> >   being used in either of threads? ]
> >   
> Sorry, I'm using 2.6.21 kernel.

Would be great to try with some recent one, the issue may have been
fixed already (which is quite likely given a number of bugfixes that
went in recent kernels).

Thanks,
Bart
