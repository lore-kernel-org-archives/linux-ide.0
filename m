From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: Some questions about new EH in libata
Date: Tue, 22 Aug 2006 09:40:47 -0600
Message-ID: <8202f4270608220840j6bdb4ae4u2c31803b4244e521@mail.gmail.com>
References: <8202f4270608212154k787f63a1k15ed3dcfff0624c2@mail.gmail.com>
	 <44EA91A8.5090309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.194]:49079 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750739AbWHVPks (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Aug 2006 11:40:48 -0400
Received: by nz-out-0102.google.com with SMTP id 14so523316nzn
        for <linux-ide@vger.kernel.org>; Tue, 22 Aug 2006 08:40:47 -0700 (PDT)
In-Reply-To: <44EA91A8.5090309@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Hi Tejun,

Could you please elaborate all the conditions triggering the error
handling? I know that command failure or HBA error can trigger EH, but
does EH schedule any routine error checking autonomously? The
particular scenario I am looking at is if a drive is moved away from
interface mode (through back door noninterface command) for some time
then move back, will EH detect and declare it as an interface error?

Thanks,
Fajun

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
> Regards.
>
> --
> tejun
>
