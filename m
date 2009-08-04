From: Grant Grundler <grundler@google.com>
Subject: Re: Adding new pci vendor id
Date: Tue, 4 Aug 2009 09:55:48 -0700
Message-ID: <da824cf30908040955vb26e4b6mbad1f80d5230d282@mail.gmail.com>
References: <E2EFBB65133B9448A32D870B45E3DBB30EEB434CF0@EXCHANGE.ad.gennum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:46190 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932899AbZHDQzw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Aug 2009 12:55:52 -0400
Received: from spaceape11.eur.corp.google.com (spaceape11.eur.corp.google.com [172.28.16.145])
	by smtp-out.google.com with ESMTP id n74Gtp0Z007634
	for <linux-ide@vger.kernel.org>; Tue, 4 Aug 2009 17:55:51 +0100
Received: from an-out-0708.google.com (anab2.prod.google.com [10.100.53.2])
	by spaceape11.eur.corp.google.com with ESMTP id n74GtmEm026686
	for <linux-ide@vger.kernel.org>; Tue, 4 Aug 2009 09:55:49 -0700
Received: by an-out-0708.google.com with SMTP id b2so1786062ana.11
        for <linux-ide@vger.kernel.org>; Tue, 04 Aug 2009 09:55:48 -0700 (PDT)
In-Reply-To: <E2EFBB65133B9448A32D870B45E3DBB30EEB434CF0@EXCHANGE.ad.gennum.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tauseef Hussain <Tauseef.Hussain@gennum.com>
Cc: Rashmi Mohapatra <Rashmi.Mohapatra@gennum.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Shefali Mishra <shefali.mishra@snowbush.com>

On Tue, Aug 4, 2009 at 8:32 AM, Tauseef
Hussain<Tauseef.Hussain@gennum.com> wrote:
> Hi
> I am using a kernel which uses a =C2=A0precompiled kernel object of a=
hci.c =C2=A0viz. ahci.ko
> I would like to know how can i add new pci vendor device id in the ah=
ci_pci_tbl[] structure

See Documentation/SubmittingPatches in your kernel source tree.

If the new HW is intended to work with a distro (e.g., Redhat, SuSe,
Debian, Ubuntu, et al)
you will need to contact each distro and submit a patch in a similar
fashion to them.

> then how can i compile the modified ahci.c and use the .ko file for m=
y use?

The following simplified answer should work for most distro's but
unlikely to work 100% of the time:
    sudo make modules_install
    sudo make install
    sudo reboot

Then interrupt the boot loader (likely grub) to select your kernel.

And given the nature of your questions, I suggest you visit
kttp://kernelnewbies.org .

cheers,
grant
