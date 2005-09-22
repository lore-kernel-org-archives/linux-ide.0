From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH/RFC 3/3] libata: interrupt driven pio for LLD
Date: Thu, 22 Sep 2005 08:56:31 -0400
Message-ID: <4332A9FF.3010400@rtr.ca>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com> <43322C50.1060009@tw.ibm.com> <43322FBB.5060403@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:5269 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1030290AbVIVM4b
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Sep 2005 08:56:31 -0400
In-Reply-To: <43322FBB.5060403@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Brett Russ <russb@emc.com>

Albert Lee wrote:
> Patch 3/3: interrupt driven pio patch for LLD
> 
> sata_qstor.c:
>  Private irq handler, need modification to handle interrupt driven mode 
> in the future.
>  Use polling mode for the unsupported protocols for the time being.
...
  	default:
+		/* FIXME: qs_intr_mmio() doesn't handle
+		 * interrupt driven pio/atapi cdb intr yet.

The qs_intr_mmio() handler is set up for interrupt driven
pio/atapi usage, and should already be usable for that.

How do I cause a command to use "interrupt driven" PIO mode
with these patches?  I could try it to make sure it still works.

Cheers

Mark
