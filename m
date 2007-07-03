From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.22-rc7] libata: fix assigned IRQ reporting
Date: Tue, 03 Jul 2007 10:19:46 +0900
Message-ID: <4689A432.6080104@gmail.com>
References: <20070702163847.GV29122@htj.dyndns.org> <20070702214747.GA23182@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:34305 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756571AbXGCBVI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 21:21:08 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2562200wah
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 18:21:06 -0700 (PDT)
In-Reply-To: <20070702214747.GA23182@electric-eye.fr.zoreil.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Francois Romieu wrote:
> Tejun Heo <htejun@gmail.com> :
>> host->irq and host->irq2 should be set before ata_host_register() for
>> IRQ reporting to work.  Move up host->irq assignment in
>> ata_host_activate() and add it to ata_pci_init_one() native path and
>> pata_cs5520.
>>
>> The port info printing in ata_host_register() doesn't fit all the
>> different controllers.  It should probably be moved out to LLDs with
>> some helpers in the future.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> Is it supposed to change the behavior below ?

Yeah, didn't it?

-- 
tejun
