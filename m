From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sparse warning in AHCI
Date: Mon, 08 Sep 2008 21:12:10 +0200
Message-ID: <48C5790A.7030900@gmail.com>
References: <20080908092801.474aa23c@extreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:31689 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbYIHTNd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Sep 2008 15:13:33 -0400
Received: by ti-out-0910.google.com with SMTP id b6so989285tic.23
        for <linux-ide@vger.kernel.org>; Mon, 08 Sep 2008 12:13:32 -0700 (PDT)
In-Reply-To: <20080908092801.474aa23c@extreme>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Stephen Hemminger wrote:
> Not sure how you want to fix this:
> 
>   CHECK   drivers/acpi/pci_irq.c
> drivers/ata/ahci.c:323:2: warning: Initializer entry defined twice
> drivers/ata/ahci.c:324:3:   also defined here
> 
> This happens because macro ATA_BASE_SHT(drv_name) defines .can_queue
> then then later in the initializer for ahci_sht, it gets redefined.
> 
> Granted it probably works now, but sparse is correct to complain that
> this is bad usage.
> 

Hmm... That use is pretty much intentional to provide generic default
initial value and allow specific drivers to override if necessary and I
believe it's a valid C usage, no?

Thanks.

-- 
tejun
