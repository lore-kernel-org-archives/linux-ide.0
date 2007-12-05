From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Wed, 05 Dec 2007 10:14:56 +0900
Message-ID: <4755FB90.50505@gmail.com>
References: <1196346817387-git-send-email-htejun@gmail.com> <11963468202627-git-send-email-htejun@gmail.com> <4755ABB3.6030907@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:8784 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbXLEBPn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 20:15:43 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3392384rvb
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 17:15:39 -0800 (PST)
In-Reply-To: <4755ABB3.6030907@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

Jeff Garzik wrote:
> The other patches were OK, but I'm still not happy about "punishing the
> good guys"

Yeah, I know.  I guess you know my but-what's-the-actual-punishment
argument too by now.

This is about time we make decision on this.  If we're gonna go
DMA-for-everything way, we should lift 16 byte default masking for -mm
and -rc's as that only makes debugging difficult and try to blacklist
offending devices and controllers individually.

My primary concern is about not achieving enough test coverage and
isolated cases where it's difficult to tell whether it's the device or
the controller.  e.g. Loading recent distro on an ancient and/or strange
machine, scratching head while cursing and giving up.  Unfortunately,
I've seen similar things happening often enough (and I did so myself
more times than I'm proud of).  Only very small fraction of problems
actually reaches developers.

Thanks.

-- 
tejun
