From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] libata: Add ALPM power state accounting to the AHCI
 driver
Date: Sun, 15 Nov 2009 09:46:30 -0800
Message-ID: <20091115094630.1785b5ca@infradead.org>
References: <20091113192429.4dfc9c39@infradead.org>
	<4AFFB65F.3020201@kernel.org>
	<4AFFBB75.7050601@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:39042 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790AbZKORoz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Nov 2009 12:44:55 -0500
In-Reply-To: <4AFFBB75.7050601@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, akpm@linux-foundation.org

On Sun, 15 Nov 2009 03:27:33 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> 
> What little there is of driver-specific behavior can be handled from 
> existing callbacks (->enable_pm) or by creating a driver-specific 
> function that calls a generic function (eg. ahci_alpm_set_accounting 
> could call ata_alpm_set_accounting, before twiddling AHCI's
> PORT_IRQ_MASK).

the whole concept of needing that accounting flag is AHCI specific;
if ever any of the other chip drivers goes to do ALPM, it'll be using
explicit software control, which doesn't need this kind of enable flag;
The only reason there is an enable flag is that the hw based accounting
is resulting in extra interrupts that you don't want except when you
want the accounting (read: powertop is running)


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
