From: David Greaves <david@dgreaves.com>
Subject: Re: good drive / bad drive  (maxtor topic)
Date: Wed, 24 Nov 2004 22:27:48 +0000
Message-ID: <41A50AE4.6040305@dgreaves.com>
References: <02e101c4d24c$2937d990$4500a8c0@MarkK>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s2.ukfsn.org ([217.158.120.143]:59014 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262900AbUKYBn4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Nov 2004 20:43:56 -0500
In-Reply-To: <02e101c4d24c$2937d990$4500a8c0@MarkK>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Klarzynski <mark.k@computer-design.co.uk>
Cc: linux-ide@vger.kernel.org

Well, I don't class a drive as failed unless it fails the drive 
manufacturers test suite.

One other problem with Maxtor is that the test application needs DOS and 
won't run on VIA or Silicon Image motherboard controllers - so you'd 
better have a test rig with a decent SATA controller in just waiting to 
test failed Maxtors ;)

Last time it failed and had an obvious write problem so I just sent it back.
Next time I'll see about creating a boot-cd with freedos and the maxtor 
test app.

I have now got 6 Maxtor drives in my array - one failed and was accepted 
as faulty by the vendor and replaced.
Another threw a fault that hasn't recurred. Maybe it remapped a block 
noisily? Maybe it was a timeout?
It was inconvenient because you go into a 'fragile' mode. Now of course 
I have a hot spare - but I'm wondering about raid6.

As for enterprise raid - have you seen EVMS recently?
I installed and configured it but reverted to raw md/lvm2 after:
* dm bbr claimed that I had 320 bad blocks on *all* my disks - hmmm
* the lvm2 manager wouldn't _quite_ build properly so I had to do it 
manually
* the raid5 manager wouldn't let me create a degraded array (which I 
needed to do)

And I have enough stability issues without another 'almost there' component.

It's looking damned good though.

sorry for wandering a bit OT :)

David

Mark Klarzynski wrote:

>In the world of hardware raid we decide that a drive has failed based on
>various criteria, one of which is the obvious 'has the drive responded'
>within a set time.  This set time various depending on the drive, the
>application, the load etc.  This 'timeout' value is realistically
>between 6 and 10 seconds.  There is no real formula, just lots of
>experience. Set it too short and drives will look failed too often, set
>it too long and you risk allowing a suspect drive to continue.
>
>Once we detect a timeout we have to decide what to with it. in SCSI we
>issue a scsi bus rest (hardware reset on the bus).. the reason we do
>this (and all hardware raid manufactures) is because life is just that
>way. drives do lock up.   We issue up to 3 resets, and then fail.  This
>is extremely effective and does exactly what it is supposed to do.
>Often the drive will never cause an issue again. if it is faulty then it
>will escalate and fail.
>
>We have utilised countless sata drives, and timeouts are by far the most
>significant failure we see and as sata (although its hard to tell much
>else on sata).. but it is therefore imperative that the timeout values
>are correct for the drive and the application.
>
>But the point is that we do not see anywhere near the failure rates on
>the Maxtor's that you guys are mentioning.  Also, if we trial sata's on
>different hardware RAID's we see differing failure rates... (i.e. ICP
>come in higher then 3ware, which are higher than the host independent
>raids we have tested and so on)
>
>So I am wondering if it is worth thinking about the timeout values?  And
>what do you do once the drive has timed out?
>
>I am seeing some tremendous work going on in this group and without a
>doubt this community is going to propel MD to enterprise level raid one
>day. so this is honestly meant as constructive and is based on way too
>many years designing raid solutions. i.e. I'm not looking to start an
>argument simply offering some information.
>
>
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>  
>

