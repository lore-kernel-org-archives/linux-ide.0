From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/6] sata_sil: new interrupt handler
Date: Fri, 12 May 2006 01:16:51 +0900
Message-ID: <44636373.2040902@gmail.com>
References: <11473604982155-git-send-email-htejun@gmail.com> <1147362044.26130.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:53627 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030313AbWEKQQ6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:16:58 -0400
Received: by wr-out-0506.google.com with SMTP id i12so402548wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:16:57 -0700 (PDT)
In-Reply-To: <1147362044.26130.39.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2006-05-12 at 00:14 +0900, Tejun Heo wrote:
>> The DMA complete bit of these controllers reflects ATA IRQ status
>> while no DMA command is in progress.  So, we can tell whether the
>> controller is raising an interrupt or not in deterministic manner.
>> This patch gives sata_sil its own interrupt handler which behaves much
>> better than the original one in terms of error detection and handling.
>> This change is also necessary for later hotplug support.
>>
> 
> Is it not possible to avoid duplicating so much code. If the
> sil_host_intr and a few other _intr routines end up with their own
> host_intr functions closely based on the core one and intimate state
> machine knowledge then fixes are going to get missed in one or the other
> over time 
> 

Yes, it's a bit worrying.  The current sata_sil irq handler is a little
bit too different to factor codes with the stock handler while a bit too
similar to justify the copying.  I think it's okay to leave it as it is
for the time being.  sata_sil will probably deviate more from the stock
handler as more BMDMA2 stuff gets implemented and controllers which
resemble the traditional BMDMA interface more than sata_sil should be
able to use ata_host_intr() with some wrapping.

-- 
tejun
