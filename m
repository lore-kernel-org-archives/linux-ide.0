From: Andy Helten <andy.helten@dot21rts.com>
Subject: SATA hotplug status (sii3114) -- 2.6 kernel
Date: Thu, 02 Feb 2006 18:01:07 -0600
Message-ID: <43E29D43.1070800@dot21rts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from centrmmtao02.cox.net ([70.168.83.82]:34003 "EHLO
	centrmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932497AbWBCABQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Feb 2006 19:01:16 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I asked about the status of SATA hotplug about one year ago for the 2.4 
kernel.  I am now moving onto the 2.6 kernel and was wondering if anyone 
can give me an update.  I see the list traffic in Oct and Dec of 2005 
related to Lukasz Kosewski's work, but lost the trail after that.  I 
understand it is actively being developed and that there may be 
something in the "upstream" branch of libata that kind of supports hotplug.

If so, how do I get the upstream branch of libata?  I did the below and 
got something but not sure what:

cg-clone git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git

I tried getting it from here, but this server required a password:

master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

If the latest hotplug changes are not in the source repo, where are they 
(I'm guessing the mailing list)?  I specifically would like to target 
the 2.6.9 kernel in RedHat EL4, but would be willing to work with 
something newer if necessary.  For what it's worth, I did get hotplug 
working in the 2.4.25 kernel for the SII3114.

Thanks,
Andy

