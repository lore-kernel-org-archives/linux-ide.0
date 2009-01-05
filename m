From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Mon, 5 Jan 2009 13:33:40 +0000
Message-ID: <20090105133340.050858bb@lxorguk.ukuu.org.uk>
References: <49615667.9020408@iwl.com>
	<yq1vdsu317m.fsf@sermon.lab.mkp.net>
	<496200A3.2000906@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56486 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751286AbZAENeA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 08:34:00 -0500
In-Reply-To: <496200A3.2000906@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Karl Auerbach <karl@iwl.com>, linux-ide@vger.kernel.org, karl@cavebear.com

> > The IDE interface of the Geode CS5536 companion chip is a completely
> > different beast.  It's a more or less standard AMD 8111 PCI IDE device
> > with slightly different timings.
> 
>    I'm not sure I uderstand the passage about "slightly different 
> timings"...

The timing values used are different to those on the AMD 8111 even though
the interface is similar.

>    It's stange that the driver is using CPI config. space by default 
> which not even documented in the datasheet. I guess the MSR accesses are 

The PCI configuration is the portable way to drive it.

> also somewhat faster because one doesn't have to access the address/data 
> register pair at ports 0xcf8/0xcfc...

This is a Geode. What makes you think there is even a PCI bus or that the
8111 interface isn't entirely a software construct. Geode PCI hardware
is mostly smoke and mirrors ;)

Alan
