From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Add ALPM power state accounting to the AHCI driver
Date: Mon, 16 Nov 2009 03:06:32 +0900
Message-ID: <4B004328.8060807@kernel.org>
References: <20091113192429.4dfc9c39@infradead.org>	<4AFFB65F.3020201@kernel.org>	<4AFFBB75.7050601@pobox.com> <20091115094630.1785b5ca@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51531 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753346AbZKOSHo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Nov 2009 13:07:44 -0500
In-Reply-To: <20091115094630.1785b5ca@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, akpm@linux-foundation.org

Arjan van de Ven wrote:
> On Sun, 15 Nov 2009 03:27:33 -0500
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>> What little there is of driver-specific behavior can be handled from 
>> existing callbacks (->enable_pm) or by creating a driver-specific 
>> function that calls a generic function (eg. ahci_alpm_set_accounting 
>> could call ata_alpm_set_accounting, before twiddling AHCI's
>> PORT_IRQ_MASK).
> 
> the whole concept of needing that accounting flag is AHCI specific;
> if ever any of the other chip drivers goes to do ALPM, it'll be using
> explicit software control, which doesn't need this kind of enable flag;
> The only reason there is an enable flag is that the hw based accounting
> is resulting in extra interrupts that you don't want except when you
> want the accounting (read: powertop is running)

There's DIPM.

-- 
tejun
