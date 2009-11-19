From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH v2] ata: New PATA driver for Altera CompactFlash.
Date: Thu, 19 Nov 2009 18:27:07 -0500
Message-ID: <4B05D44B.9010606@garzik.org>
References: <1254967110-3495-1-git-send-email-thomas@wytron.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51648 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755233AbZKSX1H (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Nov 2009 18:27:07 -0500
In-Reply-To: <1254967110-3495-1-git-send-email-thomas@wytron.com.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Chou <thomas@wytron.com.tw>
Cc: linux-ide@vger.kernel.org, Nios2 development list <nios2-dev@sopc.et.ntust.edu.tw>, linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>

On 10/07/2009 09:58 PM, Thomas Chou wrote:
> This patch adds a new PATA driver to support the Altera SOPC Builder
> CompactFlash component as a PATA device with support for insertion
> and removal of CF cards.  It uses the platform driver model.
>
> For each probed platform device, the driver spawns a kthread to
> handle insertion and removal of CF cards by creating and removing the
> underlying ATA host interface.  The Altera CompactFlash component
> includes a register bit to indicate whether a CF card is detected
> and an interrupt triggered when this bit changes.  The driver has a
> handler for this interrupt which flags that something has changed and
> wakes up the kthread to deal with it.
>
> The platform device uses 2 IORESOURCE_MEM resources and 2
> IORESOURCE_IRQ resources.  The first memory resource is for the
> CompactFlash component's IDE registers and the second is for the
> component's CF status and control registers.  The first IRQ resource
> is for the IDE and the second is for the CF detection interrupt.
>
> Signed-off-by: Ian Abbott<abbotti@mev.co.uk>
> Signed-off-by: Thomas Chou<thomas@wytron.com.tw>
> ---
>   drivers/ata/Kconfig          |   11 +
>   drivers/ata/Makefile         |    1 +
>   drivers/ata/pata_altera_cf.c |  582 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 594 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/ata/pata_altera_cf.c

Ping...  still waiting on v3, updated with Alan's feedback.


