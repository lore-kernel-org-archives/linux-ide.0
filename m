From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: Question about PATA Sil680 Cache Line Size and Performance
 Degradation on ARM XScale
Date: Thu, 22 Feb 2007 00:04:00 +0000
Message-ID: <20070222000400.2c220b8f@lxorguk.ukuu.org.uk>
References: <8202f4270702211456h52498bbdk560d9d47e2e319d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47475 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1945902AbXBUXAM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Feb 2007 18:00:12 -0500
In-Reply-To: <8202f4270702211456h52498bbdk560d9d47e2e319d7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

On Wed, 21 Feb 2007 15:56:28 -0700
"Fajun Chen" <fajunchen@gmail.com> wrote:

> Hi Folks,
> 
> I've noticed the following code in both pata_sil680.c and IDE code siimage.c
>         /* FIXME: double check */
> 	pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, (class_rev) ? 1 : 255);
> I was unable to find the recommended setting in Sil680 document. Could
> someone explain the rational behind the code above? Does it need to be
> adjusted on different processors for PCI read/write performance?

The code is inherited from the original bits by Andre Hedrick who had
access to the chip errata documents, which afaik have never been
published. 

