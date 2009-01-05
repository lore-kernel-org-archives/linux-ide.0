From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Mon, 5 Jan 2009 18:04:58 +0000
Message-ID: <20090105180458.20a0bdd0@lxorguk.ukuu.org.uk>
References: <49615667.9020408@iwl.com>
	<yq1vdsu317m.fsf@sermon.lab.mkp.net>
	<496200A3.2000906@ru.mvista.com>
	<20090105133340.050858bb@lxorguk.ukuu.org.uk>
	<496247AA.1040809@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41156 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750823AbZAESE7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 13:04:59 -0500
In-Reply-To: <496247AA.1040809@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Karl Auerbach <karl@iwl.com>, linux-ide@vger.kernel.org, karl@cavebear.com

>     What do you mean by timing values anyway, clock counts or the register 
> encoding itself?

The counts, the encoding is the same.

> 
> >>   It's stange that the driver is using CPI config. space by default 
> >>which not even documented in the datasheet. I guess the MSR accesses are 
> 
> > The PCI configuration is the portable way to drive it.
> 
>     Portable to what? As you have yorself noted below, this is Geode -- and I 
> highly doubt that CS5536 will be used for anything else.

The Geode hardware and software interfaces are rather independant. The
hardware one may change in future product and the software one stay the
same (eg the way softvga does compared with touching the display
controllers on the older devices)

Alan
