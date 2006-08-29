From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: Some questions about new EH in libata
Date: Mon, 28 Aug 2006 18:51:46 -0600
Message-ID: <8202f4270608281751v7cddfdddo28ba1b86eb43e60f@mail.gmail.com>
References: <8202f4270608212154k787f63a1k15ed3dcfff0624c2@mail.gmail.com>
	 <44EA91A8.5090309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:39709 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750712AbWH2Avr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Aug 2006 20:51:47 -0400
Received: by py-out-1112.google.com with SMTP id n25so2654598pyg
        for <linux-ide@vger.kernel.org>; Mon, 28 Aug 2006 17:51:46 -0700 (PDT)
In-Reply-To: <44EA91A8.5090309@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On 8/21/06, Tejun Heo <htejun@gmail.com> wrote:
> Fajun Chen wrote:
> > Hi Folks,
> >
> > I just upgraded to the libata with new EH and I have some questions
> > about the new error handler:
> > 1. In several occasions, I saw a port being disable, under what kind
> > of conditions will new EH disable a port?
>
> After EH fails to recover a device.  It usually takes three recovery
> trial failures.
>
> > 2. For user space program, is there any way to checked the state of a
> > port/drive? I noticed that dmesg has some printout but that could be
> > wiped out by other traces or errors.
>
> Hmmm... Not yet.
>
> > 3. Does libata allow user space code to reset host/bus/drive or only
> > libata itself has the privilege? I tried sg reset IOCTL interface on
> > SATA Sil3124, it seems not working.
>
> No, that doesn't work but issuing userscan forces libata to reset the
> channel.
>
> > 4. How to reenable a port/drive after it's disabled without rebooting?
> > Any API or command from user space?
>
> You can use SCSI userscan interface.
>
Is this a scsi command? I looked at scsi spec and haven't found it
yet. I know how to initiate user scan from proc or sysfs, but there is
no way to know the result of user scan through proc or sysfs.  I'm
looking for a way to check when a pata drive is back online after a
power cycle. May I issue userscan periodically until its result
indicates pata drive is available?
