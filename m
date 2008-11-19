From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Withdraw IGN_SERR_INTERNAL for SB800 SATA
Date: Wed, 19 Nov 2008 11:48:51 +0900
Message-ID: <49237E93.2060303@gmail.com>
References: <1227000451.5631.7.camel@chunhao-desktop> <4922E8C4.1000006@gmail.com> <C8E4BD7D001E44499280E0884BD9DB300EA1A9@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:56489 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbYKSCtO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Nov 2008 21:49:14 -0500
Received: by ti-out-0910.google.com with SMTP id b6so2049116tic.23
        for <linux-ide@vger.kernel.org>; Tue, 18 Nov 2008 18:49:12 -0800 (PST)
In-Reply-To: <C8E4BD7D001E44499280E0884BD9DB300EA1A9@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Huang, Shane wrote:
> Hi Tejun,
>  
> 
>> -----Original Message-----
>> From: Tejun Heo [mailto:htejun@gmail.com] 
>>>  
>>> +	/* SB800 does NOT need the workaround to ignore SERR_INTERNAL */
>>> +	if (board_id == board_ahci_sb700 && pdev->revision >= 0x40)
>>> +		hpriv->flags &= ~AHCI_HFLAG_IGN_SERR_INTERNAL;
>>> +
>>>  	if ((hpriv->flags & AHCI_HFLAG_NO_MSI) || pci_enable_msi(pdev))
>>>  		pci_intx(pdev, 1);
>> Great, but please use separate board_ahci_* entry.  ie.
>> board_ahci_sb700_ign_serr for the ones with the problem and
>> board_ahci_sb700 for other sb700s and sb800s.
> 
> Thanks for your suggestion.
> 
> Different SATA controller revisions with/without the problem have SAME
> PCI device ID,
> so it's difficult to distinguish them with board_ahci_sb700_ign_serr and
> board_ahci_sb700 at the beginning.
> 
> Although we can distinguish them in ahci_init_one() and reevaluate
> board_id
> as well as ent->driver_data, I still suggest we keep my submitted patch
> because it seems to be neater. :-)
> 
> And I also added some comments for better maintainance like
> /* board_ahci_sb700, for SB700 and SB800 */
> /* SB800 does NOT need the workaround to ignore SERR_INTERNAL */
> It should be much clear to us now...

Ah.. right, can't match revision.  Yeap, then,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
