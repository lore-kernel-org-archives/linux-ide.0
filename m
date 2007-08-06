From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] hpt366: fix PCI clock detection for HPT374
Date: Mon, 6 Aug 2007 20:29:58 +0100
Message-ID: <20070806202958.25670cc1@the-village.bc.nu>
References: <200708060006.35511.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40590 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1765695AbXHFTXL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Aug 2007 15:23:11 -0400
In-Reply-To: <200708060006.35511.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, rah@bash.sh, linux-ide@vger.kernel.org

> +		if (chip_type == HPT374 && (PCI_FUNC(dev->devfn) & 1)) {
> +			struct pci_dev	*dev1 = pci_get_slot(dev->bus,
> +							     dev->devfn - 1);

Can be NULL
> +			unsigned long io_base = pci_resource_start(dev1, 4);

Kaboom
