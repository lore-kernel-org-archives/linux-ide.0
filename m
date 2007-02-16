From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] use winbond libata instead of ide driver for pseries CD drives
Date: Fri, 16 Feb 2007 15:53:54 +0100
Message-ID: <200702161553.54550.bzolnier@gmail.com>
References: <20070210203512.GA25586@aepfle.de> <20070216092046.GA2572@aepfle.de> <45D5B720.4010308@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:9603 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161033AbXBPOsG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Feb 2007 09:48:06 -0500
Received: by ug-out-1314.google.com with SMTP id 44so165615uga
        for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2007 06:48:04 -0800 (PST)
In-Reply-To: <45D5B720.4010308@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Olaf Hering <olaf@aepfle.de>, Jeff Garzik <jeff@garzik.org>, Paul Mackeras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org


On Friday 16 February 2007 14:52, Sergei Shtylyov wrote:

>     I'm sorry, how those 2 drivers can be equivalent?! The pata_winbond driver 
> is for VLB only, sl81c105 was for PCI only -- you certainly want to use 
> pata_sl82c105 (indeed better version of sl82c105 driver).

I was under the impression that with your fixes these drivers
(sl82c105 and pata_sl82c105) are functionally equivalent.

Did I miss something (i.e. some patches)?

Bart
