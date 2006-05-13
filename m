From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 06/11] libata-eh: implement BMDMA EH
Date: Sun, 14 May 2006 08:41:28 +0900
Message-ID: <44666EA8.6050201@gmail.com>
References: <1147353687173-git-send-email-htejun@gmail.com> <44665BEE.5020903@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.202]:28131 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964810AbWEMXle (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 May 2006 19:41:34 -0400
Received: by wx-out-0102.google.com with SMTP id i29so345022wxd
        for <linux-ide@vger.kernel.org>; Sat, 13 May 2006 16:41:33 -0700 (PDT)
In-Reply-To: <44665BEE.5020903@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:

> 
> What's the plan for the class of PATA controllers without Device Control 
> shadow registers?
> 
> There are multiple examples of such in drivers/ide...
> 
> I ACK the patch's content, but don't forget we definitely need a plan 
> for PATA controllers without nIEN support.

I can't think of any solution other than ack'ing and clearing interrupts 
blindly while frozen.

* it only happens from the freezing point until the device/controller is 
reset.

* we can't detect spurious interrupts during that period but nothing 
else is lost.  Also, please note that most traditional IDE controllers 
tend to have their own IRQ.

-- 
tejun
