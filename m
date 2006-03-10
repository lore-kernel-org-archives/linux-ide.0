From: Tejun Heo <htejun@gmail.com>
Subject: Re: gigabyte iRam not seen by linux
Date: Sat, 11 Mar 2006 02:51:50 +0900
Message-ID: <4411BCB6.5080108@gmail.com>
References: <20060310013604.1acac722.pegasus@nerv.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.176]:19061 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751170AbWCJRvz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Mar 2006 12:51:55 -0500
Received: by pproxy.gmail.com with SMTP id d42so428739pyd
        for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 09:51:54 -0800 (PST)
In-Reply-To: <20060310013604.1acac722.pegasus@nerv.eu.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?SnVyZSBQZcSNYXI=?= <pegasus@nerv.eu.org>
Cc: linux-ide@vger.kernel.org

Jure Pe=C4=8Dar wrote:
> Hi all,
>=20
> I just got a gigabyte solid state disk on a test. However, it is not =
seen by linux. The problem is described well here:
> http://www.linuxquestions.org/questions/showthread.php?t=3D411600
>=20
> What can one do when there *is* something on the sata port but the dr=
iver doesn't recognize it? It's not even in the /sys/block/ or /sys/bus=
/scsi/ ...  If I don't have the device, I can't use sg utils to ask it =
how it feels ...=20
>=20
> I'd really want to use this ssd under linux, but I don't know how to =
debug the problem from here.
>=20

Please set up either a vanialla kernel (preferably the latestet one,=20
2.6.16-rc5) or, if you can use git, #upstream branch of libata-dev=20
repository. Before compiling the kernel, change #undef ATA_DEBUG in=20
include/linux/libata.h to #define ATA_DEBUG. You might also need to=20
increase the size of printk buffer size (kernel hacking -> kernel log=20
buffer size).

After booting with such kernel, please post the result of dmesg.

Thanks.

--=20
tejun
