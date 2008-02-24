From: "Gabor FUNK" <FUNK.Gabor@hunetkft.hu>
Subject: Re: JMicron - hard resetting link
Date: Sun, 24 Feb 2008 10:04:14 +0100
Message-ID: <002301c876c4$3ace8620$4d0fa8c0@M2007>
References: <009401c86d5c$5eb57bf0$4d0fa8c0@M2007> <47B19997.1010404@gmail.com> <003801c86d84$fdae0510$4d0fa8c0@M2007> <47B1B299.3010208@gmail.com> <002f01c86d9c$94542f50$4d0fa8c0@M2007> <47B230CA.9060506@gmail.com> <005c01c86f5d$b050b4e0$4d0fa8c0@M2007> <47B4CF71.5070408@gmail.com> <008901c874d3$10731c80$4d0fa8c0@M2007> <47BE2D6A.6060603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-2";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.huweb.hu ([62.112.193.37]:44523 "EHLO ns1.huweb.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752296AbYBXJE2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Feb 2008 04:04:28 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

>> Since it is not a "switch on and see" problem, I'm not in too good
>> position, so unless someone have a really great idea or observation,
>> I seriously have to consider to replace the MB and probably add
>> some extra sata controllers.
> 
> If you can still do some testing, what happens if you unplug power to
> the failed drive and replug it while the system is still running?  Does
> hotplug event get triggered and the drive gets recognized again?  If so,
> does unplugging and replugging the SATA controller only (w/o powering
> down the drive) achieve the same thing?

I doubt I will start another week of testing without any major changes,
I didn't do drive hotplug, but as for the controllers, they're are all on-
board ones...

I guess new (and different) motherboard and sata controllers cards will
be the next thing to change, 'cause I strongly believe that PSU-s are fine
and should be enough for the system.

G.
