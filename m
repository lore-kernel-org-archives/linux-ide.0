From: Baruch Even <baruch@ev-en.org>
Subject: Re: AHCI and SSS
Date: Mon, 24 Jun 2013 22:23:55 +0300
Message-ID: <CAC9+anKFQG2vWEtyWCkcHXj+9E2zwFAkXu1Wi2t=ZDPdJK7oeA@mail.gmail.com>
References: <20130624191631.GA5402@lazy.lzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:61364 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735Ab3FXTYR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jun 2013 15:24:17 -0400
Received: by mail-ee0-f41.google.com with SMTP id d17so6342496eek.28
        for <linux-ide@vger.kernel.org>; Mon, 24 Jun 2013 12:24:15 -0700 (PDT)
In-Reply-To: <20130624191631.GA5402@lazy.lzy>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
Cc: linux-ide <linux-ide@vger.kernel.org>

I don't know how if at all Linux will do staggered startups but the
SAS devices normally do their own staggered startups. Most times you
have the devices in an enclosure with an expander that does its own
staggered startup and only presents the devices to the host when they
are ready. I believe that the SAS HBA (I've mostly worked with LSI)
will do staggered startups on its own.

In all of these cases once the system was started once and if the
devices were sent to idle it is the responsibility of the host to do
the staggered startup from idle. Since the staggered startup needs to
be aware of power distribution and limits therein you can either do a
very dump thing in the kernel to start all devices one by one with
some delay or have a user-daemon perform or install a policy to
instruct a finer granularity in case of a better power distribution
policy, possibly by querying the expanders and inferring the topology
somehow.

Baruch

On Mon, Jun 24, 2013 at 10:16 PM, Piergiorgio Sartor
<piergiorgio.sartor@nexgo.de> wrote:
> Hi all,
>
> I've a couple of questions about AHCI and SSS.
>
> If I understand it correctly, SSS is used to
> honor the PUS (Power Up in Standby) otherwise
> known as SSU (Staggered Spin Up).
> That is, if the HDDs at boot are in idle, they
> will be waked up one after the other and not
> all together, in order to reduce the power spike.
>
> How about a system already running, where the
> HDDs are set to idle?
> For example, assuming we have a RAID-5, with
> 5~6 HDDs and we put them to sleep.
> When the RAID is accessed, all the HDDs are
> wakeup in parellel.
> Is there any way to serialize all the accesses
> to the HDDs?
> Or, is there an other solution to the problem?
>
> Second question.
> As far as I know, only the ahci driver supports
> this SSS.
> How about other drivers?
> How about the SAS drivers (I know, this is linux-ide,
> but maybe someone will know as well)?
>
> Thanks a lot in advance,
>
> bye,
>
> --
>
> piergiorgio
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
