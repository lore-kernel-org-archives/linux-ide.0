From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: PATCH: Put the new API functions in the header files
Date: Fri, 5 Nov 2004 23:02:50 +0100
Message-ID: <200411052302.50280.bzolnier@elka.pw.edu.pl>
References: <1099672368.5630.47.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:43725 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261224AbUKEV7r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 16:59:47 -0500
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:40600 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S99547AbUKEV7q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Nov 2004 22:59:46 +0100
Received: from chello062179088136.chello.pl ([62.179.88.136]:63373 "EHLO
	[192.168.123.164]" ident: "NO-IDENT-SERVICE[2]" smtp-auth: "bzolnier"
	TLS-CIPHER: <none> TLS-PEER-CN1: <none>) by mion.elka.pw.edu.pl
	with ESMTP id S55947AbUKEV6R (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Fri, 5 Nov 2004 22:58:17 +0100
In-Reply-To: <1099672368.5630.47.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org


* there is no ordering of your patches
* they are splitted on file boundary not change boundary
  (ie. appling one patch leaves you with kernel which won't compile)
* they are whitespace damaged as usual

:/

On Friday 05 November 2004 17:32, Alan Cox wrote:
> diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.10rc1/include/linux/ide.h linux-2.6.10rc1/include/linux/ide.h
> --- linux.vanilla-2.6.10rc1/include/linux/ide.h	2004-11-05 15:42:18.000000000 +0000
> +++ linux-2.6.10rc1/include/linux/ide.h	2004-11-05 16:26:18.000000000 +0000
> @@ -266,6 +266,7 @@
>   * Register new hardware with ide
>   */
>  int ide_register_hw(hw_regs_t *hw, struct hwif_s **hwifp);
> +int ide_register_hw_with_fixup(hw_regs_t *hw, struct hwif_s **hwifp, void (*fixup)(struct hwif_s *));
>  
>  /*
>   * Set up hw_regs_t structure before calling ide_register_hw (optional)
> @@ -1470,6 +1475,7 @@
>  	void			(*init_iops)(ide_hwif_t *);
>  	void                    (*init_hwif)(ide_hwif_t *);
>  	void			(*init_dma)(ide_hwif_t *, unsigned long);
> +	void			(*fixup)(ide_hwif_t *);
>  	u8			channels;
>  	u8			autodma;
>  	ide_pci_enablebit_t	enablebits[2];
> @@ -1529,6 +1535,8 @@
>  extern void ide_unregister (unsigned int index);
>  
>  extern int probe_hwif_init(ide_hwif_t *);
> +extern int probe_hwif_init_with_fixup(ide_hwif_t *hwif, void (*fixup)(ide_hwif_t *hwif));
> +extern void ide_undecoded_slave(ide_hwif_t *hwif);
>  
>  static inline void *ide_get_hwifdata (ide_hwif_t * hwif)
>  {
> 
> 
