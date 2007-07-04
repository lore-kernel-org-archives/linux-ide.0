From: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: [PATCH 2.6.22-rc7] libata: fix assigned IRQ reporting
Date: Wed, 4 Jul 2007 20:59:36 +0200
Message-ID: <20070704185936.GA13212@electric-eye.fr.zoreil.com>
References: <20070702163847.GV29122@htj.dyndns.org> <20070702214747.GA23182@electric-eye.fr.zoreil.com> <4689A432.6080104@gmail.com> <20070703222205.GA18532@electric-eye.fr.zoreil.com> <468B3126.3080706@gmail.com> <468B3452.6040509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:56407 "EHLO
	fr.zoreil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758631AbXGDTAd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Jul 2007 15:00:33 -0400
Content-Disposition: inline
In-Reply-To: <468B3452.6040509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo <htejun@gmail.com> :
> Tejun Heo wrote:
> > Francois Romieu wrote:
> >> I have rebuilt on top of 872aad45d6174570dd2e1defc3efee50f2cfcc72 and it
> >> still seems bizarre:
> 
> Okay, 872aad45 doesn't have the patch yet.  Either apply the patch
> manually or you need to wait a bit more.

I am confused. 4031826b3ca40982880f6b9f2282c7d7fad60d77 appears in the log:
Author: Tejun Heo <htejun@gmail.com>                                            
Date:   Tue Jul 3 01:38:47 2007 +0900                                           
                                                                                
    libata: fix assigned IRQ reporting                                          
                                                                                
    host->irq and host->irq2 should be set before ata_host_register() for       
    IRQ reporting to work.  Move up host->irq assignment in                     
    ata_host_activate() and add it to ata_pci_init_one() native path and        
    pata_cs5520.                                                                
                                                                                
    The port info printing in ata_host_register() doesn't fit all the           
    different controllers.  It should probably be moved out to LLDs with        
    some helpers in the future.                                                 
                                                                                
    Signed-off-by: Tejun Heo <htejun@gmail.com>                                 
    Signed-off-by: Jeff Garzik <jeff@garzik.org>                                

-> it is exactly the patch that you sent on 03/07/2007.

-- 
Ueimor
