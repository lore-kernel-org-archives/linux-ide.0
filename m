From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: Sparse warning in AHCI
Date: Mon, 8 Sep 2008 14:21:15 -0700
Message-ID: <20080908142115.773c4cb0@extreme>
References: <20080908092801.474aa23c@extreme>
	<48C5790A.7030900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.vyatta.com ([216.93.170.194]:35391 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755391AbYIHVVR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Sep 2008 17:21:17 -0400
In-Reply-To: <48C5790A.7030900@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Mon, 08 Sep 2008 21:12:10 +0200
Tejun Heo <htejun@gmail.com> wrote:

> Stephen Hemminger wrote:
> > Not sure how you want to fix this:
> > 
> >   CHECK   drivers/acpi/pci_irq.c
> > drivers/ata/ahci.c:323:2: warning: Initializer entry defined twice
> > drivers/ata/ahci.c:324:3:   also defined here
> > 
> > This happens because macro ATA_BASE_SHT(drv_name) defines .can_queue
> > then then later in the initializer for ahci_sht, it gets redefined.
> > 
> > Granted it probably works now, but sparse is correct to complain that
> > this is bad usage.
> > 
> 
> Hmm... That use is pretty much intentional to provide generic default
> initial value and allow specific drivers to override if necessary and I
> believe it's a valid C usage, no?

IANAL as Viro
