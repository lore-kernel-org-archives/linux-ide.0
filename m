From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET 6/9] new EH implementation, take 2
Date: Thu, 27 Apr 2006 05:16:00 -0400
Message-ID: <44508BD0.7040401@pobox.com>
References: <11447633013561-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:27043 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964998AbWD0JQI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Apr 2006 05:16:08 -0400
In-Reply-To: <11447633013561-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org


General comment:

My general feeling as I read these patchsets is that the patches are a 
bit /too/ split up.

I know its largely a judgement call, but don't be afraid to submit 
larger patches, particularly for new features like NCQ.  The several 
patches are highly interdependent, and they are introducing new code, 
might as well just lump them together.  Following the "one logical 
change per patch" rule doesn't have to mean "add one new function per patch"

	Jeff



