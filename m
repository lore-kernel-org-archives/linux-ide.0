From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: No IDE drivers loaded for Toshiba Satellite 320 CDS
Date: Tue, 15 Apr 2008 11:04:19 +0100
Message-ID: <20080415110419.785a75ee@core>
References: <200804021524.27222.elendil@planet.nl>
	<200804021820.04610.elendil@planet.nl>
	<20080402194938.GI24237@csclub.uwaterloo.ca>
	<200804031947.07674.elendil@planet.nl>
	<48017248.4030600@gmail.com>
	<20080414134734.GB7385@csclub.uwaterloo.ca>
	<20080414145302.4239b0b9@core>
	<480414E6.2090205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55184 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756292AbYDOKIz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2008 06:08:55 -0400
In-Reply-To: <480414E6.2090205@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Frans Pop <elendil@planet.nl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Always loading generic or ata_generic used to be safe.  It's still 
> pretty safe but not as much as before.  Nowadays, there are good number 

ata_generic is always safe unless you force it to grab every class
device. By default it grabs only those devices we know obey the class
interface well enough and for which we have no proper driver (usually
because there are no documents). Ditto for ide/pci/generic.

The trickier one is pata_legacy, which tries to be smart and knows about
the known exception so *should* always be safe. The old IDE legacy driver
lacks these smarts so in some cases will do the wrong thing even if
loaded last.

Alan
