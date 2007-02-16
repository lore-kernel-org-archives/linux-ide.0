From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] use winbond libata instead of ide driver for pseries CD drives
Date: Fri, 16 Feb 2007 15:51:49 +0100
Message-ID: <200702161551.49697.bzolnier@gmail.com>
References: <20070210203512.GA25586@aepfle.de> <20070216092046.GA2572@aepfle.de> <200702161546.01159.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:5499 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161028AbXBPOp7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Feb 2007 09:45:59 -0500
Received: by ug-out-1314.google.com with SMTP id 44so164961uga
        for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2007 06:45:58 -0800 (PST)
In-Reply-To: <200702161546.01159.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: Jeff Garzik <jeff@garzik.org>, Paul Mackeras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org


On Friday 16 February 2007 15:46, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Friday 16 February 2007 10:20, Olaf Hering wrote:
> > 
> > Change the default for the built-in IDE on p610/p615/p630 from
> > ide to libata. libata has better error handling and the drive can
> > recover when hald does its CD media polling.
> > 
> > Signed-off-by: Olaf Hering <olaf@aepfle.de>
> 
> Does IDE sl82c105 need the same udelay() fix patch as done for
> pata_winbond?

s/pata_winbond/pata_sl82c105/ of course
