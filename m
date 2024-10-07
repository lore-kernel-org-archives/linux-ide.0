Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6F01DB342;
	Mon,  7 Oct 2024 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318575; cv=none; b=G/D6YrcpD96UeFw5sL0ozNKXX1UI5JbV7JDYVHLOuRIQmjMjGdE9Few8drySB/Frnj9TPE/U/j2RnegjIPVoG5OfNepFJbSHsiy81OW9QzmAxVKYMGUqeCE5lxjIs7AhBp6SAv1AKwJEB1g3QcKsFOWl4rxKwiqmRiqlnItxqh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318575; c=relaxed/simple;
	bh=Hixdo/eIE/G41uhAs+nrzfVCP0R4a/h4UYdiGgdgJKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9MdBqTwzy459Bqz516ZMxkLbejyz+zwh4Z250AofZasnfIcDZ4bNCF/R7DpUv8cpUpaUZZJ1u/UP/sDDFCDMVvffHh05BYqasS9xKFqm1IP2tFGA34AwjxsXi9R3EcLqRk/u+AaDtKTtfixP2sn2oyJvdcUgTEPh12xIlccdG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnfWCSJ+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnfWCSJ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32713C4CEC6;
	Mon,  7 Oct 2024 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728318575;
	bh=Hixdo/eIE/G41uhAs+nrzfVCP0R4a/h4UYdiGgdgJKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fnfWCSJ+i/Bf93IZdUcXYmQHNWOk0zjZbCq0PPTRlvQjFXh1QL+qPWF1r9jFq4hpv
	 C+W43dJktA6nTvymzlqW4HW1NVYlTobYD5VoqYN8heTFtA7+iRe8KDNq6JgyxNDRJG
	 62Tsa0KYC4c05z7alGJjrlQ36uwCigKb9Gxl5Fs1P9+s27Fy/Ap7QRyzn1KYrRdacd
	 5SR9Yf5lBnQQO/r701JCcuAe9oML+Sv0AW6Ikqs+SynyHv+9cX6wyxn3qAKDr84nwJ
	 yyB6j7cD1PZR83VHFgz6mRJmgnC3wdABUiizKx2NeBzMocxhBhiIm6zHPY4RjOZmE3
	 HMOTC+66pF4LQ==
Date: Mon, 7 Oct 2024 18:29:31 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: W <linuxcdeveloper@gmail.com>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-ide@vger.kernel.org
Subject: Re: libahci driver and power switching HDD on newer kernels
Message-ID: <ZwQMa4_jQokKU2mz@ryzen.lan>
References: <7882faa8-d5ec-4868-b158-0b942b669cc0@gmail.com>
 <c4f1c690-6e97-44de-985f-dc9eadd18d23@leemhuis.info>
 <c7880a6f-04d4-4572-9255-1575f6668b4e@kernel.org>
 <a0c34406-3bb3-4880-9513-0876aacd4de6@gmail.com>
 <Zv25MQWh-1yYAcVC@ryzen.lan>
 <07f85f4a-71c7-465b-b38c-127a02721423@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07f85f4a-71c7-465b-b38c-127a02721423@kernel.org>

