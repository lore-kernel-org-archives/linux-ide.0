From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_it8213: Add new driver for the IT8213 card.
Date: Mon, 4 Dec 2006 21:55:58 +0000
Message-ID: <20061204215558.63bc4e90@localhost.localdomain>
References: <20061204164931.7d36d744@localhost.localdomain>
	<20061204124344.a7c21221.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:54331 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S964941AbWLDWDE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Dec 2006 17:03:04 -0500
In-Reply-To: <20061204124344.a7c21221.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

> Was the duplication of timings[] deliberate?

It's actually duplicated in all the PIIX/ICH-alike drivers. I could move
it in them all. Jeff - its copied from your piix driver - shall I move
them all ?

 
> diff -puN include/linux/pci_ids.h~pata_it8213-add-new-driver-for-the-it8213-card-tidy include/linux/pci_ids.h
> --- a/include/linux/pci_ids.h~pata_it8213-add-new-driver-for-the-it8213-card-tidy
> +++ a/include/linux/pci_ids.h
> @@ -1622,6 +1622,7 @@
>  #define PCI_VENDOR_ID_ITE		0x1283
>  #define PCI_DEVICE_ID_ITE_8211		0x8211
>  #define PCI_DEVICE_ID_ITE_8212		0x8212
> +#define PCI_DEVICE_ID_ITE_8213		0x8213

Sorry about that one - your guess is 100% correct of course
