From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 01/11] ahci: Get rid of host->iomap usage
Date: Wed, 03 Mar 2010 13:45:36 -0500
Message-ID: <4B8EAE50.2090800@pobox.com>
References: <20100303171713.GA6322@oksana.dev.rtsoft.ru> <20100303171734.GA12362@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f182.google.com ([209.85.223.182]:56276 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416Ab0CCSpj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Mar 2010 13:45:39 -0500
In-Reply-To: <20100303171734.GA12362@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/03/2010 12:17 PM, Anton Vorontsov wrote:
> Currently the driver uses host->iomap to store all the iomapped BARs
> of a PCI device (while AHCI devices actually use just a single memory
> window).
>
> We're going to teach AHCI to work with non-PCI buses, so there are two
> options to make this work:
>
> 1. "fake" host->iomap array for non-PCI devices, and place the needed
>     address at iomap[AHCI_PCI_BAR];
> 2. Get rid of host->iomap usage, instead introduce a private mmio
>     field.
>
> This patch implements the second option.
>
> Signed-off-by: Anton Vorontsov<avorontsov@ru.mvista.com>
> ---
>   drivers/ata/ahci.c |   34 ++++++++++++++++++++--------------
>   1 files changed, 20 insertions(+), 14 deletions(-)

Does platform code not contain any devres support?

At a minimum, you should be using devm_ioremap(), yes?

	Jeff



