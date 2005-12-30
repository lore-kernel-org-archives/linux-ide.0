From: "Dave Kelly" <dave@ravelox.co.uk>
Subject: Re: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
Date: Fri, 30 Dec 2005 10:44:31 -0800
Message-ID: <43B5800F.5020102@ravelox.co.uk>
References: <435994C2.6090701@ravelox.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:64173 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751277AbVL3Soy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Dec 2005 13:44:54 -0500
Received: from ravelox.co.uk (localhost.localdomain [127.0.0.1])
	by ravelox.co.uk (8.13.1/8.13.1) with ESMTP id jBUIiaK1003379
	for <linux-ide@vger.kernel.org>; Fri, 30 Dec 2005 10:44:36 -0800
Received: from ravelox.co.uk (root@localhost)
	by ravelox.co.uk (8.13.1/8.13.1/Submit) with ESMTP id jBUIiZOB003376
	for <linux-ide@vger.kernel.org>; Fri, 30 Dec 2005 10:44:36 -0800
In-Reply-To: <4359DD1F.9010507@gmx.de>
References: <4359DD1F.9010507@gmx.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

thomas schorpp wrote:

>Dave Kelly wrote:
>  
>
>>Hi,
>>
>>I originally sent this to linux-kernel but it may have got lost in the
>>number of messages.
>>
>>I have a large number of CD-Rs that I burned using Nero under Windows on
>>a CD writer that I no longer have ( and can't remember the model ). I'm
>>now having problems reading them with my Sony DRU-810A DVD+/-RW drive
>>using 2.6.13.4.
>>    
>>
>
>forget 2.6.13.4, wait for patches, it has countless bugs. complain about
>reading? try to burn something... kde+k3b lock up for 5 min. intervalls
>with cdrecord/cdrdao as root at full load with ide-cd. will test
>ide-scsi next, depreceated or not.
>  
>
I'm now using 2.6.15-rc7 and the problems still occur.

I'm happy to provide any information that people ask for but my
knowledge of debugging anything like this is non-existant so I'm looking
for assistance.
As I noted in my original message, I am able to read the same CD in the
same drive on the machine under Windows so I'd be grateful if anyone
could tell me how I can determine if Windows is being too lenient with
the disc or Linux is being too tough.

Cheers

Dave