On Thu, Oct 03, 2024 at 07:47:41AM +0900, Damien Le Moal wrote:
> On 10/3/24 06:20, Niklas Cassel wrote:
> > On Tue, Sep 24, 2024 at 12:42:10PM +0200, W wrote:
> >>>
> >>> Given that you had 6.4.12 working OK, it is likely some commit that introduced a
> >>> regression. If you can git bisect it, we will have a better idea how to remove
> >>> the regression.
> >>
> >> Please take a look at bugzilla report:
> >> https://bugzilla.kernel.org/show_bug.cgi?id=219296 - there are the details.
> >>
> >> I'm wondering what is the better way for communication - here on mailing
> >> list or put the comments in bugzilla ticket?
> >> Probably here will be better idea...
> >>
> >> W
> >>
> > 
> > Hello W,
> > 
> > Could you please try the following patch,
> > and see if it helps:
> > 
> > 
> > From dba01b7d68fffc26f3abf3252296082311a767a0 Mon Sep 17 00:00:00 2001
> > From: Niklas Cassel <cassel@kernel.org>
> > Date: Wed, 2 Oct 2024 21:40:41 +0200
> > Subject: [PATCH] ata: libata: do not spin down disk on PM event freeze
> > 
> > Currently, ata_eh_handle_port_suspend() will return early if
> > ATA_PFLAG_PM_PENDING is not set, or if the PM event has flag
> > PM_EVENT_RESUME set.
> > 
> > This means that the following PM callbacks:
> > .suspend = ata_port_pm_suspend,
> > .freeze = ata_port_pm_freeze,
> > .poweroff = ata_port_pm_poweroff,
> > .runtime_suspend = ata_port_runtime_suspend,
> > will actually make ata_eh_handle_port_suspend() perform some work.
> > 
> > ata_eh_handle_port_suspend() will spin down the disks (by calling
> > ata_dev_power_set_standby()), regardless of the PM event.
> > 
> > Documentation/driver-api/pm/devices.rst, section "Entering Hibernation",
> > explicitly mentions that .freeze() does not have to be put the device in
> > a low-power state, and actually recommends not doing so. Thus, let's not
> > spin down the disk for the .freeze() callback. (The disk will instead be
> > spun down during the succeeding .poweroff() callback.)
> > 
> > Fixes: aa3998dbeb3a ("ata: libata-scsi: Disable scsi device manage_system_start_stop")
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/ata/libata-eh.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> > index 3f0144e7dc80..45a0d9af2d54 100644
> > --- a/drivers/ata/libata-eh.c
> > +++ b/drivers/ata/libata-eh.c
> > @@ -4099,10 +4099,20 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
> >  
> >         WARN_ON(ap->pflags & ATA_PFLAG_SUSPENDED);
> >  
> > -       /* Set all devices attached to the port in standby mode */
> > -       ata_for_each_link(link, ap, HOST_FIRST) {
> > -               ata_for_each_dev(dev, link, ENABLED)
> > -                       ata_dev_power_set_standby(dev);
> > +       /*
> > +        * We will reach this point for all of the PM events:
> > +        * PM_EVENT_SUSPEND (if runtime pm, PM_EVENT_AUTO will also be set)
> > +        * PM_EVENT_FREEZE, and PM_EVENT_HIBERNATE.
> > +        *
> > +        * We do not want to perform disk spin down for PM_EVENT_FREEZE.
> > +        * (Spin down will be performed by the succeeding PM_EVENT_HIBERNATE.)
> > +        */
> > +       if (!(ap->pm_mesg.event & PM_EVENT_FREEZE)) {
> 
> This feels odd: not doing anything to the drive for PM_EVENT_FREEZE will still
> endup freezing the port, which will later cause a reset. And we still endup
> calling the port suspend op and ata_acpi_set_state(), which seems to be doing
> nothing for freeze...

Hello Damien,

Hibernation is done by three consecutive PM events, in the following order:
1) PM_EVENT_FREEZE
2) PM_EVENT_THAW
3) PM_EVENT_HIBERNATE

Hibernate before commit aa3998dbeb3a ("ata: libata-scsi: Disable scsi
device manage_system_start_stop"):
-On event PM_EVENT_FREEZE:
 ata_eh_handle_port_suspend() would call ata_eh_freeze_port() and then
 call ap->ops->port_suspend().
-On event PM_EVENT_THAW:
 ata_port_resume() would trigger EH with ATA_EH_RESET, which triggers a
 all to ata_eh_reset(), which will thaw the port, and then later
 ata_eh_handle_port_resume() would call ap->ops->port_resume().
-On event PM_EVENT_HIBERNATE:
 same as PM_EVENT_FREEZE.

After commit aa3998dbeb3a ("ata: libata-scsi: Disable scsi device
manage_system_start_stop"), on event PM_EVENT_FREEZE, and on event
PM_EVENT_HIBERNATE, ata_eh_handle_port_suspend() would call
ata_eh_freeze_port() and then call ap->ops->port_suspend(),
but it would also call ata_dev_power_set_standby() to spin down the disk.

So what my propsed patch does is simply to restore
ata_eh_handle_port_suspend() to the behavior before commit aa3998dbeb3a
for event PM_EVENT_FREEZE, but for event PM_EVENT_HIBERNATE,
ata_eh_handle_port_suspend() will continue to spin down the disk.


> 
> So I wonder if a simpler approach would not be to simply remove the
> ata_port_pm_freeze() method entirely and do nothing for freeze events ?

I do not think that is a good option, as:
https://docs.kernel.org/driver-api/pm/devices.html#entering-hibernation
clearly states that:
"The ->freeze methods should quiesce the device so that it doesn’t
generate IRQs or DMA."

That is what we do when calling ata_eh_freeze_port().

I think my propsed patch is the simplest thing that we can do to
restore the behavior of ata_eh_handle_port_suspend() for event
PM_EVENT_FREEZE, as it was before commit aa3998dbeb3a.

Thus, I will send out this proposed patch as a real patch shortly.


Kind regards,
Niklas
