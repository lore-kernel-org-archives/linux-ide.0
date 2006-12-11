From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: libata Patches
Date: Mon, 11 Dec 2006 14:50:59 -0500
Message-ID: <87f94c370612111150kf425d74r98f917031e41d959@mail.gmail.com>
References: <457D0B67.6000406@med.uni-tuebingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:56041 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763040AbWLKTvB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Dec 2006 14:51:01 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1434736uga
        for <linux-ide@vger.kernel.org>; Mon, 11 Dec 2006 11:51:00 -0800 (PST)
In-Reply-To: <457D0B67.6000406@med.uni-tuebingen.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Kasimir_M=FCller?= <Kasimir.Mueller@med.uni-tuebingen.de>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org

On 12/11/06, Kasimir M=FCller <Kasimir.Mueller@med.uni-tuebingen.de> wr=
ote:
> Hi Tejun,
> I have tested your patches with the vanilla 2.6.18.1 - Kernel and it =
works like a charm.
> I have spent hours of copying, reading and deleting data to a softwar=
e-raid-5 on a Machine with
>
> Mainboard: Elitegroup K8T890-A
> Prozessor: Athlon64
> Addonics  5X1 eSATA Port Multiplier (PM) (AD5SAPM-E)
> Addonics SATA-Controller PCIe-Card ADSA3GPX1-2E
> System: openSuse 10.1
>
> Because Suse uses a patched kernel
> I cannot apply your patch to the standard-kernel from the openSUSE-Di=
stribution.
> As far as I can see (I'm not a programmer),
> the driver-sources are already in the ata-directory of the kernel,
> so the patch generates a lot of errors.
>
> Could give any advice (on your wiki), how to deal with this ?
>

I believe the openSUSE 10.2 kernel will work with openSUSE 10.1 userlan=
d tools.

Therefore I would get the openSUSE 10.2 kernel (2.6.18 based) and try
that.  If you then want to apply even more patches you should not have
too much trouble applying patches targetting 2.6.18

http://download.opensuse.org/distribution/10.2/repo/src-oss/suse/src/ke=
rnel-source-2.6.18.2-34.src.rpm

Greg
--=20
Greg Freemyer
The Norcross Group
=46orensics for the 21st Century
