From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: Re: ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Date: Sat, 23 Feb 2008 19:52:38 +0100
Message-ID: <19f34abd0802231052x926c873p3ceef7904a120087@mail.gmail.com>
References: <19f34abd0802230948n3b98b7d2kd67ca9c2f8fbbd47@mail.gmail.com>
	 <20080223183138.59d18e26@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:11420 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754840AbYBWSwj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Feb 2008 13:52:39 -0500
Received: by rv-out-0910.google.com with SMTP id k20so549714rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 23 Feb 2008 10:52:38 -0800 (PST)
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

noapic works fine.


V
