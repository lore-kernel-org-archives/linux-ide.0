From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_std_qc_defer not good enough for FIS-based switching ?
Date: Tue, 29 Apr 2008 10:18:13 +0900
Message-ID: <48167755.3000208@gmail.com>
References: <48163C5D.9050605@rtr.ca> <48164AE8.4070106@rtr.ca> <481659B5.7090703@gmail.com> <481660DD.80103@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:33312 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbYD2BSX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Apr 2008 21:18:23 -0400
Received: by wf-out-1314.google.com with SMTP id 28so4271960wff.4
        for <linux-ide@vger.kernel.org>; Mon, 28 Apr 2008 18:18:22 -0700 (PDT)
In-Reply-To: <481660DD.80103@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>

Mark Lord wrote:
> Mmm.. I just plugged the same PM + drives into my sata_sil24 card here,
> and that driver went bonkers when I did the same test.
> 
> Had to reboot eventually to recover.

Hmm... That can't be.  Above all, although we do manual scheduling 
around sil24, the controller does its own scheduling and will happily 
issue command in the right order even if the software scheduler screws 
up.  Do you have the log?

Thanks.

-- 
tejun
