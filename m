From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_hpt3x2n: Cable detect handling
Date: Wed, 7 Mar 2007 17:02:18 +0000
Message-ID: <20070307170218.7c0960b4@lxorguk.ukuu.org.uk>
References: <20070307161723.49b4b4aa@lxorguk.ukuu.org.uk>
	<45EED7FE.9020305@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36933 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932263AbXCGP6N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 10:58:13 -0500
In-Reply-To: <45EED7FE.9020305@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

xn_pre_reset(struct ata_port *ap)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
> >  	/* Reset the state machine */
> >  	pci_write_config_byte(pdev, 0x50, 0x37);
> >  	pci_write_config_byte(pdev, 0x54, 0x37);
> >  	udelay(100);
> > -
> >  	return ata_std_prereset(ap);
> >  }
> >  
> 
>     Hmmm... is it really safe to reset both channels here, when only one port 
> gets reset?

It works but you have a good point, that ought to be changed.

Alan
