From: "Gabor FUNK" <FUNK.Gabor@hunetkft.hu>
Subject: Re: JMicron - hard resetting link
Date: Thu, 21 Feb 2008 22:45:20 +0100
Message-ID: <008901c874d3$10731c80$4d0fa8c0@M2007>
References: <009401c86d5c$5eb57bf0$4d0fa8c0@M2007> <47B19997.1010404@gmail.com> <003801c86d84$fdae0510$4d0fa8c0@M2007> <47B1B299.3010208@gmail.com> <002f01c86d9c$94542f50$4d0fa8c0@M2007> <47B230CA.9060506@gmail.com> <005c01c86f5d$b050b4e0$4d0fa8c0@M2007> <47B4CF71.5070408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-2";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.huweb.hu ([62.112.193.37]:45939 "EHLO ns1.huweb.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761295AbYBUVp3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Feb 2008 16:45:29 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

>> So a different brand PSU was additionally installed, and this
>> one got the motherboard and the 4 disk which were failing.
>> The "old" PSU got the second 4 hdds and the 2 other system
>> HDDs.
>> Test was started yesterday (Feb 13) about 16:30 CET including
>> array building up and file copies. About today (14) 20:22 the
>> problem appeared, but seemingly "moved" with the PSU to the
>> other 4 disks bunch (on nvidia controller) - more precisely, only
>> 2 of them (array is still operational).
> 
> Hmmm..
> 
>> So it seems that there is definitely something with the "old" PSU.
>> 
>> Also, I tried to mount the failed drives, without success.
>> 
>> Thought I let you know.
>> Now I will try with the only one, "new" PSU to see what happens...
> 
> Yeah, please keep us posted.  Thanks.

To sum it up:
- 1st the 4 disks on the Jmicron controller failed with 1 [chieftek] PSU
- then it failed with 2 PSU too, but this time the chieftek was only
   connected to the different 4 disks - on the nvidia controller. MB
   and other disks were on the other, non-chieftek [650W] PSU.
- Then I started the tests with only this second PSU, and it ran
   for about 6 days under heavy testing and array rebuilding and
   guess what: it failed again.

Full kernel log at:
http://www.huweb.hu/maques/tmp/jmicron/kern0221.log

Since it is not a "switch on and see" problem, I'm not in too good
position, so unless someone have a really great idea or observation,
I seriously have to consider to replace the MB and probably add
some extra sata controllers.

Thanks, G.
