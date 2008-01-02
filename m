From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 4/4] libata: implement ATAPI per-command-type DMA horkages
Date: Wed, 02 Jan 2008 22:49:29 +0900
Message-ID: <477B9669.1060602@gmail.com>
References: <11992723701811-git-send-email-htejun@gmail.com>	<1199272371169-git-send-email-htejun@gmail.com> <20080102133445.338b4296@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:8675 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbYABNtg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jan 2008 08:49:36 -0500
Received: by rv-out-0910.google.com with SMTP id k20so5278102rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 02 Jan 2008 05:49:34 -0800 (PST)
In-Reply-To: <20080102133445.338b4296@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Alan Cox wrote:
>> This patch implement ATAPI per-command-type DMA horkages and EH logic
>> to set those quickly.  This way, failures localized to certain command
>> type don't affect other operations (most importantly READs) and
>> working configuration is found quickly such that the device can be
>> used.
> 
> Seems sensible to treat them differently for different controllers. Have
> you considered re-issuing failing ATAPI DMA commands as PIO as an EH
> response ?

I think determining whether to retry or not belongs to upper layer.
Retrying random command can result in unexpected behavior.  For things
like device/media readiness testing, SCSI / cdrom layer will retry.  For
pass-through commands, I think it's better to leave it to the application.

Thanks.

-- 
tejun
