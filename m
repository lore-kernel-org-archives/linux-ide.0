From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
Date: Tue, 15 Nov 2005 22:43:19 +0900
Message-ID: <4379E5F7.6000107@gmail.com>
References: <20051114195717.GA24373@havoc.gtf.org> <20051115074148.GA17459@htj.dyndns.org> <4379AA5B.1060900@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:19370 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932505AbVKONne (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Nov 2005 08:43:34 -0500
Received: by zproxy.gmail.com with SMTP id 13so1496782nzn
        for <linux-ide@vger.kernel.org>; Tue, 15 Nov 2005 05:43:33 -0800 (PST)
In-Reply-To: <4379AA5B.1060900@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

Jeff Garzik wrote:
> 
> TUR fails for me, too.  It triggers the EH code, which is why I wound up 
> needing to fix it :)
> 
> Have you dumped the D2H FIS returned by the drive, when the TUR fails? 
> What does it look like?  What does the D2H FIS look like after REQUEST 
> SENSE?
> 
> I bet there is some "clear error" actions we need to take on sil24, 
> before it work there.
> 

Okay, I finally got my SATA dvd writer working and successfully mounted 
a debian cdrom (with some number of gloss hacks).  I had to do the 
following to get this thing to work.

* prb->fis doesn't contain proper signature after phy reset.  I just 
forced DEV_ATAPI as a temporary measure.  In the original sii driver 
where SRST is used instead of PHY RESET, my ATAPI drive registered 
correct signature but my harddisk's signature didn't show up.

* As all commands hang after failed TUR, which BTW fails rightfully with 
06h (UNIT ATTENTION due to prior reset) and then 02h's (NOT READY), I 
avoided TUR failures by issuing REQUEST SENSE first, which returns NO 
SENSE but does clear UA condition, and then waiting for more than 10secs 
to give the drive time to become ready.

* With above two changes, no command fails and I can mount the cdrom.

------------------

And here are things that I've found out so far....

* ATAPI commands without data (TEST_UNIT_READY, ALLOW_MEDIUM_REMOVAL...) 
work happily with any prb->ctrl flag (no flag, PRB_CTRL_PACKET_READ or 
PRB_CTRL_PACKET_WRITE).

* Currently, sil24_reset_controller() is called on every error interrupt 
to make sure the controller is ready for further operation. 
Unfortunately, the current reset_controller() seems to reset PHY too. 
The drive becomes NOT READY after reset_controller().  So, when TUR 
fails, it falls into TUR, fail with NOT READY, reset which makes the 
drive NOT READY again cycle.

* Wihtout sil24_reset_controller(), no further command can be issued. 
The controller doesn't seem to be operating normally after DEV_ERR.

--------------------

So, what we need to know to make sil24 work happily with ATAPI devices.

* How to get device signature on initialization.

* How to make the controller operational again after a DEV_ERR without 
affecting the attached device.

-- 
tejun
