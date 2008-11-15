From: Guntsche Michael <mike@it-loops.com>
Subject: Re: [PATCH #upstream-fixes 1/4] libata: fix device iteration bugs
Date: Sat, 15 Nov 2008 11:22:39 +0100
Message-ID: <9D800884-830E-4832-BB31-1B36E2882343@it-loops.com>
References: <6ca8fe89c868f95831328d31c27f9cdb@localhost> <1DE9BF42-39BB-4220-BDF0-62F14C854E77@it-loops.com> <4917DA12.8070307@kernel.org> <07a2f909b249db90ad6bfdddfdd17765@localhost> <49180B2E.6020604@kernel.org> <49184E1A.3010508@rtr.ca> <4918F1BC.2070602@kernel.org> <4919038B.8020407@rtr.ca> <49194E1C.9030800@ru.mvista.com> <3b5e4132a8abe8d67b4f1701a384a2d4@localhost> <491996D3.80805@rtr.ca> <4D5A0E9F-4931-449F-99F6-38C09C55983A@it-loops.com> <491A2F65.8030605@rtr.ca> <491A40AB.4070002@kernel.org> <90e002e7b2d47cad80ff952a2a81f0e7@localhost> <491A90BE.9030005@kernel.org> <1741f98465176fff86a1dda48fc965ac@localhost> <491AA18A.9090001@kernel.org> <fdc08450bd57b75c90440beab3d7534a@localhost> <491AA682.2000100@kernel.org> <f6c0b70008a38679e11dff42a0970c9c@localhost> <491CE4A6.90802@rtr.ca>
 <5595676605432696d80b8394cfd8ae83@localhost> <491DB3AB.7020306@rtr.ca> <491DB44A.5070701@rtr.ca> <C25CB239-E794-4183-9F9D-9AEFEC0FD77F@it-loops.com> <491E4C6B.6030309@rtr.ca> <491E4D62.7060205@rtr.ca>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lvps87-230-0-242.dedicated.hosteurope.de ([87.230.0.242]:59491
	"EHLO lvps87-230-0-242.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753847AbYKOKWo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Nov 2008 05:22:44 -0500
In-Reply-To: <491E4D62.7060205@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <tj@kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>


On Nov 15, 2008, at 5:17, Mark Lord wrote:

> Mark Lord wrote:
>> Which is odd, because google tells me that
>> the IC35L040AVER07-0 really is a 40GB drive.
>> Mmm..

I found the problem Mark and I am SOOOOOO sorry for wasting your time  
here.
Your remark about the drive being 40GB made me think about it again.  
As you know this is a quite old router that's running here.
When moving to 2.6 I also replaced the IBM disk with a new one (had  
several of them lying around back then).
The first one was CLAMPED with ibmsetmax. During the install of the  
new harddisk I clamped the new one with the JUMPERS on the DRIVE ond  
not with ibmsetmax.
I know remember that back then I thought that this would easier and  
more hassle free.
The libata stack, hdparm and everything else is working correctly it's  
the drive that's reporting 32GB!!!!!!!

Once again sorry for troubling you (all) with this non-issue.


Kind regards,
Michael
