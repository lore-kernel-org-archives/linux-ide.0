From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH RESEND] ahci: Add JMicron 362 device IDs
Date: Sun, 9 Sep 2012 17:39:14 -0700
Message-ID: <20120910003850.GA158@mannheim-rule.local>
References: <1347235744.5134.14.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47195 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755700Ab2IJAh6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Sep 2012 20:37:58 -0400
Received: by pbbrr13 with SMTP id rr13so1679953pbb.19
        for <linux-ide@vger.kernel.org>; Sun, 09 Sep 2012 17:37:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1347235744.5134.14.camel@deadeye.wl.decadent.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Martin Michlmayr <tbm@cyrius.com>

Hi,

Ben Hutchings wrote:

> The JMicron JMB362 controller supports AHCI only, but some revisions
> use the IDE class code.  These need to be matched by device ID.
[...]
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
[...]
>  drivers/ata/ahci.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
[...]
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -263,6 +263,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
>  	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>  	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci_ign_iferr },
> +	/* JMicron 362B and 362C have an AHCI function with IDE class code */
> +	{ PCI_VDEVICE(JMICRON, 0x2362), board_ahci_ign_iferr },
> +	{ PCI_VDEVICE(JMICRON, 0x236f), board_ahci_ign_iferr },

Should this go to stable kernels as well?

Thanks,
Jonathan
