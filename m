From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: Re: ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Date: Sat, 23 Feb 2008 19:46:35 +0100
Message-ID: <19f34abd0802231046m2e8d3bcav224ae91f8e975579@mail.gmail.com>
References: <19f34abd0802230948n3b98b7d2kd67ca9c2f8fbbd47@mail.gmail.com>
	 <20080223183138.59d18e26@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.224]:19936 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757947AbYBWSqh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Feb 2008 13:46:37 -0500
Received: by wx-out-0506.google.com with SMTP id h31so796093wxd.4
        for <linux-ide@vger.kernel.org>; Sat, 23 Feb 2008 10:46:36 -0800 (PST)
In-Reply-To: <20080223183138.59d18e26@core>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Feb 23, 2008 at 7:31 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> O> I don't see the connection between (no-)smp and ata. Something with
>
> > interrupt routing/IPI, missing irq ack? Booting another !SMP kernel
>  > works fine. The problem also exists in 2.6.24-rc2.
>
>  Almost certainly interrupt routing try smp but with noapic and see if it
>  fails as well ?

Just a quick follow-up. On regular bootups, I get this message:

ata1: SATA max UDMA/133 cmd 0xf8850100 ctl 0x00000000 bmdma 0x00000000 irq 218
ata2: SATA max UDMA/133 cmd 0xf8850180 ctl 0x00000000 bmdma 0x00000000 irq 218

while the nosmp one gets this (the screenshot cut the irq part):

ata1: SATA max UDMA/133 abar m2048@0x9b304000 port 0x9b304100 irq 223
ata2: SATA max UDMA/133 abar m2048@0x9b304000 port 0x9b304100 irq 223

Don't know if the irq # change is significant or not. Will try noapic now.


Vegard
