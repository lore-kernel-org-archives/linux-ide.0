From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 11/12] libata: add ATA_CBL_PATA_IGN
Date: Tue, 06 Nov 2007 20:02:28 +0900
Message-ID: <473049C4.3090807@gmail.com>
References: <1194327550227-git-send-email-htejun@gmail.com>	<11943275512264-git-send-email-htejun@gmail.com> <20071106105947.6f633868@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:11255 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754942AbXKFLCj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 06:02:39 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2360850wah
        for <linux-ide@vger.kernel.org>; Tue, 06 Nov 2007 03:02:37 -0800 (PST)
In-Reply-To: <20071106105947.6f633868@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Alan Cox wrote:
>> This patch adds ATA_CBL_PATA_IGN which tells libata to ignore the
>> cable type completely and just let the LLD determine the transfer mode
>> via host transfer mode masks and ->mode_filter().
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> Acked-by: Alan Cox <alan@redhat.com>
> 

I think this can be applied to pata_acpi too as we don't have any idea
about actual cable there.

Thanks.

-- 
tejun
