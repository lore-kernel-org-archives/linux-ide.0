From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH -mm] jmicron: 40/80pin primary detection
Date: Tue, 30 Jan 2007 14:31:56 +0000
Message-ID: <20070130143156.41480254@localhost.localdomain>
References: <OF59067410.11A20F48-ON48257273.00150F04@jmicron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46884 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965468AbXA3OWC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 09:22:02 -0500
In-Reply-To: <OF59067410.11A20F48-ON48257273.00150F04@jmicron.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ethanhsiao@jmicron.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alan@redhat.com

>  	case PORT_PATA0:
>  		if (control & (1 << 3))	/* 40/80 pin primary */
> -			return 1;
> -		return 0;
> +			return 0;
> +		return 1;

Ack

> @@ -205,11 +205,11 @@
>  }
>  
>  static struct pci_device_id jmicron_pci_tbl[] = {
> -	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361), 0},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363), 1},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365), 2},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366), 3},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368), 4},
> +	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
> +	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
> +	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
> +	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
> +	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
>  	{ 0, },

That should have been fixed a while ago with the others that had that
same bug. Must have escaped somewhere.

Acked-by: Alan Cox <alan@redhat.com>
