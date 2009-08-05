From: Grant Grundler <grundler@google.com>
Subject: Re: Adding new pci vendor id
Date: Wed, 5 Aug 2009 10:22:33 -0700
Message-ID: <da824cf30908051022w3bd70730uc5d5986f20e716fc@mail.gmail.com>
References: <E2EFBB65133B9448A32D870B45E3DBB30EEB434CF0@EXCHANGE.ad.gennum.com>
	 <da824cf30908040955vb26e4b6mbad1f80d5230d282@mail.gmail.com>
	 <E2EFBB65133B9448A32D870B45E3DBB30EEB434CF4@EXCHANGE.ad.gennum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:51734 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934704AbZHERWk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Aug 2009 13:22:40 -0400
Received: from spaceape14.eur.corp.google.com (spaceape14.eur.corp.google.com [172.28.16.148])
	by smtp-out.google.com with ESMTP id n75HMZEi030379
	for <linux-ide@vger.kernel.org>; Wed, 5 Aug 2009 18:22:36 +0100
Received: from yxe27 (yxe27.prod.google.com [10.190.2.27])
	by spaceape14.eur.corp.google.com with ESMTP id n75HMMgN000625
	for <linux-ide@vger.kernel.org>; Wed, 5 Aug 2009 10:22:33 -0700
Received: by yxe27 with SMTP id 27so301692yxe.19
        for <linux-ide@vger.kernel.org>; Wed, 05 Aug 2009 10:22:33 -0700 (PDT)
In-Reply-To: <E2EFBB65133B9448A32D870B45E3DBB30EEB434CF4@EXCHANGE.ad.gennum.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tauseef Hussain <Tauseef.Hussain@gennum.com>
Cc: "jeff@garzik.org" <jeff@garzik.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Wed, Aug 5, 2009 at 7:24 AM, Tauseef
Hussain<Tauseef.Hussain@gennum.com> wrote:
> Hi all
> Thanx for your response.
> I am using this flavor of linux distribution from red hat
> Linux 2.6.29.6-217.2.3.fc11.i686.PAE i686 GNU/Linux

Hi Tauseef,
This is a kernel version and not a distro release version.
Since I'm not involved with RH kernels, the kernel version doesn't
mean anything to me.

> which i obtained on my console on doing a uname -o -s -p -r command.
>
> However i dont have the source code of AHCI driver ahci.c with this distribution.

I'm certain RH is complying with it's a legal requirement (See GPL) to
make the kernel source available.

> Can you tell me whom to contact to get the source code for ahci.c for the distribution i am using?

Same website that you got the install CD from. Search for
"2.6.29.6-217.2.3.fc11 src.rpm" and you should find it.

cheers,
grant
