From: Tejun Heo <tj@kernel.org>
Subject: Re: Errors on ICH10R with Seagate HDDs
Date: Thu, 09 Apr 2009 11:09:38 -0700
Message-ID: <49DE39E2.7070505@kernel.org>
References: <49D4A232.3090504@hadiko.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56064 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754367AbZDISJI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Apr 2009 14:09:08 -0400
In-Reply-To: <49D4A232.3090504@hadiko.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Jackowski <aXe@hadiko.de>
Cc: linux-ide@vger.kernel.org

Hello,

Thomas Jackowski wrote:
> This is /dev/sdc. /dev/sdd and /dev/sde is the same model with the same
> Firmware. I'm using a RAID5 on these 3 HDDs.
> Because of the Seagate Firmware Bug I had to upgrade the firmware from
> 'SD15' to 'SD1A'. The upgrade was successful.
> 
> Before the upgrade there were no problems, after the upgrade I have
> trouble like this:
...
> [14144.875931] ata4.00: cmd ec/00:01:00:00:00/00:00:00:00:00/00 tag 0

Timeout on IDENTIFY.

> [507139.744602] ata5.00: cmd e5/00:00:00:00:00/00:00:00:00:00/00 tag 0
> [507453.049519] ata4.00: cmd e5/00:00:00:00:00/00:00:00:00:00/00 tag 0

and two timeouts on CHK_POWER.

ahci, right?  Given that the problem appeared after firmware update,
it seems to indicate firmware problem.  Does libata.force=noncq make
any difference?

-- 
tejun
