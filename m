From: linux@horizon.com
Subject: Re: sata_sil24 corruption details
Date: 10 Nov 2005 21:16:16 -0500
Message-ID: <20051111021616.28929.qmail@science.horizon.com>
References: <4373843E.2030308@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:54057 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751242AbVKKCQX
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Nov 2005 21:16:23 -0500
In-Reply-To: <4373843E.2030308@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: axboe@suse.de, greg.freemyer@gmail.com, linux-ide@vger.kernel.org, linux@horizon.com

>>> * Ruling out disk problem
>>>        * Trying other harddisks.  All harddisk drives perform error
>>>          detection/correction when data are read from the media, but
>>>          ruling out the possibility would still be helpful.
>>>
>>> * If you have log of failed sectors, finding patterns will be helpful.
>>>  If the errors occur at random places, it's likely that we have
>>>  controller/driver issues.  If errors are localized over multiple runs,
>>>  maybe the disk is at fault.

Well, I've been an idiot.  My problems are NOT solved, but the problems
are isolated to one of the three controller cards (sdc and sdd), and
by doing all my testing through the RAID layer which spread out those
errors across all the different logical volumes, I wasn't seeing it.

Damn it, I had the mirrors carefully shared across controllers for better
tolerance to hard errors, and that meant that these silent errors
got into everything.

So I went whining for help before I applied elementary debugging logic
to the problem and now have to publicly apologize for suspecting the
software.

There will now follow a period of drive, cable, and controller swapping
while I figure out WTF is going on here.
