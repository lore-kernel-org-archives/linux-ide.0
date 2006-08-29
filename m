From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: Some questions about new EH in libata
Date: Tue, 29 Aug 2006 09:51:30 -0600
Message-ID: <8202f4270608290851u20ec2eb5j2fd7e509f617cf35@mail.gmail.com>
References: <8202f4270608212154k787f63a1k15ed3dcfff0624c2@mail.gmail.com>
	 <44EA91A8.5090309@gmail.com>
	 <8202f4270608281751v7cddfdddo28ba1b86eb43e60f@mail.gmail.com>
	 <44F3A384.4080505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:16029 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965035AbWH2Pvc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Aug 2006 11:51:32 -0400
Received: by py-out-1112.google.com with SMTP id n25so2935522pyg
        for <linux-ide@vger.kernel.org>; Tue, 29 Aug 2006 08:51:31 -0700 (PDT)
In-Reply-To: <44F3A384.4080505@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On 8/28/06, Tejun Heo <htejun@gmail.com> wrote:
> Fajun Chen wrote:
> >> You can use SCSI userscan interface.
> >>
> > Is this a scsi command? I looked at scsi spec and haven't found it
> > yet. I know how to initiate user scan from proc or sysfs,
>
> Yeap, that's what I meant.
>
> > but there is
> > no way to know the result of user scan through proc or sysfs.  I'm
> > looking for a way to check when a pata drive is back online after a
> > power cycle. May I issue userscan periodically until its result
> > indicates pata drive is available?
>
> Hmmm.. When new devices are attached, hotplug events are generated.  I
> think that's the only way to get any result back, so when it fails,
> there's no indication.  Periodically repeating userscan request should
> be fine although it may result in an extra reset after successfully
> detecting the device.  That shouldn't hurt too much.
>

I assume that alt status register will be updated when pata/sata is
back online. So as an alternative and less invasive way, could I check
alt status register and start user scan only if device is ready on alt
status register? libata has ata_altstatus() function, is it available
to user space? If not, may I expose it? I'm looking for a way to check
device registers without side effects.

Thanks,
Fajun
