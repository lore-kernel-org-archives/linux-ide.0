From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] pata_sis: add missing UDMA5 timing value in sis_66_set_dmamode()
Date: Fri, 21 Sep 2007 19:38:43 +0900
Message-ID: <46F39F33.1030501@gmail.com>
References: <20070921072905.GC10660@htj.dyndns.org> <20070921114148.45c90b62@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:19059 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbXIUKiu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Sep 2007 06:38:50 -0400
Received: by nz-out-0506.google.com with SMTP id s18so644735nze
        for <linux-ide@vger.kernel.org>; Fri, 21 Sep 2007 03:38:50 -0700 (PDT)
In-Reply-To: <20070921114148.45c90b62@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, desaster.area@addcom.de, alan@redhat.com, bzolnier@gmail.com

Alan Cox wrote:
> On Fri, 21 Sep 2007 16:29:05 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> sis_66_set_dmamode() also handles early UDMA100 (SIS630 ET) but is
>> missing udma timing value for UDMA100.  According to sis5513, this
>> should be 0x8000.  This caused UDMA100 device to fail on pata_sis till
>> it downgrades to UDMA66 while it works fine on sis5513 at UDMA100.
>>
>> Reported by Adam Blech.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> Cc: Adam Blech <desaster.area@addcom.de>
> 
> Acked-by: Alan Cox <alan@redhat.com>
> 
> I was just looking at this as we had a Red Hat bug for it 8)
> 

I caught this one from a SUSE bug.  I guess distros are useful from time
to time.  :-)

-- 
tejun
