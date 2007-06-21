From: Tejun Heo <htejun@gmail.com>
Subject: Re: Hard lockup with ata_piix 2.6.21.1: strange traceback, too
Date: Thu, 21 Jun 2007 13:29:12 +0900
Message-ID: <4679FE98.4040602@gmail.com>
References: <4679982D.2030000@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:36162 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbXFUE3R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jun 2007 00:29:17 -0400
Received: by wa-out-1112.google.com with SMTP id v27so173217wah
        for <linux-ide@vger.kernel.org>; Wed, 20 Jun 2007 21:29:17 -0700 (PDT)
In-Reply-To: <4679982D.2030000@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Hi guys,
> 
> I'm debugging a system here based on ICH7/ata_piix.
> When we hot-pull a drive, it locks up solid.
> That's fine, but I'd like to find/fix the lockup.
> 
> So as part of poking around, I rebuilt the kernel with frame pointers,
> and inserted a WARN_ON(1) into ata_busy_sleep() to see who was calling it
> just before things locked up.
> Here's the result:  http://rtr.ca/libata.png
> 
> Can anyone here make sense of that traceback??
> Are we *really* recursing inside the EH code?

It looks like SCSI EH -> piix_sata_error_handler -> ata_eh_recover ->
ata_std_softreset -> ata_std_prereset -> ata_busy_sleep with lots of
bogus entries inbetween.

-- 
tejun
