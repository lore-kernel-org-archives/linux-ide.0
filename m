From: Michael Ihrcke <mihrcke@gmail.com>
Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Sat, 8 Oct 2011 13:25:06 -0500
Message-ID: <CAKGin7UjCxF23FnHLcUtbTJJBqGpm2r0e8HZTC7YwG_oDzAGjw@mail.gmail.com>
References: <359604ECF8F440408B9634E6146249B4321C2569@mail.scl.local>
	<20110713133425.GP2872@htj.dyndns.org>
	<20110713143936.GQ2872@htj.dyndns.org>
	<359604ECF8F440408B9634E6146249B4321C2695@mail.scl.local>
	<20110714071459.GB3455@htj.dyndns.org>
	<359604ECF8F440408B9634E6146249B4322F1E0A@mail.scl.local>
	<20110721090022.GF3455@htj.dyndns.org>
	<359604ECF8F440408B9634E6146249B4322F2566@mail.scl.local>
	<20110722095037.GJ2622@htj.dyndns.org>
	<359604ECF8F440408B9634E6146249B4322F26B6@mail.scl.local>
	<20110730125456.GN2622@htj.dyndns.org>
	<loom.20110930T233659-338@post.gmane.org>
	<CAMHSBOWbaLjbWZ7PNwTa-AsZRAzrOGLgSip=q2=u+qVQW4u3mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61906 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab1JHSZI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Oct 2011 14:25:08 -0400
Received: by wwf22 with SMTP id 22so7367832wwf.1
        for <linux-ide@vger.kernel.org>; Sat, 08 Oct 2011 11:25:07 -0700 (PDT)
In-Reply-To: <CAMHSBOWbaLjbWZ7PNwTa-AsZRAzrOGLgSip=q2=u+qVQW4u3mQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: linux-ide@vger.kernel.org

Thank you...

Will this require a complete kernel recompile?
Or is there an easier way to include this patch?

I have little to no experience with working with patches at this level.
I've been doing research on how to use this patch, and I'm close, but, =
I'm not
sure if I need to attack compiling a kernel, or if I can somehow just p=
atch
libata or something like that?

Thank you,
Mike

On Thu, Oct 6, 2011 at 12:48 AM, Gwendal Grignou <gwendal@google.com> w=
rote:
>
> I think I know what is going on. One of your disks at least is slow t=
o
> spinup. Due to a bug/feature in silicon image disk controller and pmp=
,
> at bring up we can not issue a SOFT_RESET and wait for the disk to
> spinup and then continue.
> That why we set ATA_LFLAG_NO_SRST in=A0sata_pmp_quirks().
> So what happen is we go into a function that issue identify, but we
> fail, the disk is not ready [it is spinning up], so we retry.
> 3 times.
>
> From the first hard reset:=A012888.470385, to the time you got the fi=
nal
> error:=A012901.397305 ~ 12.9s
> In the second case, your controller can send SOFT_RESET and wait for
> the device to respond.
> Time for the disk to spinup:
> 28010.630028 -=A027997.097116 ~ 13.5s
> As you can see, you are borderline with the PMP, but the controller
> did not "wait" enough in the first case.
> Given the spinup time varies with drive, age, time since last
> spin-up..., it may work one day and fail the next.
> To work around the problem, I have a patch that consist of allowing
> the silicon image control to send a reset, but if it fails, we spin
> for a fixed amount of time and retry. This is not very nice, it is a
> better design to wait for event that waiting a fixed amount of time.
> You may have to alter=A0ATA_LFLAG_WAIT_SRST to use the first bit avai=
lable.
>
> Can you try with the following patch?
>
> Thanks,
> Gwendal.
>
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 228740f..b98b02d 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2798,7 +2798,14 @@ int ata_eh_reset(struct ata_link *link, int cl=
assify,
> =A0 =A0 =A0sata_scr_read(link, SCR_STATUS, &sstatus))
> =A0 rc =3D -ERESTART;
>
> - if (rc =3D=3D -ERESTART || try >=3D max_tries)
> + if (try >=3D max_tries)
> + goto out;
> +
> + /* Some PMP will not serve SRST until the disk is spunup,
> + * if the controller can not wait for the PMP to acknowledge the fra=
me,
> + * wait here */
> + if (rc =3D=3D -ERESTART &&
> + =A0 =A0!((lflags & ATA_LFLAG_WAIT_SRST) && (reset =3D=3D softreset)=
))
> =A0 goto out;
>
> =A0 now =3D jiffies;
> @@ -2813,6 +2820,8 @@ int ata_eh_reset(struct ata_link *link, int cla=
ssify,
> =A0 delta =3D schedule_timeout_uninterruptible(delta);
> =A0 }
>
> + if (rc =3D=3D -ERESTART)
> + goto out;
> =A0 if (try =3D=3D max_tries - 1) {
> =A0 sata_down_spd_limit(link, 0);
> =A0 if (slave)
> diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
> index 00305f4..d21ad7d 100644
> --- a/drivers/ata/libata-pmp.c
> +++ b/drivers/ata/libata-pmp.c
> @@ -325,13 +351,11 @@ static void sata_pmp_quirks(struct ata_port *ap=
)
> =A0 if (vendor =3D=3D 0x1095 && devid =3D=3D 0x3726) {
> =A0 /* sil3726 quirks */
> =A0 ata_for_each_link(link, ap, EDGE) {
> - /* Class code report is unreliable and SRST
> - * times out under certain configurations.
> - */
> + /* Class code report is unreliable */
> + /* PMP does not forward SRST until the drive spins up */
> =A0 if (link->pmp < 5)
> - link->flags |=3D ATA_LFLAG_NO_SRST |
> - =A0 =A0 =A0 ATA_LFLAG_ASSUME_ATA;
> -
> + link->flags |=3D ATA_LFLAG_ASSUME_ATA |
> + =A0 =A0 =A0 ATA_LFLAG_WAIT_SRST;
> =A0 /* port 5 is for SEMB device and it doesn't like SRST */
> =A0 if (link->pmp =3D=3D 5)
> =A0 link->flags |=3D ATA_LFLAG_NO_SRST |
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index b2f2003..3a18caa 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -172,6 +172,7 @@ enum {
> =A0 ATA_LFLAG_NO_RETRY =3D (1 << 5), /* don't retry this link */
> =A0 ATA_LFLAG_DISABLED =3D (1 << 6), /* link is disabled */
> =A0 ATA_LFLAG_SW_ACTIVITY =3D (1 << 7), /* keep activity stats */
> + ATA_LFLAG_WAIT_SRST =3D (1 << 8), /* add delay when SRST fails */
>
> =A0 /* struct ata_port flags */
> =A0 ATA_FLAG_SLAVE_POSS =3D (1 << 0), /* host supports slave dev */
>
>
