From: Stefan <gentoopower@yahoo.de>
Subject: Kernel 2.6.6 Bug !!!!
Date: Mon, 10 May 2004 13:17:11 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <409F64B7.6050906@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:29560 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264635AbUEJLK1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 May 2004 07:10:27 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Sorry for posting this to the ide list, but it is the only one I'm 
registered.

I just got the new kernel 2.6.6. It seems like there is a really bad bug 
in it.
The Nvidia driver and my soundcard driver (this one I wrote myself), 
don't work anymore.

When I try to load those modules I get:

Inavalid Module Format

Who should I contact in order to resolve this issue immidiately????

Tanks, R.S.

P.S. On OSNews I saw someone mentioning:


-mregparm=3 (register option) or 4 kb stacks

both aren't set in my kernel

Also I notived, both of the modules have a different name now in 2.6.5 
they were named:

cmaudio.ko
nvidia.o

now in 2.6.6

cmaudio.o
nvidia.ko

Was there a change in compile flags or such thing?
