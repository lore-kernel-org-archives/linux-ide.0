From: Mark Lord <liml@rtr.ca>
Subject: Re: [RFT] major libata update
Date: Mon, 15 May 2006 15:33:11 -0400
Message-ID: <4468D777.6080408@rtr.ca>
References: <20060515170006.GA29555@havoc.gtf.org> <20060515101831.0e38d131.akpm@osdl.org> <4468C33F.7070905@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:47553 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751494AbWEOTdM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 15:33:12 -0400
In-Reply-To: <4468C33F.7070905@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

Jeff Garzik wrote:
> Andrew Morton wrote:
..
>> http://bugzilla.kernel.org/show_bug.cgi?id=5586
> 
> sata_mv still considered highly experimental, as noted in Kconfig.  Bugs 
> deferred to Mark Lord.
..
I think that particular bug has gone away with my internal sata_mv.c version.
I'm updating it for release on top of Jeff/Tejun's patch set, and will likely
backport the bugfixes to 2.6.16.xx as well.  Timeline, this week or next.

Cheers 
