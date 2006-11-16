From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problem booting linux 2.6.19-rc5, 2.6.19-rc5-git6,      2.6.19-rc5-mm2
 with md raid 1 over lvm root
Date: Thu, 16 Nov 2006 09:26:03 +0900
Message-ID: <455BB01B.2080309@gmail.com>
References: <41884.81.64.156.37.1163631254.squirrel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:27158 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1162112AbWKPA0d (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Nov 2006 19:26:33 -0500
Received: by ug-out-1314.google.com with SMTP id m3so311266ugc
        for <linux-ide@vger.kernel.org>; Wed, 15 Nov 2006 16:26:31 -0800 (PST)
In-Reply-To: <41884.81.64.156.37.1163631254.squirrel@rousalka.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-raid@vger.kernel.org, neilb@cse.unsw.edu.au, mingo@redhat.com, dm-devel@redhat.com

Nicolas Mailhot wrote:
> The failing kernels (I tried -rc5, -rc5-git6, -rc5-mm2 only print :
>=20
> %<----
> device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised:
> dm-devel@redhat.com
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> %<-----
>=20
> (I didn't bother copying the rest of the failing kernel dmesg, as sat=
a
> initialisation fills the first half of the screen, then dm is initial=
ised,
> then you only get the logical consequences of failing to detect the /
> volume. The sata part seems fine =E2=80=93 it prints the name of the =
hard drives
> we want to use)
>=20
> I'm attaching the dmesg for the working distro kernel (yes I know not=
 100%
> distro kernel, but very close to one), distro config , and the config=
 I
> used in my test. If anyone could help me to figure what's wrong I'd b=
e
> grateful.

Say 'y' not 'm' to SCSI disk support.

--=20
tejun
