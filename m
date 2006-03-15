From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Warning - Maxtor SATA II and Nvidia nforce4
Date: Wed, 15 Mar 2006 17:47:10 -0500
Message-ID: <4418996E.6010808@garzik.org>
References: <1142461887.2521.44.camel@station14.example.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:34955 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751656AbWCOWrT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Mar 2006 17:47:19 -0500
In-Reply-To: <1142461887.2521.44.camel@station14.example.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dax Kelson <dax@gurulabs.com>
Cc: linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>


Ah, I see this made it to LKML :)

Dax Kelson wrote:
> Short version
> ==============
> Nvidia Nforce4 chipset with Maxtor SATA II drives with certain firmware
> revisions cause data corruption and system instability when under
> moderate to heavy I/O load.

I'm a bit suspicious of this.

Looking at the link, there are three problem areas and two problem blame 
targets implied:

	Data corruption	-> blame nvidia driver
	NCQ		-> blame nvidia driver
	Detection	-> blame maxtor firmware

The first one likely applies to the Windows driver not Linux's sata_nv, 
and thus irrelevant here.  The second one OBVIOUSLY applies only to 
Windows, since sata_nv (and libata itself) don't yet enable NCQ.  The 
third one could potentially apply to Linux.  Lastly, your mention of 
"nforce fake raid" almost certainly indicates Windows or proprietary 
drivers.

Therefore, I ask:
* are you reporting a only drive detection problem?
* why are you reporting unrelated Windows problems to a Linux list?
* if you are indeed reporting a problem on Linux, where is the kernel 
and driver version info, as requested in REPORTING-BUGS?
* and can you provide such info *and reproduce the problems* without 
proprietary drivers loaded?

Your email is just a list of highly general symptoms.  Your link seems 
to indicate two NV driver bugs on Windows, and a Maxtor firmware upgrade 
for undescribed detection problems.

My recommended action for users is:
1) Avoid Windows.
2) Don't panic.

	Jeff


