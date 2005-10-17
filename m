From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] libata: fix broken Kconfig setup
Date: Mon, 17 Oct 2005 13:10:05 +0200
Message-ID: <pan.2005.10.17.11.10.03.734742@smurf.noris.de>
References: <20051017044606.GA1266@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932268AbVJQLPW@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi, Jeff Garzik wrote:

>  config SCSI_SATA
> -	tristate "Serial ATA (SATA) support"
> +	bool "Serial ATA (SATA) support"
>	depends on SCSI

In other words, if SCSI is false then SCSI_SATA is false too.

So why are you doing

> +if SCSI_SATA
> +
>  config SCSI_SATA_AHCI
>  	tristate "AHCI SATA support"
> -	depends on SCSI_SATA && PCI
> +	depends on SCSI && PCI

and not just
  +     depends on PCI

?

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
If you go out of your mind, do it quietly, so as not to disturb those
around you.
