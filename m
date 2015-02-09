From: =?UTF-8?Q?Nuno_Magalh=C3=A3es?= <nunomagalhaes@eu.ipp.pt>
Subject: Re: SATA disks disabled on boot
Date: Mon, 9 Feb 2015 13:02:01 +0000
Message-ID: <CADqA9uZx+mAcZRYxbtWv8GDAzw0SkHTaP0Gv+ah7_YvabL9gTw@mail.gmail.com>
References: <CADqA9uaW6JwirSZQaHjCuB=9GSUQyakOEBAZor1ed-vyjoC=2g@mail.gmail.com>
 <20140714163641.GF31610@htj.dyndns.org> <CADqA9uYMCdT1ZpHD0fOVoD67PAx6RaY+8grfmG8SRoqnwyyHgw@mail.gmail.com>
 <20140817133942.GD7679@mtj.dyndns.org> <CADqA9ubrD1+Ri9d080X4xjrr7wsjqGGz5fjTC45QHjr4Fb1QJg@mail.gmail.com>
 <CADqA9uaj0MrpffnzE8xnhU57Hx9pv7O1sAhB+xS_4hi8z_dkMA@mail.gmail.com>
 <20141202195653.GQ10918@htj.dyndns.org> <547E4817.8000603@eu.ipp.pt>
 <20141204174819.GC2995@htj.dyndns.org> <5480F54B.9070306@ubuntu.com>
 <54822DD3.6040405@eu.ipp.pt> <CADqA9ubh5wHZPHJNYeSrMgOQsRYZSObRkg7irg3w+H+2M+hTmw@mail.gmail.com>
 <54C8ECA2.3020705@ubuntu.com> <CADqA9ubfXpirXFgqKzaT4xQ-jQN7KGs7DHBRcgbrgQoRkY-EqA@mail.gmail.com>
 <54CB8CC6.5040801@ubuntu.com> <CADqA9uajygUCniypA2xqbi6HKBH6Conv=66u4BxPuuGP+v7gMg@mail.gmail.com>
 <54D12558.6000805@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:51047 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759680AbbBINCW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Feb 2015 08:02:22 -0500
Received: by mail-ig0-f181.google.com with SMTP id hn18so15999646igb.2
        for <linux-ide@vger.kernel.org>; Mon, 09 Feb 2015 05:02:21 -0800 (PST)
In-Reply-To: <54D12558.6000805@ubuntu.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Phillip Susi <psusi@ubuntu.com>

On Tue, Feb 3, 2015 at 7:45 PM, Phillip Susi <psusi@ubuntu.com> wrote:
> On 2/3/2015 2:32 PM, Nuno Magalh=C3=A3es wrote:
>> The BIOS shows the regular Primary/Secondary IDE Master/Slave (to
>> which only the CDROM is attached) alongside SATA. It doesn't seem
>> like SATA is the option, bu rather that both IDE and SATA are seen
>> as current usable interfaces (at the time the BIOS was released:
>> 2010). It does have NVRAID, which is disabled (i use mdadm).
>
> Typically there is a knob that toggles between three states: IDE,
> AHCI, and RAID.  RAID really is AHCI just with a different PCI
> identifier that causes windows to load their proprietary driver that
> does the software raid.  If you only have an on/off switch for the
> raid, then try switching it on.

A knob? You mean a knob on the motherboard? No such thing (that i can
see). A jumper perhaps? I'll check the manual.
As for BIOS RAID, every howto and tutorial i read about software
RAID/mdadm advices aggainst using the BIOS RAID implementation as it's
usually quite lacking in terms of quality.

>> There is no mention of AHCI that i could find.

Maybe it never got to this BIOS. Maybe there is something AHCI-related
in NVRAID, i never poked into that.
