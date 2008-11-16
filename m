From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes 1/4] libata: fix device iteration bugs
Date: Sun, 16 Nov 2008 14:14:27 +0900
Message-ID: <491FAC33.9080902@kernel.org>
References: <6ca8fe89c868f95831328d31c27f9cdb@localhost> <07a2f909b249db90ad6bfdddfdd17765@localhost> <49180B2E.6020604@kernel.org> <49184E1A.3010508@rtr.ca> <4918F1BC.2070602@kernel.org> <4919038B.8020407@rtr.ca> <49194E1C.9030800@ru.mvista.com> <3b5e4132a8abe8d67b4f1701a384a2d4@localhost> <491996D3.80805@rtr.ca> <4D5A0E9F-4931-449F-99F6-38C09C55983A@it-loops.com> <491A2F65.8030605@rtr.ca> <491A40AB.4070002@kernel.org> <90e002e7b2d47cad80ff952a2a81f0e7@localhost> <491A90BE.9030005@kernel.org> <1741f98465176fff86a1dda48fc965ac@localhost> <491AA18A.9090001@kernel.org> <fdc08450bd57b75c90440beab3d7534a@localhost> <491AA682.2000100@kernel.org> <f6c0b70008a38679e11dff42a0970c9c@localhost> <491CE4A6.90802@rtr.ca> <5595676605432696d80b8394cfd8ae83@localhost> <491DB3AB.7020306@rtr.ca> <491DB44A.5
 070701@rtr.ca> <C25CB239-E794-4183-9F9D-9AEFEC0FD77F@it-loops.com> <491E4C6B.6030309@rtr.ca> <491E4D62.7060205@rtr.ca> <9D800884-830E-4832-BB31-1B36E2882343@it-loops.com> <491F3474.2070801@r
 tr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48266 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbYKPFOk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2008 00:14:40 -0500
In-Reply-To: <491F3474.2070801@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Guntsche Michael <mike@it-loops.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>

Mark Lord wrote:
>> The libata stack, hdparm and everything else is working correctly it's
>> the drive that's reporting 32GB!!!!!!!
> ..
> 
> Ahh.. that's better.  Thanks for figuring this one out for us all!

So, the only real bug here is ata_piix not returning HOB registers?
That's weird.  It's ata_piix.  It's not likely to be broken.  :-(

-- 
tejun
