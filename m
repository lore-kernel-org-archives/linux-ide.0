From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA port multipliers and max_channel
Date: Sat, 13 Aug 2016 08:50:17 -0400
Message-ID: <20160813125017.GR2695@mtj.duckdns.org>
References: <CALjAwximVtXe8BYBpqOXST9UkR79vCdrNd2PMAQYnYaXYPx_Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:32804 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbcHMMuV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Aug 2016 08:50:21 -0400
Received: by mail-yw0-f195.google.com with SMTP id z8so541641ywa.0
        for <linux-ide@vger.kernel.org>; Sat, 13 Aug 2016 05:50:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALjAwximVtXe8BYBpqOXST9UkR79vCdrNd2PMAQYnYaXYPx_Xg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sitsofe Wheeler <sitsofe@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello, Sitsofe.

On Sat, Aug 13, 2016 at 09:56:17AM +0100, Sitsofe Wheeler wrote:
> I was browsing through the kernel while looking at
> https://github.com/systemd/systemd/issues/3943#issuecomment-239608897
> and I noticed that in libata-scsi.c shost->max_channel is set to 1.

That number traces back to the original implementation when there was
neither PMP support or the sysfs knobs.  I don't know why it was set
to 1 as 0 seems like the right number.  Probably a mistake thinking
that the number means the number of channels.

> Further, if a SATA port multiplier is being used aren't channels used
> to represent the port multiplier ports
> (http://lxr.free-electrons.com/source/drivers/ata/libata-scsi.c?v=4.6#L3726
> )? If so does max_channel need to be increased to one less than
> SATA_PMP_MAX_PORTS? If so, would this explain the results seen in

Yeah, that sounds right.  I don't have a working PM anymore and can't
test it.  It'd be great if you can spin up the patch and test it if
you have one available.

> https://www.usenix.org/system/files/fastpw13-paper7_0.pdf ?

libata EH works mostly independent from SCSI layer and the channel
thing could affect is only the sysfs representation part.  As for the
paper, a lot of port multipliers just show shitty error handling
behavior.  Back in the day, I tested quite a few of early hardware
while developing for it and it was just a nightmare.  PMs didn't
really catch on and the PMs didn't have the chance to mature properly.

Thanks.

-- 
tejun
