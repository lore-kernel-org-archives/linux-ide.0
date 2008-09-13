From: Bruce Allen <ballen@gravity.phys.uwm.edu>
Subject: Re: regarding crazy head unloads
Date: Sat, 13 Sep 2008 06:44:09 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0809130635260.26283@gc.phys.uwm.edu>
References: <48361F88.7040400@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gc.phys.uwm.edu ([129.89.61.147]:49279 "EHLO gc.phys.uwm.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752498AbYIMMut (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Sep 2008 08:50:49 -0400
In-Reply-To: <48361F88.7040400@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: roland.kletzing@materna.de, Smartmontools Developers List <smartmontools-devel@lists.sourceforge.net>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, scott@ubuntu.com

Hi Tejun,

Sorry, this is a really really slow reply.  This email came at an 
unusually busy time and I did not reply before it got buried in the 
deluge.

> 2. This is from Roland.  Make smartd aware of the problem and warn user
>    if load/unload count per powered on hours goes too high.  Maybe the
>    warning can direct the user to linux-ata.org page?

It would be easy to implement this in smartd.  But I'm concerned about 
three things:

   -- most people don't run smartd (I think by default it is off on
      the main Linux distros).  Those wise enough to run smartd will
      probably be aware of the issue, since it's gotten lots of buzz. And
      even if smartd is turned on in the distro it is normally not
      configured to send warning emails.

   -- I'm not sure if the attribute used for head load/unload is a standard
      one.  On my current laptop Hitachi disk it is attribute 193.  Does
      anyone know if this is standard?

   -- I'm not sure at what threshold to send warning emails.  If we send
      too many false alarms, they will be ignored by users.

Let me know if you have suggestions or comments about these points.

Cheers,
     Bruce
