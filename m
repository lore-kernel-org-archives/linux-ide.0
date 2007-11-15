From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_mv: hard resetting port
Date: Thu, 15 Nov 2007 12:36:59 +0900
Message-ID: <473BBEDB.80000@gmail.com>
References: <473AC34B.8000709@wpkg.org> <473B13D6.3080202@rtr.ca> <473B1617.4010102@wpkg.org> <473B1E39.8090800@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:53760 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434AbXKODhF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 22:37:05 -0500
Received: by wa-out-1112.google.com with SMTP id v27so478686wah
        for <linux-ide@vger.kernel.org>; Wed, 14 Nov 2007 19:37:04 -0800 (PST)
In-Reply-To: <473B1E39.8090800@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tomasz Chmielewski <mangoo@wpkg.org>, Linux IDE <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tomasz Chmielewski wrote:
>> Is there an online Kernelish-English dictionary anywhere? ;)
> ..
> 
> Unfortunately not.
> 
> At some point, we *really* need to convice {Tejun,Jeff} that libata
> messages should be simpler, fewer, and more human readable by default,
> with perhaps a sysfs flag to re-enable the {Tejun,Jeff}-speak versions.

Ummm... Okay.  That might have something to do with me not being a
native speaker.  :-)

I agree that the current message looks too scary and detailed.  Yeah,
essages for recovered errors can be shorter and sweeter.  Those messages
are pretty helpful to developers tho.  Always having duplicate SCSI
messages don't help either.

Thanks.  I'm putting it on the todo list but I have to admit it is of
low priority ATM.

-- 
tejun
