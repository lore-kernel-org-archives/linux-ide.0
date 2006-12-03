From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_sl82c105 can not reserve IO region
Date: Sun, 3 Dec 2006 23:23:49 +0000
Message-ID: <20061203232349.72be01e7@localhost.localdomain>
References: <20061130165202.GA23205@aepfle.de>
	<20061203171216.GB21947@aepfle.de>
	<20061203222450.GA23765@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44709 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1758841AbWLCXQj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Dec 2006 18:16:39 -0500
In-Reply-To: <20061203222450.GA23765@aepfle.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On Sun, 3 Dec 2006 23:24:49 +0100 (MET)
Olaf Hering <olaf@aepfle.de> wrote:

> This change seems to fix it, only a single reset occurs. I think that
> one is normal when a CD is in the drive during bootup, maybe it leaves
> the drive in a confused state.
> 
> @@ -167,9 +175,13 @@ static void sl82c105_reset_engine(struct
>         struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>         u16 val;
> 
> +       udelay(42);
>         pci_read_config_word(pdev, 0x7E, &val);
> +       udelay(10);
>         pci_write_config_word(pdev, 0x7E, val | 4);
> +       udelay(10);
>         pci_write_config_word(pdev, 0x7E, val & ~4);
> +       udelay(42);
>  }

Where do you get the delays from ? There is nothing in the documentation
or errata sheets I have here on that subject. Is this guesswork, divine
inspiration or an errata note I don't posess ?

In the absence of documented behaviour its seem to me much more likely
that the delay is actually either moving a race condition in the libata
code, or perhaps just allowing some time for the CD to "recover" in which
case it's perhaps a bit of a delay we need in libata. That would explain
why the old -> new change broke stuff.

Either way its most interesting it makes a difference.

Alan
