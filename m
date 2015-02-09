From: =?UTF-8?Q?Nuno_Magalh=C3=A3es?= <nunomagalhaes@eu.ipp.pt>
Subject: Re: SATA disks disabled on boot
Date: Mon, 9 Feb 2015 23:52:45 +0000
Message-ID: <CADqA9uY=odc27ZMefcz+k=rqpBT+cQtvjag7+jc82XePEhyt5w@mail.gmail.com>
References: <CADqA9uaW6JwirSZQaHjCuB=9GSUQyakOEBAZor1ed-vyjoC=2g@mail.gmail.com>
 <20140714163641.GF31610@htj.dyndns.org> <CADqA9uYMCdT1ZpHD0fOVoD67PAx6RaY+8grfmG8SRoqnwyyHgw@mail.gmail.com>
 <20140817133942.GD7679@mtj.dyndns.org> <CADqA9ubrD1+Ri9d080X4xjrr7wsjqGGz5fjTC45QHjr4Fb1QJg@mail.gmail.com>
 <CADqA9uaj0MrpffnzE8xnhU57Hx9pv7O1sAhB+xS_4hi8z_dkMA@mail.gmail.com>
 <20141202195653.GQ10918@htj.dyndns.org> <547E4817.8000603@eu.ipp.pt>
 <20141204174819.GC2995@htj.dyndns.org> <5480F54B.9070306@ubuntu.com>
 <54822DD3.6040405@eu.ipp.pt> <CADqA9ubh5wHZPHJNYeSrMgOQsRYZSObRkg7irg3w+H+2M+hTmw@mail.gmail.com>
 <54C8ECA2.3020705@ubuntu.com> <CADqA9ubfXpirXFgqKzaT4xQ-jQN7KGs7DHBRcgbrgQoRkY-EqA@mail.gmail.com>
 <54CB8CC6.5040801@ubuntu.com> <CADqA9uajygUCniypA2xqbi6HKBH6Conv=66u4BxPuuGP+v7gMg@mail.gmail.com>
 <54D12558.6000805@ubuntu.com> <CADqA9uZx+mAcZRYxbtWv8GDAzw0SkHTaP0Gv+ah7_YvabL9gTw@mail.gmail.com>
 <54D8B96C.8000804@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:54544 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbbBIXxI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Feb 2015 18:53:08 -0500
Received: by mail-ig0-f180.google.com with SMTP id b16so20127623igk.1
        for <linux-ide@vger.kernel.org>; Mon, 09 Feb 2015 15:53:06 -0800 (PST)
In-Reply-To: <54D8B96C.8000804@ubuntu.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

On Mon, Feb 9, 2015 at 1:43 PM, Phillip Susi <psusi@ubuntu.com> wrote:
> Putting the controller into raid mode != *using* the fakeraid
> capability.  In other words, just don't create a raid array in the
> bios utility and the disks will be used normally, while still
> operating in AHCI mode.

Ah, gotcha. Same effect though. Had to reset them.
