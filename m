From: Tejun Heo <htejun@gmail.com>
Subject: Re: regarding crazy head unloads
Date: Tue, 30 Sep 2008 14:36:16 +0900
Message-ID: <48E1BAD0.5040608@gmail.com>
References: <48361F88.7040400@gmail.com> <Pine.LNX.4.64.0809130635260.26283@gc.phys.uwm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:18642 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbYI3FiB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Sep 2008 01:38:01 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1090309tic.23
        for <linux-ide@vger.kernel.org>; Mon, 29 Sep 2008 22:37:59 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0809130635260.26283@gc.phys.uwm.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: roland.kletzing@materna.de, Smartmontools Developers List <smartmontools-devel@lists.sourceforge.net>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, scott@ubuntu.com

Bruce Allen wrote:
> Hi Tejun,
> 
> Sorry, this is a really really slow reply.  This email came at an
> unusually busy time and I did not reply before it got buried in the deluge.

Well, you were slow but I'm slower.  :-)

>> 2. This is from Roland.  Make smartd aware of the problem and warn user
>>    if load/unload count per powered on hours goes too high.  Maybe the
>>    warning can direct the user to linux-ata.org page?
> 
> It would be easy to implement this in smartd.  But I'm concerned about
> three things:
> 
>   -- most people don't run smartd (I think by default it is off on
>      the main Linux distros).  Those wise enough to run smartd will
>      probably be aware of the issue, since it's gotten lots of buzz. And
>      even if smartd is turned on in the distro it is normally not
>      configured to send warning emails.

We only have to hit one instance of each configuration where such
problem is occurring.  I think adding warning message out smartctl
output or letting smartd warn it to users via email or log messages
should be good enough for this problem.

>   -- I'm not sure if the attribute used for head load/unload is a standard
>      one.  On my current laptop Hitachi disk it is attribute 193.  Does
>      anyone know if this is standard?

I have no idea whatsoever.  Maybe implement a regexp matching on
attribute name?

>   -- I'm not sure at what threshold to send warning emails.  If we send
>      too many false alarms, they will be ignored by users.

To get it correct completely, I think we'll need per-device database.
Not easy....  :-(

Thanks.

-- 
tejun
