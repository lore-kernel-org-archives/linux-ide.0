From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: sata_via: SError: { UnrecovData Proto TrStaTrns }
Date: Mon, 05 Oct 2009 19:58:40 -0600
Message-ID: <4ACAA450.6030405@gmail.com>
References: <m3my46yo5g.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:31997 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675AbZJFB7w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Oct 2009 21:59:52 -0400
In-Reply-To: <m3my46yo5g.fsf@intrepid.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/05/2009 07:18 AM, Krzysztof Halasa wrote:
> Hi,
>
> What could that be?
> VIA VT6421A mini-PCI card and SATA SSD from Transcend. IXP425 (ARM)
> little-endian CPU. 128 MB RAM - VT6421A can access only the first 64 MB
> of system RAM, but there is bounce buffering (a la swiotlb) for the
> rest.
>
> Sometimes it produces:
>
> ata1.00: exception Emask 0x12 SAct 0x0 SErr 0x1000500 action 0x6
> ata1.00: BMDMA stat 0x5
> ata1: SError: { UnrecovData Proto TrStaTrns }
> ata1.00: cmd c8/00:20:b7:18:38/00:00:00:00:00/e0 tag 0 dma 16384 in
>           res 51/40:20:b7:18:38/00:00:00:00:00/e0 Emask 0x12 (ATA bus error)
> ata1.00: status: { DRDY ERR }
> ata1.00: error: { UNC }
> ata1: hard resetting link
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata1.00: configured for UDMA/100
> ata1: EH complete
>
> Any ideas?

Presumably a SATA bus communication error. Are you sure the SATA 
connections and cable are good?
