From: Ellis <linux@paranor.org.uk>
Subject: Re: Problem with SiI 3112 SATA Controller/Driver ?
Date: Wed, 12 Jul 2006 23:04:06 +0100
Message-ID: <44B571D6.9070504@paranor.org.uk>
References: <44B41C25.6030209@paranor.org.uk> <44B51F77.5080607@gmail.com>
Reply-To: linux@paranor.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hermes.hosts.co.uk ([212.84.175.24]:28835 "EHLO
	hermes.hosts.co.uk") by vger.kernel.org with ESMTP id S932456AbWGLWAU
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Jul 2006 18:00:20 -0400
In-Reply-To: <44B51F77.5080607@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> 
> Can you try the following patch?
> 

Patched, re-compiled kernel, and it works fine (on my machine anyway) 
... WOOT! WOOT! Thanks a bunch!!

I'm planning on leaving the patch installed in spite of the warning in 
the readme file :^P - so I'll keep you posted if there are any problems.

As an aside, the boot process appears crisper with less time 
interrogating the hdd hardware ... might be my eagerness in seeing it 
working though. All detected OK too. The disk has been formatted several 
times without "hanging" the tty.

If I can ever help please drop a line as a few machines (sacrificial 
lambs) here if testing to be done.


-- 
Thanks and regards
Ellis

Ellis Skinazi - mailto: linux@paranor.org.uk


