From: Mark Lord <liml@rtr.ca>
Subject: Re: TASKFILE ioctl for libata?
Date: Wed, 15 Feb 2006 14:00:46 -0500
Message-ID: <43F37A5E.1090301@rtr.ca>
References: <20060215143439.GA17850@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:5614 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750891AbWBOTAr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 14:00:47 -0500
In-Reply-To: <20060215143439.GA17850@harddisk-recovery.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: linux-ide@vger.kernel.org

Erik Mouw wrote:
> Hi,
> 
> Hdparm (6.3) needs the TASKFILE ioctl for the ATA security feature set
> (security freeze, security unlock, etc.). I can't find it in Jeff's
> libata-dev tree, is there somebody already working on it? Or is there a
> workaround?
>

If that ioctl is missing in libata, then I'll have to convert hdparm
to use SGIO to submit ATA Passthru packets instead for libata devices.

That's on my TO-DO list, and rising more quickly to the top now, it seems.

Cheers
