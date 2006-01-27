From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 12/13] libata: create pio/atapi task queueing wrappers
Date: Thu, 26 Jan 2006 23:02:54 -0500
Message-ID: <43D99B6E.1090502@pobox.com>
References: <11379893773912-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:14522 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751033AbWA0EC5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 23:02:57 -0500
In-Reply-To: <11379893773912-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> Wrap pio/atapi task queueing in correspondingly named functions.  This
> change doesn't change anything.  It's preparation for follow-up
> pio-task/eh sync patch.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

I take back part of what the last email said:

I was able to successfully apply patch #12.

Patch #13 seems sane, but I would prefer to wait for resend on that one. 
  Haven't reviewed it in depth, just quick glance.

	Jeff



