From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] [libata] sata_mv: Remove PCI dependency
Date: Tue, 29 Jan 2008 12:12:48 -0500
Message-ID: <479F5E90.4030101@garzik.org>
References: <11966101971581-git-send-email-saeed.bishara@gmail.com>	 <1196610199229-git-send-email-saeed.bishara@gmail.com>	 <47684270.5030405@garzik.org>	 <c70ff3ad0712250842n5c5383b1x2f53406fbf34dfb5@mail.gmail.com>	 <478DD615.1050309@garzik.org>	 <c70ff3ad0801160817o28855b9byc6d314cef5a0d460@mail.gmail.com>	 <478E5479.8070505@rtr.ca> <c70ff3ad0801170624l32d91cd6v5adde66a296b7272@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45493 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756518AbYA2RMu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Jan 2008 12:12:50 -0500
In-Reply-To: <c70ff3ad0801170624l32d91cd6v5adde66a296b7272@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>

saeed bishara wrote:
> On 1/16/08, Mark Lord <liml@rtr.ca> wrote:
>> saeed bishara wrote:
>>> I attached the new patch
>> ..
>>
>> Try again, please.
>> This time, post the patch *inline* in the body of the email,
>> so that it can more easily be seen, read, and commented on.
>>
>> Beware of many email clients that mangle inline patches, though.
>>
>> Cheers
>>
> Here is the same patch inlined:
>>From c5f5af7f2eed2fe42e28374257b983922dfd3db5 Mon Sep 17 00:00:00 2001
> From: Saeed Bishara <saeed@marvell.com>
> Date: Sun, 2 Dec 2007 10:43:10 +0200
> Subject: [PATCH] sata_mv: Remove PCI dependency
> 
> The integrated SATA controller is connected directly to the SoC's
> internal bus, not via PCI interface. this patch removes the dependency
> on the PCI interface.
> 
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> ---
>  drivers/ata/Kconfig   |    2 +-
>  drivers/ata/sata_mv.c |  131 +++++++++++++++++++++++++++---------------------
>  2 files changed, 75 insertions(+), 58 deletions(-)

ACK the changes; but both git-am(1) and patch(1) report that this is a 
corrupt patch.  patch(1) says,


[jgarzik@pretzel libata-dev]$ patch -sp1 < /g/tmp/mbox
patch: **** malformed patch at line 151: *hpriv, int idx,



(patch is generally more forgiving than git-am)


