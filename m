From: Marty <martyb@ix.netcom.com>
Subject: Re: possible ATA hang in 2.6.32-rc6
Date: Wed, 11 Nov 2009 08:04:49 -0500
Message-ID: <4AFAB671.9060908@ix.netcom.com>
References: <4AF5ADA3.3070000@ix.netcom.com> <4AF7E20A.20005@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-masked.atl.sa.earthlink.net ([209.86.89.68]:47817 "EHLO
	elasmtp-masked.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751405AbZKKNEx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Nov 2009 08:04:53 -0500
In-Reply-To: <4AF7E20A.20005@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, User discussion about IVTV <ivtv-users@ivtvdriver.org>

Tejun Heo wrote:
> Hello, Marty.
> 
> Marty wrote:
>> I got two hard hangs in 2.6.32-rc5 and rc6 in an Asrock A780GXE/128M
>> with AMD 780G+SB700 chipsets, resulting in no response to magic alt-sysreq.
>> The first hang left no log clues.  The second was closely but not
>> immediately preceeded by syslog ATA error messages (see excerpt).
> The ata error messages indicate transmission problems.  The fact that
...

> they're pretty close to each other is interesting and seems to point
> to hardware problem (most likely power fluctuation).

Thanks for the reply.  I think you are right about power. Subsequent
hangs seem to indicate a problem with the mains.  In the last hang,
the (offline) UPS briefly switched to battery, and another system has
had the same problem.

