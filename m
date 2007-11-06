From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 04/12] libata: kill ata_id_to_dma_mode()
Date: Tue, 06 Nov 2007 20:21:45 +0900
Message-ID: <47304E49.5020902@gmail.com>
References: <1194327550227-git-send-email-htejun@gmail.com>	<11943275502226-git-send-email-htejun@gmail.com> <20071106104959.726d51d5@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.232]:57898 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754984AbXKFLVz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 06:21:55 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1317415nze
        for <linux-ide@vger.kernel.org>; Tue, 06 Nov 2007 03:21:54 -0800 (PST)
In-Reply-To: <20071106104959.726d51d5@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Tue,  6 Nov 2007 14:39:02 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> ata_id_to_dma_mode() isn't quite generic.  The function is basically
>> privately implemented ata_id_xfermask() combined with hardcoded mode
>> printing and configuration which are specific to ata_generic.
> 
> I anticpiated other users. This seems a backward move - we end up
> exporting lots of low level detail into the drivers which should be none
> of their business.

Those functions need to be exported anyway for pata_amd and I think it's
natural to export them as xfer mode and mask handling is pretty
fundamental and having those helpers around is handy when implementing
LLD-specific mode selection.

ata_id_to_dma_mode() just seemed a bit too specific to me.  Sans
ata_id_xfermask() part, printing configured mode and using "DMA" when
there's no applicable DMA mode don't seem too useful as generic xfer
mode/mask helper.  I agree that the latter part of the function can be
factored tho (setting xfer_mode, shift and clearing PIO flag according
to determined xfer_mask).  But since ata_generic() is currently the only
user, factoring that part out seems an overkill.

Well, I guess this is a matter of taste after all.  How about letting
Jeff determine it?  I'm okay as long as generic ata_id_xfermask() is
used there.

Thanks.

-- 
tejun
