From: Mark Lord <liml@rtr.ca>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Wed, 01 Mar 2006 14:22:25 -0500
Message-ID: <4405F471.8000602@rtr.ca>
References: <1141239617.23202.5.camel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:37076 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751059AbWCATWJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2006 14:22:09 -0500
In-Reply-To: <1141239617.23202.5.camel@rousalka.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Cc: edmudama@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Nicolas Mailhot wrote:
>>
> How about the drives that got blacklisted following :
> http://bugzilla.kernel.org/show_bug.cgi?id=5914 ?
> and
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=177951 ?
> 
> Device Model:     Maxtor 6L300S0
> Firmware Version: BANC1G10
> 
> on Silicon Image, Inc. SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)

Mmm.. somebody with one of those controllers should check
to see if *any* drives work with FUA, and blacklist the controller
instead of the drives if everything is failing.

Cheers
