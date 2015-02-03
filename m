From: =?UTF-8?Q?Nuno_Magalh=C3=A3es?= <nunomagalhaes@eu.ipp.pt>
Subject: Re: SATA disks disabled on boot
Date: Tue, 3 Feb 2015 19:32:41 +0000
Message-ID: <CADqA9uajygUCniypA2xqbi6HKBH6Conv=66u4BxPuuGP+v7gMg@mail.gmail.com>
References: <CADqA9uaW6JwirSZQaHjCuB=9GSUQyakOEBAZor1ed-vyjoC=2g@mail.gmail.com>
 <20140714163641.GF31610@htj.dyndns.org> <CADqA9uYMCdT1ZpHD0fOVoD67PAx6RaY+8grfmG8SRoqnwyyHgw@mail.gmail.com>
 <20140817133942.GD7679@mtj.dyndns.org> <CADqA9ubrD1+Ri9d080X4xjrr7wsjqGGz5fjTC45QHjr4Fb1QJg@mail.gmail.com>
 <CADqA9uaj0MrpffnzE8xnhU57Hx9pv7O1sAhB+xS_4hi8z_dkMA@mail.gmail.com>
 <20141202195653.GQ10918@htj.dyndns.org> <547E4817.8000603@eu.ipp.pt>
 <20141204174819.GC2995@htj.dyndns.org> <5480F54B.9070306@ubuntu.com>
 <54822DD3.6040405@eu.ipp.pt> <CADqA9ubh5wHZPHJNYeSrMgOQsRYZSObRkg7irg3w+H+2M+hTmw@mail.gmail.com>
 <54C8ECA2.3020705@ubuntu.com> <CADqA9ubfXpirXFgqKzaT4xQ-jQN7KGs7DHBRcgbrgQoRkY-EqA@mail.gmail.com>
 <54CB8CC6.5040801@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:42143 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965703AbbBCTdD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Feb 2015 14:33:03 -0500
Received: by mail-ie0-f170.google.com with SMTP id y20so27841084ier.1
        for <linux-ide@vger.kernel.org>; Tue, 03 Feb 2015 11:33:02 -0800 (PST)
In-Reply-To: <54CB8CC6.5040801@ubuntu.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Hi,

On Fri, Jan 30, 2015 at 1:53 PM, Phillip Susi <psusi@ubuntu.com> wrote:
> On 1/29/2015 5:04 PM, Nuno Magalh=C3=A3es wrote:
>
>> With this information, do you think AHCI mode could help? How can i
>> enable that?
>
> Most BIOS with integrated SATA chips have an option somewhere to
> toggle it between legacy IDE mode, AHCI mode, and often RAID mode.

Not the case. This is a Phoenix-Award BIOS, v6.00PG, Revision 5005
(the last to come out for this motherboard and the only one supporting
its current CPU).

The BIOS shows the regular Primary/Secondary IDE Master/Slave (to
which only the CDROM is attached) alongside SATA. It doesn't seem like
SATA is the option, bu rather that both IDE and SATA are seen as
current usable interfaces (at the time the BIOS was released: 2010).
It does have NVRAID, which is disabled (i use mdadm).

There is no mention of AHCI that i could find.

Regardless, as long as linux sees the HDDs on boot (which it does even
with PUIS), does the BIOS have any influence in this issue?


Thanks for your time,
Nuno
