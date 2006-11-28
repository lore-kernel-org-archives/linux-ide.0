From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ahci: ignore PORT_IRQ_IF_ERR on JMB controllers
Date: Tue, 28 Nov 2006 03:49:20 -0500
Message-ID: <456BF810.3050604@pobox.com>
References: <20061121014802.GR2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:32898 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S935699AbWK1ItY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 03:49:24 -0500
In-Reply-To: <20061121014802.GR2184@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, justin@jmicron.com, andrew.lyon@gmail.com, fredrik@obra.se

Tejun Heo wrote:
> JMicron AHCI controllers set PORT_IRQ_IF_ERR on device errors.  The
> IRQ status bit indicates interface error or protocol mismatch and ahci
> driver interprets it into AC_ERR_ATA_BUS.  So, whenever an ATAPI
> device raises check condition, ahci interprets it as ATA bus error and
> thus resets it which, in turn, raises check condition thus creating a
> reset loop and rendering the device unuseable.
> 
> This patch makes JMB controllers ignore PORT_IRQ_IF_ERR when
> interpreting error condition.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Justin Tsai <justin@jmicron.com>

ACK, but please resend against latest #upstream-fixes (which includes 
Intel ahci ICH9 PCI IDs)

