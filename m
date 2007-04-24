From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 7/7] libata: send event when AN received
Date: Tue, 24 Apr 2007 09:09:10 +0100
Message-ID: <20070424090910.1d145c24@the-village.bc.nu>
References: <20070424074856.005152262@intel.com>
	<20070423170024.73b74a37.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46170 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751690AbXDXIFi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Apr 2007 04:05:38 -0400
In-Reply-To: <20070423170024.73b74a37.kristen.c.accardi@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, htejun@gmail.com, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

> +		/* check the 'N' bit in word 0 of the FIS */
> +		if (f[0] & (1 << 15)) {
> +			int port_addr =  ((f[0] & 0x00000f00) >> 8);
> +			struct ata_device *adev = &ap->device[port_addr];

You can't be sure that the port_addr returned will be in range if a
device is malfunctioning...

