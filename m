From: Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH libata-dev-2.6] Issue INITIALIZE DEVICE PARAMETERS for
 CHS only devices
Date: Wed, 23 Feb 2005 22:10:06 -0500
Message-ID: <421D458E.4070909@pobox.com>
References: <006d01c50c11$81003920$a801a8c0@tw.ibm.com> <42167CDD.50301@pobox.com> <421C6840.7090903@tw.ibm.com> <421C97C1.9090701@pobox.com> <421D3DB1.1090800@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:56968 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261749AbVBXDLT
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Feb 2005 22:11:19 -0500
In-Reply-To: <421D3DB1.1090800@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>

Albert Lee wrote:
> 
>   If the device supports LBA, then IDP is not issued in my patch. Is 
> this OK?

It has been about a decade, but my memory vaguely suggests
that I tried that once before, and some LBA-capable drives
still required the IDP before they would function normally.

I think anything ATA-4 or later was fine, though.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

