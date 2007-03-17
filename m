From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Sat, 17 Mar 2007 11:09:55 +0900
Message-ID: <45FB4DF3.9080803@gmail.com>
References: <354573.23811.qm@web803.biz.mail.mud.yahoo.com>	<45F9851E.8000709@gmail.com> <20070315191639.7aadf9a3@lxorguk.ukuu.org.uk> <45F9A9A3.8050800@garzik.org> <45FA29C6.4070601@gmail.com> <45FAB604.5070801@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:40489 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933943AbXCQCKB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 22:10:01 -0400
Received: by wr-out-0506.google.com with SMTP id 41so738367wry
        for <linux-ide@vger.kernel.org>; Fri, 16 Mar 2007 19:10:00 -0700 (PDT)
In-Reply-To: <45FAB604.5070801@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bob Stewart <bob@evoria.net>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Oh well, I never got around to get the ADMA mode working.  The sunix
>> driver is TF/quasi-BMDMA based (w/o CONTROL register so I'm pretty sure
>> they have some problem with LBA48).  The docs[1] I have only have
>> register description and nothing about the programming model.  Me being
> 
> Does this missing reference "[1]" coincide with the docs list I posted
> yesterday?  Do you have all the docs I listed?

Yeap, I have...

Initio 1622.pdf and two others.  Those are all similar tho.

-- 
tejun
