From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata-eh/pmp command sequence on NCQ media error
Date: Thu, 01 May 2008 11:54:35 +0900
Message-ID: <481930EB.30601@gmail.com>
References: <480F9D29.4070603@rtr.ca> <480FF229.2060808@rtr.ca> <481168FA.5020709@pobox.com> <4811E2FB.4040100@rtr.ca> <48120269.8020101@gmail.com> <4818E5B2.1040801@rtr.ca> <4818E73D.9070201@rtr.ca> <48191422.30409@gmail.com> <48192F60.1080303@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:26653 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236AbYEACys (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Apr 2008 22:54:48 -0400
Received: by wf-out-1314.google.com with SMTP id 28so661311wfc.4
        for <linux-ide@vger.kernel.org>; Wed, 30 Apr 2008 19:54:48 -0700 (PDT)
In-Reply-To: <48192F60.1080303@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Like a lot of those bits, I suppose we need to do the old telco tricks
> of keeping a rolling average versus time.  Too many counts of them
> in too short a period triggers remedial action, otherwise they're 
> tolerated.

Yeah, that's what the current EH does.  What I was suggesting was to set 
AC_ERR_ATA_BUS but not set ATA_EH_RESET.  Hmmm... We'll probably need to 
add another class of errors.  AC_ERR_ATA_BUS_SOFT or something.

Thanks.

-- 
tejun
