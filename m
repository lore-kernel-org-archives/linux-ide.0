From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.32 seemed to have broken nVidia MCP7A sata controller
Date: Sat, 19 Dec 2009 17:55:18 -0500
Message-ID: <4B2D59D6.30008@garzik.org>
References: <7c8826910912182213o2e0e8af7ic305f150c52e0618@mail.gmail.com>	 <4B2C80DD.9080005@garzik.org> <4B2D1CF3.4070106@gmail.com> <7c8826910912191437k4e1d93bap12874a6d6e0046d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:33930 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbZLSWzV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Dec 2009 17:55:21 -0500
In-Reply-To: <7c8826910912191437k4e1d93bap12874a6d6e0046d3@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Cui <cuicui@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 12/19/2009 05:37 PM, Mike Cui wrote:
> Thanks, changing that one line fixed it. I can try to find an intel
> motherboard sometime next week to see if it's the drive or the
> controller.
>
> On Sat, Dec 19, 2009 at 10:35 AM, Robert Hancock<hancockrwd@gmail.com>  wrote:
>> Mike, can you try and revert that patch, or else just change this line in
>> drivers/ata/ahci.c:
>>
>>                 pi.flags |= ATA_FLAG_NCQ | ATA_FLAG_FPDMA_AA;
>>
>> to
>>
>>                 pi.flags |= ATA_FLAG_NCQ;
>>
>> and rebuild and see if it works better?


Thanks for that confirmation.  And yeah, it would definitely help if we 
can narrow that down to either the drive or the controller.

	Jeff



