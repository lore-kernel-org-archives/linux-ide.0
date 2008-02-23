From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Date: Sat, 23 Feb 2008 18:31:38 +0000
Message-ID: <20080223183138.59d18e26@core>
References: <19f34abd0802230948n3b98b7d2kd67ca9c2f8fbbd47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58405 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757146AbYBWSl6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Feb 2008 13:41:58 -0500
In-Reply-To: <19f34abd0802230948n3b98b7d2kd67ca9c2f8fbbd47@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

O> I don't see the connection between (no-)smp and ata. Something with
> interrupt routing/IPI, missing irq ack? Booting another !SMP kernel
> works fine. The problem also exists in 2.6.24-rc2.

Almost certainly interrupt routing try smp but with noapic and see if it
fails as well ?
