From: Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH libata-dev-2.6] Issue INITIALIZE DEVICE PARAMETERS for
 CHS only devices
Date: Wed, 23 Feb 2005 09:48:33 -0500
Message-ID: <421C97C1.9090701@pobox.com>
References: <006d01c50c11$81003920$a801a8c0@tw.ibm.com> <42167CDD.50301@pobox.com> <421C6840.7090903@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:13192 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261258AbVBWOto
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Feb 2005 09:49:44 -0500
In-Reply-To: <421C6840.7090903@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>

 >This is the patch to issue INITIALIZE DEVICE PARAMETERS
 >for CHS only devices.

That comment is not accurate.  What the patch really does
is issue the IDP command for devices predating ATA-4,
regardless of whether they are CHS-only or not.

Correct behaviour, mind you.  Just the comment appeared misleading.

Oh, and what is the "major_version" variable based on?
I don't see it in 2.6.11-rc4, so it must be in the libata bk stuff.

For this usage to work, that variable has to be set from the
drive IDENTIFY data, but with a precautionary check for drives
(pre-ATA4) which may not set the version at all.  I'm guessing
this is already taken care of elsewhere in libata, right?

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

