From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 09/11] ahci: convert to new EH
Date: Sat, 13 May 2006 18:30:43 -0400
Message-ID: <44665E13.9090300@pobox.com>
References: <1147353689306-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:15752 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932094AbWEMWav (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 May 2006 18:30:51 -0400
In-Reply-To: <1147353689306-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Convert AHCI to new EH.  Unfortunately, ICH7 AHCI reacts badly if IRQ
> mask is diddled during operation.  So, freezing is implemented by
> unconditionally clearing interrupt conditions while frozen.

For standard BMDMA hardware, you -absolutely must- stop DMA, before 
doing -anything- else, including EH/recovery.

This sort of scenario will be quite common.  I would recommend doing so 
on sata_sil, sata_promise, ...


> * Interrupts are categorized according to required action.
>   e.g. Connection status or unknown FIS error requires freezing the
>   port while TF or HBUS_DATA don't.
> 
> * Only CONNECT (reflects SErr.X) interrupt is taken into account not
>   PHYRDY (SErr.N), as CONNECT is better cue for starting EH.
> 
> * AHCI may be invoked without any active command.  e.g. CONNECT irq
>   occuring while no qc in progress still triggers EH and will reset
>   the port and revalidate attached device.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK

