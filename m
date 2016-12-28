From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] Fix interface autodetection in legacy IDE driver (trial #2)
Date: Wed, 28 Dec 2016 12:16:18 +0100
Message-ID: <6105580.S4WFXMp3yn@amdc3058>
References: <CGME20161227172520epcas5p3e8ce2b1af4b5a3e1d9a42434d9c9b14f@epcas5p3.samsung.com>
 <20161228003335.GA3720@giustizia>
 <20161227.193818.1314136105272589794.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:32949 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbcL1LQY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 28 Dec 2016 06:16:24 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OIW00AXM7BA5S30@mailout1.samsung.com> for
 linux-ide@vger.kernel.org; Wed, 28 Dec 2016 20:16:22 +0900 (KST)
In-reply-to: <20161227.193818.1314136105272589794.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: lramos.prof@yahoo.com.br, linux-ide@vger.kernel.org, petkovbb@gmail.com


Hi,

On Tuesday, December 27, 2016 07:38:18 PM David Miller wrote:
> From: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
> Date: Tue, 27 Dec 2016 22:33:35 -0200
> 
> > So, ide_generic_init() should test *primary for 1 in the case of an
> > existing IDE primary resource, and *secondary for 1 in the case of a
> > secondary IDE resource.
> > 
> > Unpatched code checks both for zero in order to set the proper bits in
> > probe_mask, and IMHO this is reversed logic.
> 
> Right, and I can't see how this is intentional at all.

If PCI IDE resource is found we shouldn't do the probe automatically
as ide-generic is not the proper driver to run the hardware.  IOW we
only want to do automatic probe if no PCI IDE resources are found (if
primary/secondary == 0).  In such case we are most likely running on
pre-PCI system and should be probing for legacy ISA IDE ports. Please
note they are using the same I/O resources as PCI IDE ones (!).

[ Please see the reply to Luiz for the full explanation. ]

I know that you're busy and don't have time for in-depth analysis
of non-obvious IDE patches.  I would like to help and (co-)maintain 
the IDE subsystem (deep maintenance mode policy would of course be
preserved).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

