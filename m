From: Maxime Bizon <mbizon@freebox.fr>
Subject: "irq 4: nobody cared" when loading ahci driver on ce4100
Date: Mon, 14 Mar 2011 20:08:27 +0100
Message-ID: <1300129707.28545.34.camel@sakura.staff.proxad.net>
Reply-To: mbizon@freebox.fr
Mime-Version: 1.0
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:49820 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755145Ab1CNTIg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Mar 2011 15:08:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide <linux-ide@vger.kernel.org>


Hi Jeff & all,

I'm using an Intel CE4100 platform (Sodaville), and when I load the ahci
driver I get a short lock, then this message.

On the original ahci driver (back in 2007), the ata port interrupts were
not enabled until irq handler was registred (in ahci_thaw()).

But since commit 1c954a4d9a9e351fa3509533fd8dd5f3821206cd (ahci: clean
up PORT_IRQ_BAD_PMP enabling), it is now done early in
ahci_pmp_attach/ahci_pmp_detach:

ata_host_activate => port_start() callback => ahci_port_resume()

before ahci interrupt handler is even registered.

On my board, port irq stat is 0x00400040 before port mask is changed,
that's why interrupt is triggered immediately.

Any idea on the clean way to fix this ?

Thanks,

-- 
Maxime


