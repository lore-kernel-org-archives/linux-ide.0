From: Mark Lord <liml@rtr.ca>
Subject: Re: libata Intel PIIX/ICH fails to detect both PATA drives, spews
 ACPI errors
Date: Mon, 12 Mar 2007 21:53:27 -0400
Message-ID: <45F60417.2020502@rtr.ca>
References: <45705618.2020608@gmail.com> <45E447DD.9050308@gmail.com> <45F3F8AA.4060501@gmail.com> <45F4FCA3.1080301@gmail.com> <45F54147.1060509@gmail.com> <45F546C0.1030502@gmail.com> <45F5E4E6.7010600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3148 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753036AbXCMBx2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Mar 2007 21:53:28 -0400
In-Reply-To: <45F5E4E6.7010600@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Berck E. Nash" <flyboy@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

> It works!  I'm having trouble getting the hdparm info for you, it
> doesn't seem to like the libata interface?  Appears to be the newest
> version of hdparm (6.9).  Something I'm missing?
> 
> luna:~# hdparm -I /dev/sr0
> HDIO_DRIVE_CMD(identify) failed: Input/output error

Yes, well, Jeff has patches in his inbox to fix that in libata.

If you can apply patches and rebuild, then I could forward the
necessary code for you, and then you'll be able to do the "hdparm -I"
as well as other useful commands.

Cheers
