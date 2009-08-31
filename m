From: Tejun Heo <htejun@gmail.com>
Subject: Re: How to handle hotplug in case that host controller does not support
 hotplug via interrupt
Date: Mon, 31 Aug 2009 15:59:29 +0900
Message-ID: <4A9B74D1.9070604@gmail.com>
References: <516692.96886.qm@web84007.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f188.google.com ([209.85.211.188]:47704 "EHLO
	mail-yw0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527AbZHaG7g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Aug 2009 02:59:36 -0400
Received: by ywh26 with SMTP id 26so5714914ywh.5
        for <linux-ide@vger.kernel.org>; Sun, 30 Aug 2009 23:59:38 -0700 (PDT)
In-Reply-To: <516692.96886.qm@web84007.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jian Peng <jipeng@yahoo.com>
Cc: linux-ide@vger.kernel.org

Jian Peng wrote:
> Hi, Tejun,
> 
> In 2.6.30 and later, If I want to support hotplug, but host controller
> does not support hotplug via interrupt. The best way is to patch your
> hotplug polling patchset.
> I did not see this patch merged in mainline. Is there other new way to
> handle this type of hotplug now?

Hmmm... Unfortunately, no.  Now that most modern controllers support
proper hotplug the pressure for hotplug-by-polling is much lower, so
it kind of got dropped.

Thanks.

-- 
tejun
