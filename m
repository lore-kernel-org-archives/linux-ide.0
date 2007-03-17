From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] jmicron: make ide jmicron driver play nice with libata ones
Date: Sat, 17 Mar 2007 22:53:57 +0100
Message-ID: <200703172253.57413.bzolnier@gmail.com>
References: <20070316060610.GA6152@htj.dyndns.org> <200703172136.20784.bzolnier@gmail.com> <20070317221311.2d114d2d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:8472 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbXCQVqk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Mar 2007 17:46:40 -0400
Received: by ug-out-1314.google.com with SMTP id 44so991780uga
        for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 14:46:38 -0700 (PDT)
In-Reply-To: <20070317221311.2d114d2d@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, justin@jmicron.com


On Saturday 17 March 2007, Alan Cox wrote:
> > > PATA ports live in separate functions with different programming
> > > interfaces.  pata_jmicron and ide jmicron drivers can drive only the
> > > PATA part.
> 
> This isn't actually true. The IDE jmicron driver can drive both the PATA
> and the SATA parts in legacy mode. It cannot drive the SATA part in AHCI
> mode.

Yes but the quoted sentence is missing the full context:

> When libata is configured, the device is configured such that SATA and
> PATA ports live in separate functions with different programming
> interfaces.  pata_jmicron and ide jmicron drivers can drive only the
> PATA part.

when libata is configured jmicron is _always_ programmed for native mode

Bart
