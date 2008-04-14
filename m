From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: No IDE drivers loaded for Toshiba Satellite 320 CDS
Date: Mon, 14 Apr 2008 14:53:02 +0100
Message-ID: <20080414145302.4239b0b9@core>
References: <200804021524.27222.elendil@planet.nl>
	<200804021820.04610.elendil@planet.nl>
	<20080402194938.GI24237@csclub.uwaterloo.ca>
	<200804031947.07674.elendil@planet.nl>
	<48017248.4030600@gmail.com>
	<20080414134734.GB7385@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760146AbYDNN5e@vger.kernel.org>
In-Reply-To: <20080414134734.GB7385@csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Tejun Heo <htejun@gmail.com>, Frans Pop <elendil@planet.nl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: linux-ide@vger.kernel.org

> If a driver supports a device with dual interfaces, then it better
> reserve both sets of ports to prevent the generic driver from trying to
> use them.

That isn't the problem. The generic driver doesn't know if there is
another valid driver for the ports - how can it - and the other driver
may not be loaded first so cannot reserve the ports. If you load the
generic driver last then you should be fine, and the link order for IDE
and libata puts acpi, pci generic and legacy at the end for good reason.

Libata pata_legacy has some smarts in this area but they are only good
for the common cases.

Alan
