From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Date: Mon, 25 Feb 2008 15:03:17 -0500
Message-ID: <47C31F05.2070307@redhat.com>
References: <19f34abd0802230948n3b98b7d2kd67ca9c2f8fbbd47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:40225 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754109AbYBYUDr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Feb 2008 15:03:47 -0500
In-Reply-To: <19f34abd0802230948n3b98b7d2kd67ca9c2f8fbbd47@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 02/23/2008 12:48 PM, Vegard Nossum wrote:
> 
> I don't see the connection between (no-)smp and ata. Something with
> interrupt routing/IPI, missing irq ack? Booting another !SMP kernel
> works fine. The problem also exists in 2.6.24-rc2.
> 

"nosmp" disables the IO-APIC which will change interrupt handling.

If you just want to enable a single CPU, use "maxcpus=1".
