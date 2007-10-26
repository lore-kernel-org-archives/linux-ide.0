From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/3] ide: fix drive_is_ready() for non-PCI hosts and CONFIG_IDEPCI_SHARE_IRQ=y
Date: Thu, 25 Oct 2007 20:42:16 -0400
Message-ID: <472137E8.9020109@garzik.org>
References: <200710260136.37333.bzolnier@gmail.com> <20071026010515.260672b4@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43296 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830AbXJZAmU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 20:42:20 -0400
In-Reply-To: <20071026010515.260672b4@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Fri, 26 Oct 2007 01:36:37 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
>> Need to check if the host is a PCI one before reading IDE_ALTSTATUS_REG.
>>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Umm why ? The altstatus register goes back to ST-506 and the original IBM
> XT hard disk controller card ?

I'm pretty sure there are at least a few controllers out there where the 
AltStatus/Control register block is simply non-existent.

	Jeff



