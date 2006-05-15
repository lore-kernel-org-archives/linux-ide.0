From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 06/11] libata-eh: implement BMDMA EH
Date: Mon, 15 May 2006 22:59:42 +0900
Message-ID: <4468894E.6000004@gmail.com>
References: <1147353687173-git-send-email-htejun@gmail.com>	 <44665BEE.5020903@pobox.com>  <44666EA8.6050201@gmail.com> <1147700280.26686.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:19887 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964915AbWEON7u (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 09:59:50 -0400
Received: by wr-out-0506.google.com with SMTP id i12so1107462wra
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 06:59:50 -0700 (PDT)
In-Reply-To: <1147700280.26686.9.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Sul, 2006-05-14 at 08:41 +0900, Tejun Heo wrote: 
>> else is lost.  Also, please note that most traditional IDE controllers 
>> tend to have their own IRQ.
> 
> Not really. You normally have one IRQ per controller for any plug in
> card and that is quite often shared.
> 

I see.  But even with the shared IRQ, unconditionally clearing IRQ for
short duration wouldn't cause much problem, would it?

@ Out of curiosity, how old does a controller have to be to not have the
ctl shadow register?

-- 
tejun
