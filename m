From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: hardreset on SERR_INTERNAL
Date: Wed, 14 Mar 2007 20:50:31 +0900
Message-ID: <45F7E187.7040306@gmail.com>
References: <20070313162051.GH32687@htj.dyndns.org> <45F7C0B6.4010205@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.227]:49178 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161162AbXCNLug (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Mar 2007 07:50:36 -0400
Received: by wx-out-0506.google.com with SMTP id h31so141761wxd
        for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 04:50:35 -0700 (PDT)
In-Reply-To: <45F7C0B6.4010205@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> There was a rare report where SB600 reported SERR_INTERNAL and SRST
>> couldn't get it out of the failure mode.  Hardreset on SERR_INTERNAL.
>> As the problem is intermittent, whether this fixes the problem or not
>> hasn't been verified yet, but hardresetting the channel on internal
>> error is a good idea anyway.
> 
> How does this interact with the patch ATI just posted, which prefers to
> treat the SB600 SERR_INTERNAL differently?

Gee... That looks like the correct fix.  Raising SERR_INTERNAL on ATAPI
CC never occurred to me.  I still think hardresetting on SERR_INTERNAL
is better than softresetting tho.

-- 
tejun
