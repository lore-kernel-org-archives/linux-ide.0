From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH libata-dev-2.6] Issue INITIALIZE DEVICE PARAMETERS for
 CHS only devices
Date: Thu, 24 Feb 2005 10:36:33 +0800
Message-ID: <421D3DB1.1090800@tw.ibm.com>
References: <006d01c50c11$81003920$a801a8c0@tw.ibm.com> <42167CDD.50301@pobox.com> <421C6840.7090903@tw.ibm.com> <421C97C1.9090701@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from bluehawaii.tikira.net ([61.62.22.51]:48100 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261767AbVBXChv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Feb 2005 21:37:51 -0500
In-Reply-To: <421C97C1.9090701@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>



Mark Lord wrote:
>  >This is the patch to issue INITIALIZE DEVICE PARAMETERS
>  >for CHS only devices.
> 
> That comment is not accurate.  What the patch really does
> is issue the IDP command for devices predating ATA-4,
> regardless of whether they are CHS-only or not.

   The Promise GPL'ed code does that, no matter whether the device supports LBA or not.
Nor checking the ATA major version, they just issue IDP to the device.

   However, it seems IDP is closely related to CHS. So in my patch, I just
issue it for the CHS-only (i.e. no LBA support) devices.

   If the device supports LBA, then IDP is not issued in my patch. Is this OK?

> 
> Oh, and what is the "major_version" variable based on?
> I don't see it in 2.6.11-rc4, so it must be in the libata bk stuff.

   The "major_version" is the "i" variable in the ata_dev_identify().
Renamed in the previous CHS patch for clarity.

> 
> For this usage to work, that variable has to be set from the
> drive IDENTIFY data, but with a precautionary check for drives
> (pre-ATA4) which may not set the version at all.  I'm guessing
> this is already taken care of elsewhere in libata, right?
> 

Yes, it is already taken care in libata. It is from the IDENTIFY data.
Tested with my 1995 Seagate drive, it reports ATA-0 for the major version on libata.
No problem reading/writing it. However, I have to remove the pre ATA-3 check code before testing it.

Best regards,
Albert


