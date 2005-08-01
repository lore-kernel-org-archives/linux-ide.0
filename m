From: Daniel Drake <dsd@gentoo.org>
Subject: Re: Driver for sata adapter promise sata300 tx4
Date: Mon, 01 Aug 2005 15:43:13 +0100
Message-ID: <42EE3501.7010107@gentoo.org>
References: <42EDE918.9040807@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.103.221.47] ([81.103.221.47]:549 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S262219AbVHAOl7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Aug 2005 10:41:59 -0400
In-Reply-To: <42EDE918.9040807@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Otto Meier <gf435@gmx.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Otto Meier wrote:
> This card use the sata chip pdc 40718 (as of my card)
> the lastest sata_promise kernel with sata promise patch driver doesn't 
> recognise
> this card.
> 
> I added the following line to static struct pci_device_id 
> pdc_ata_pci_tbl[]  in sata_promise.c:
> 
>        { PCI_VENDOR_ID_PROMISE, 0x3d17, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>          board_20319 },
> 
> and the card was recognised and seam to work without errors so far.

Yes, this should be fine (this is a 4-port SATA card right?)

Are you happy to produce and submit a patch yourself (read 
Documentation/SubmittingPatches) or should I submit one for you?

Thanks,
Daniel
