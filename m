From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6] Issue INITIALIZE DEVICE PARAMETERS for
 CHS only devices
Date: Wed, 23 Feb 2005 22:15:05 -0500
Message-ID: <421D46B9.5060602@pobox.com>
References: <006d01c50c11$81003920$a801a8c0@tw.ibm.com> <42167CDD.50301@pobox.com> <421C6840.7090903@tw.ibm.com> <421C97C1.9090701@pobox.com> <421D3DB1.1090800@tw.ibm.com> <421D458E.4070909@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51079 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261763AbVBXDP2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Feb 2005 22:15:28 -0500
In-Reply-To: <421D458E.4070909@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Albert Lee wrote:
> 
>>
>>   If the device supports LBA, then IDP is not issued in my patch. Is 
>> this OK?
> 
> 
> It has been about a decade, but my memory vaguely suggests
> that I tried that once before, and some LBA-capable drives
> still required the IDP before they would function normally.
> 
> I think anything ATA-4 or later was fine, though.

So a safe rule would be

	if (ATA < 4)
		issue init-dev-params
	if (lba)
		...current code...
	else /* CHS */
		...current code...

?

	Jeff



