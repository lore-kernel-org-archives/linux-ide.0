From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6 fix queue] aec62xx: rework init_setup_aec6x80()
Date: Tue, 15 May 2007 23:31:38 +0200
Message-ID: <200705152331.38504.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702162321.40813.sshtylyov@ru.mvista.com> <200705112331.46859.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:35755 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760393AbXEPAq1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2007 20:46:27 -0400
Received: by ug-out-1314.google.com with SMTP id 44so2836uga
        for <linux-ide@vger.kernel.org>; Tue, 15 May 2007 17:46:27 -0700 (PDT)
In-Reply-To: <200705112331.46859.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Friday 11 May 2007, Sergei Shtylyov wrote:
> Rework init_setup_aec6x80() so that it won't rewrite the constant name strings
> anymore -- in order to do this:
> 
> - in aec62xx_init_one(), pass a local copy of 'struct pci_device_id' down the
>   call chain;
> 
> - change the names for in aec62xx_chipsets[] to default to AEC-6280[R];
> 
> - override the 'name' field in init_setup_aec6x80() only if bit 4 of the DMA
>   status register is set.
> 
> While at it, also change the 'udma_mask' field for AEC-6x80R chips in this
> function and remove the code doing the same from the init_hwif() method...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
