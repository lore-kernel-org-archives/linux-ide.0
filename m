From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: "irq 4: nobody cared" when loading ahci driver on ce4100
Date: Mon, 14 Mar 2011 18:59:23 -0600
Message-ID: <4D7EB9EB.8030807@gmail.com>
References: <1300129707.28545.34.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43818 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756234Ab1COA70 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Mar 2011 20:59:26 -0400
Received: by iwn34 with SMTP id 34so102470iwn.19
        for <linux-ide@vger.kernel.org>; Mon, 14 Mar 2011 17:59:25 -0700 (PDT)
In-Reply-To: <1300129707.28545.34.camel@sakura.staff.proxad.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mbizon@freebox.fr
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, linux-ide <linux-ide@vger.kernel.org>

On 03/14/2011 01:08 PM, Maxime Bizon wrote:
>
> Hi Jeff&  all,
>
> I'm using an Intel CE4100 platform (Sodaville), and when I load the ahci
> driver I get a short lock, then this message.
>
> On the original ahci driver (back in 2007), the ata port interrupts were
> not enabled until irq handler was registred (in ahci_thaw()).
>
> But since commit 1c954a4d9a9e351fa3509533fd8dd5f3821206cd (ahci: clean
> up PORT_IRQ_BAD_PMP enabling), it is now done early in
> ahci_pmp_attach/ahci_pmp_detach:
>
> ata_host_activate =>  port_start() callback =>  ahci_port_resume()
>
> before ahci interrupt handler is even registered.
>
> On my board, port irq stat is 0x00400040 before port mask is changed,
> that's why interrupt is triggered immediately.
>
> Any idea on the clean way to fix this ?

Where is ahci_thaw being called? It shouldn't be called before the IRQ 
handler is registered - I think it should only be called from the error 
handler which would be way later..
