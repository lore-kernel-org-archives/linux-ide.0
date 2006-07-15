From: Sven Riedel <sr@gimp.org>
Subject: Re: Errors and resets using sata_promise and libata 1.20
Date: Sat, 15 Jul 2006 15:20:13 +0200
Message-ID: <20060715132012.GA18761@localnet>
References: <1152725383.23607.5637.camel@girvin.pmc-sierra.bc.ca> <44B7D4E4.4000607@rtr.ca> <20060715065001.GA11832@localnet> <44B8E8D6.8020903@rtr.ca>
Reply-To: sr@gimp.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kamp-dsl.de ([195.62.99.42]:13538 "HELO
	mailout.kamp-dsl.de") by vger.kernel.org with SMTP id S1946035AbWGONUR
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Jul 2006 09:20:17 -0400
Received: from dsl-mail.kamp.net (mail.kamp-dsl.de [195.62.99.42])
	by sponts.dsl-backup.kamp.de (SPONTS v6.3.6) with SMTP
	id 110C72582ABB-0
	for <linux-ide@vger.kernel.org>; Sat, 15 Jul 2006 13:20:16 +0000
Received: from mx01.kamp-dsl.de (mail.kamp-dsl.de [195.62.99.42])
	by sponts.dsl-backup.kamp.de (SPONTS v6.3.6) with ESMTP
	id 110C72582A1D-0
	for <linux-ide@vger.kernel.org>; Sat, 15 Jul 2006 13:20:15 +0000
Content-Disposition: inline
In-Reply-To: <44B8E8D6.8020903@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: sr@gimp.org, linux-ide@vger.kernel.org

> >Is there a patch somewhere that didn't make it into the kernel yet, that we
> >can try?
> 
> No.  And it's quite unfortunate, as this bug prevents proper error handling
> by the SCSI layer, since libata doesn't accurately report what problem it 
> saw.
> 

Ok. Well, since I can duplicate the exact same error here consistently, I'll
grab 2.6.18rc1 and report back if I can reproduce the error there or not.

Regs,
Sven

-- 
Sven Riedel                      sr@gimp.org
