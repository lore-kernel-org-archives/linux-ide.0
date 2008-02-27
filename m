From: Jeff Garzik <jeff@garzik.org>
Subject: Re: PATA Sil680 Disabling IRQ
Date: Tue, 26 Feb 2008 19:58:38 -0500
Message-ID: <47C4B5BE.7010709@garzik.org>
References: <8202f4270802261647t505cccf7ra3c81e5fccc9366a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48820 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763349AbYB0A6l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Feb 2008 19:58:41 -0500
In-Reply-To: <8202f4270802261647t505cccf7ra3c81e5fccc9366a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>

Fajun Chen wrote:
> Hi All,
> 
> Attached is the source code to Identify Device through sg (courtesy of
> Mark Lord).  I intentionally change the data transfer from
> SG_DXFER_FROM_DEV to SG_DXFER_TO_DEV to expose the problem.  When the
> code is run on SATA Sil3124 controller,  it's working well. But when
> it is run on PATA Sil680,  IRQ was disabled right away (see dmesg log
> below). I have a old kernel 2.6.18 rc2 but I suspect the same problem
> exists in latest kernel release as well.  Please execute above code in
> your system and see what happens.

root has permission to do anything -- including misprogram the device 
resulting in a lockup / data corruption / nuclear explosion.

We do not work around problems that only present themselves when a 
privileged administrator is doing something really wrong.

	Jeff



