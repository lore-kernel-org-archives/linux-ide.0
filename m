From: "Brian Rademacher" <rad@radfiles.net>
Subject: Re: [PATCH] sata_mv: fix timeouts on lower ports of 508x/6081 chips
Date: Fri, 16 Jan 2009 19:10:59 -0700
Message-ID: <A666BC21CBD54A26AA83459EB26EA4BA@909927SOSLA>
References: <496D04EB.3060803@rtr.ca> <496E53DD.6040408@gmail.com> <496E61E8.5010602@rtr.ca> <496E72D7.2070206@gmail.com> <496EA53F.7000605@rtr.ca> <496F34BF.5010701@ngs.ru> <4970BDC6.7020201@rtr.ca> <4970E958.1040800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=response
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qmta05.emeryville.ca.mail.comcast.net ([76.96.30.48]:41999 "EHLO
	QMTA05.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755617AbZAQCLK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Jan 2009 21:11:10 -0500
In-Reply-To: <4970E958.1040800@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harri Olin <harri.olin@gmail.com>, Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Artem Bokhan <aptem@ngs.ru>, Eamonn Hamilton <EAMONN.HAMILTON@saic.com>, stable@kernel.org

A little over 2 days here on 2.6.27 with no problems....

----- Original Message ----- 
From: "Harri Olin" <harri.olin@gmail.com>
To: "Mark Lord" <liml@rtr.ca>
Cc: "IDE/ATA development list" <linux-ide@vger.kernel.org>; "Jeff Garzik" 
<jgarzik@pobox.com>; "Artem Bokhan" <aptem@ngs.ru>; "Brian Rademacher" 
<rad@radfiles.net>; "Eamonn Hamilton" <EAMONN.HAMILTON@saic.com>; 
<stable@kernel.org>
Sent: Friday, January 16, 2009 1:08 PM
Subject: Re: [PATCH] sata_mv: fix timeouts on lower ports of 508x/6081 chips


> Mark Lord wrote:
>> Fix a longstanding bug for the 8-port Marvell Sata controllers 
>> (508x/6081),
>> where accesses to the upper 4 ports would cause lost-interrupts / 
>> timeouts
>> for the lower 4-ports.  With this patch, the 6081 boards should finally 
>> be
>> reliable enough for mainstream use with Linux.
>>
>> This patch is for 2.6.29, but should also get reviewed/released
>> for the -stable branches of 2.6.28, 2.6.27, and 2.6.26.
>>
>> Signed-off-by: Mark Lord <mlord@pobox.com>
>>
>
> After patching no timeouts have occurred for 22 hours on 2.6.28 and 24 
> hours on 2.6.27.6.
>
> Tested-by: Harri Olin <harri.olin@gmail.com>
>
> -- 
> Harri. 

