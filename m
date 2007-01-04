From: "Andrew Lyon" <andrew.lyon@gmail.com>
Subject: Re: ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0) r0xj0
Date: Thu, 4 Jan 2007 01:01:46 +0000
Message-ID: <f4527be0701031701q4eaafe63sfd5dcbbfddc89f51@mail.gmail.com>
References: <f4527be0612271812p7282de31j98462aebde16e5a1@mail.gmail.com>
	 <45933A53.1090702@gmail.com> <loom.20070103T020347-255@post.gmane.org>
	 <459B140C.1060401@gmail.com>
	 <Pine.LNX.4.64.0701030334460.12309@dolores.legate.org>
	 <459B2DEA.8080202@gmail.com>
	 <Pine.LNX.4.64.0701031733001.1969@dolores.legate.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:48197 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932229AbXADBBr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Jan 2007 20:01:47 -0500
Received: by ug-out-1314.google.com with SMTP id 44so5322763uga
        for <linux-ide@vger.kernel.org>; Wed, 03 Jan 2007 17:01:46 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0701031733001.1969@dolores.legate.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bbee <bumble.bee@xs4all.nl>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 1/3/07, bbee <bumble.bee@xs4all.nl> wrote:
> On Wed, 3 Jan 2007, Tejun Heo wrote:
> > bbee wrote:
> >>> Yeap, I have major issues with SDB FISes which contains spurious
> >>> completions but most other spurious interrupts shouldn't be dangerous
> >>> and I haven't seen spurious completions for quite some time, so I was
> >>> thinking either removing the message or printing it only on SDB FIS
> >>> containing spurious completions.
> >>>
> >>> But, Andrew Lyon *is* reporting spurious completions.  Now I just wanna
> >>> update those printks such that more info is reported only on spurious
> >>> SDB FISes.
> >>
> >> That would certainly help verify that I'm having the exact same problem,
> >> since Andrew didn't say anything about his drive going offline.
> >
> > Okay.
>
> Sorry, I thought you meant you would need to update it *further*. I applied
> the patch you gave to Andrew with this result so far:
>
> $ dmesg | grep -A1 "spurious interrupt"
> ata1: spurious interrupt (irq_stat 0x8 active_tag 0xfafbfcfd sactive 0x0)
> ata1: issue=0x0 SAct=0x0 SDB_FIS=004040a1:00000008
> --
> ata1: spurious interrupt (irq_stat 0x8 active_tag 0xfafbfcfd sactive 0x0)
> ata1: issue=0x0 SAct=0x0 SDB_FIS=004040a1:00000001
>
> No luck yet triggering the exception.
>
> On Wed, 3 Jan 2007, Andrew Lyon wrote:
> > Alan said he was going to add the drive to a blacklist he was
> > maintaining for NCQ, perhaps that has been done in kernel 2.6.19, I
> > dont know as I am still running 2.6.18.
> >
> > Perhaps the WD Raptor drive that I have does have lousy NCQ and that
> > explains both the poor performance and the spurious interrupts.
>
> Blacklisting NCQ on the drive(s) for all controllers might be ill advised,
> since it could be a JMicron-specific issue (or ahci-specific, since the
> person in the thread I referenced had a different ahci controller..).
> Either that, or both our drive models have "lousy NCQ"..
>
>
> Thanks,
>
> bbee
>

Is there anything more I can do to assist? I plan to upgrade to
2.6.19/latest at the weekend, let me know if there is anything more i
can do.

Andy
