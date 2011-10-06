From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Allow SOFT_RESET for Sil3726
Date: Thu, 6 Oct 2011 15:10:26 -0700
Message-ID: <20111006221026.GA7085@google.com>
References: <CAMHSBOWbaLjbWZ7PNwTa-AsZRAzrOGLgSip=q2=u+qVQW4u3mQ@mail.gmail.com>
 <1317881037-11831-1-git-send-email-gwendal@google.com>
 <20111006080314.GB373@dhcp-172-17-108-109.mtv.corp.google.com>
 <CAMHSBOXhmhaRQgA104U+yajDLwyjVAeMqYUvUZFvZNroL0urug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47226 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935612Ab1JFWKa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2011 18:10:30 -0400
Received: by ywb5 with SMTP id 5so3067558ywb.19
        for <linux-ide@vger.kernel.org>; Thu, 06 Oct 2011 15:10:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMHSBOXhmhaRQgA104U+yajDLwyjVAeMqYUvUZFvZNroL0urug@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: mihrcke@gmail.com, linux-ide@vger.kernel.org, derry@high-rely.com

Hello,

On Thu, Oct 06, 2011 at 01:44:27PM -0700, Gwendal Grignou wrote:
> Yes. Until the device sends the async D2H Reg FIS indicating the driv=
e
> spun up, the MPM does not accept the SoftRest FIS from the controller=
=2E
> On most controller, that fine, the controller state machine keeps
> retrying, but on Sil3132 it stops after a second or so and send an
> error back to the driver.

I see.

> > So, now libata waits for full reset period before proceeding to res=
et
> > PMP. =A0Hmmm... yeah, it makes sense. =A0Unfortunately, the only wa=
y to
> > achieve spinup wait in this case is waiting blindly and libata's re=
set
> > timeouts are configured to accomodate drive spinup times. =A0PMP SC=
R
> > failure kinda destroys those blind wait periods.
>
> Yes, I totally agree this blind wait is not clean. Normally we would
> wait until an event occurs [async FIS] and have the timeout just for
> the error case.
> Here we wait [10s] because we think the device is spinning up.

Yes but that's exactly how the reset timeouts are set up.  They're
supposed to provide reasonable spinup timeouts when the proper wait
mechanisms can't do so and here it becomes a problem because the blind
timeouts are circumvented by SCR read failure handling.

> > I'm not too sure about ATA_LFLAG_WAIT_SRST. =A0I don't think making=
 the
> > new behavior default would hurt.
>
> I see your point. But if there is no PMP, Sil3132 is behaving, there
> is no need of this logic.

Yes, sure, the behavior is necessary iff PMP is attached as that's
only time SCR read failure can occur anyway and I think it would
generally be a good idea to always enforce the blind timeouts if PMP
is attached, so no need for ATA_LFLAG_WAIT_SRST.

> > Can you please post before & after logs?
> There are 2 problem with the current solution:
> - by not waiting for device spin up, we basically disabled staggered
> spinup: we send hard reset to all port very fast.
> That may put burden on enclosure with weak power supplies.
> - as Derry found out, disk which are slow to spin up can be ignored b=
y
> the kernel.

Looks pretty good to me.  Nice spotting.  Thanks a lot for tracking it
down and coming up with good solution. :)

--
tejun
