From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [akpm@osdl.org: Re: 2.6.16 eating filesystems]
Date: Thu, 26 Jan 2006 12:05:19 -0500
Message-ID: <43D9014F.8090004@pobox.com>
References: <20060125185320.GL14225@havoc.gtf.org> <43D8373B.1070802@gmail.com> <20060126080544.GH4212@suse.de> <43D8FDA5.3000701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:52661 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932156AbWAZRFY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 12:05:24 -0500
In-Reply-To: <43D8FDA5.3000701@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, Nicolas.Mailhot@LaPoste.net, linux-ide@vger.kernel.org

Tejun wrote:
> Anyways, it's clear that we need to do something to prevent data 
> corruption on barrier failures.  Nicolas's case is just too scary.  It 
> should warn and turn off barrier, not corrupt whole fs.  Maybe we should 
> turn off libata FUA support until this issue is resolved?

If the problem can't be fixed in the short term, that's what we'll have 
to do.  Add a 'fua' module parameter or something.

	Jeff


