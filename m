From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH libata-dev-2.6] Issue INITIALIZE DEVICE PARAMETERS for
 CHS only devices
Date: Wed, 23 Feb 2005 22:35:30 -0500
Message-ID: <421D4B82.9000705@rtr.ca>
References: <006d01c50c11$81003920$a801a8c0@tw.ibm.com> <42167CDD.50301@pobox.com> <421C6840.7090903@tw.ibm.com> <421C97C1.9090701@pobox.com> <421D3DB1.1090800@tw.ibm.com> <421D458E.4070909@pobox.com> <421D46B9.5060602@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:58760 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261614AbVBXDgm
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Feb 2005 22:36:42 -0500
In-Reply-To: <421D46B9.5060602@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <mlord@pobox.com>, Albert Lee <albertcc@tw.ibm.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>

>> It has been about a decade, but my memory vaguely suggests
>> that I tried that once before, and some LBA-capable drives
>> still required the IDP before they would function normally.
>>
>> I think anything ATA-4 or later was fine, though.

So..

if (ATA < 4 || !lba_capable)
     issue IDP command
else
     no need for IDP command


Cheers
