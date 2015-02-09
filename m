From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: SATA disks disabled on boot
Date: Mon, 09 Feb 2015 08:43:08 -0500
Message-ID: <54D8B96C.8000804@ubuntu.com>
References: <CADqA9uaW6JwirSZQaHjCuB=9GSUQyakOEBAZor1ed-vyjoC=2g@mail.gmail.com> <20140714163641.GF31610@htj.dyndns.org> <CADqA9uYMCdT1ZpHD0fOVoD67PAx6RaY+8grfmG8SRoqnwyyHgw@mail.gmail.com> <20140817133942.GD7679@mtj.dyndns.org> <CADqA9ubrD1+Ri9d080X4xjrr7wsjqGGz5fjTC45QHjr4Fb1QJg@mail.gmail.com> <CADqA9uaj0MrpffnzE8xnhU57Hx9pv7O1sAhB+xS_4hi8z_dkMA@mail.gmail.com> <20141202195653.GQ10918@htj.dyndns.org> <547E4817.8000603@eu.ipp.pt> <20141204174819.GC2995@htj.dyndns.org> <5480F54B.9070306@ubuntu.com> <54822DD3.6040405@eu.ipp.pt> <CADqA9ubh5wHZPHJNYeSrMgOQsRYZSObRkg7irg3w+H+2M+hTmw@mail.gmail.com> <54C8ECA2.3020705@ubuntu.com> <CADqA9ubfXpirXFgqKzaT4xQ-jQN7KGs7DHBRcgbrgQoRkY-EqA@mail.gmail.com> <54CB8CC6.5040801@ubuntu.com> <CADqA9uajygUCniypA2xqbi6HKBH6Conv=66u4BxPuuGP+v7gMg@mail.gmail.com>
  <54D12558.6000805@ubuntu.com> <CADqA9uZx+mAcZRYxbtWv8GDAzw0SkHTaP0Gv+ah7_YvabL9gTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:46190 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932667AbbBINnb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Feb 2015 08:43:31 -0500
Received: by mail-qa0-f41.google.com with SMTP id x12so3844360qac.0
        for <linux-ide@vger.kernel.org>; Mon, 09 Feb 2015 05:43:30 -0800 (PST)
In-Reply-To: <CADqA9uZx+mAcZRYxbtWv8GDAzw0SkHTaP0Gv+ah7_YvabL9gTw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TnVubyBNYWdhbGjDo2Vz?= <nunomagalhaes@eu.ipp.pt>, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2/9/2015 8:02 AM, Nuno Magalh=C3=A3es wrote:
> A knob? You mean a knob on the motherboard? No such thing (that i
> can see). A jumper perhaps? I'll check the manual.

No, I meant a setting in the bios.

> As for BIOS RAID, every howto and tutorial i read about software=20
> RAID/mdadm advices aggainst using the BIOS RAID implementation as
> it's usually quite lacking in terms of quality.

Putting the controller into raid mode !=3D *using* the fakeraid
capability.  In other words, just don't create a raid array in the
bios utility and the disks will be used normally, while still
operating in AHCI mode.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJU2LlsAAoJENRVrw2cjl5RqDkH/1fxcXmySKCvE0hW8HjK6QSb
8NwgAiqy/3VeqFEihKu+L3OPCjDjoFwxgMTffK/XrdTijmAoshifAuTOtmX2NaQw
6jFPZmjEtU9VLVnQHpUBDX09vJ2ikbktxXoV4KKGf7hWiRKZZUx+qkQfX4bkFTbA
weGiMv5gnqxxEjozrotWIm/grrFR5xd4T98TXT0ZKkMKkMILaiKv9IUzV+jMbcIv
O7iniqZEgUBQBHhBo8HhiovCRvIvK2s4ljdWORKbwNl3uSkfvPZv+Hg7A5/AGubY
AZgW/5xAn12xdflvMoxTWjlgcox4J8Ji7B4ZV6yHOmDth4Okvq9Bi8VK20596Y4=3D
=3D6fry
-----END PGP SIGNATURE-----
