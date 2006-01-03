From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Happy New Year, libata hackers
Date: Tue, 03 Jan 2006 13:53:22 -0500
Message-ID: <43BAC822.6090501@pobox.com>
References: <43BAB977.3010203@pobox.com> <20060103183328.GW2772@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:7570 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932478AbWACSx2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jan 2006 13:53:28 -0500
In-Reply-To: <20060103183328.GW2772@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Jens Axboe wrote:
> On Tue, Jan 03 2006, Jeff Garzik wrote:
> 
>>Port multiplier and NCQ (queueing) support are the two other big to-do 
>>items on the list.
> 
> 
> I'll get NCQ updated and tested again in the not-so-distant future.

FWIW I've kept it moderately up-to-date in the 'ncq' branch.  It's 
definitely moldy, with a few FIXMEs in libata-scsi's read/write 
translation, for example, which is missing the NCQ portion of that code.

	Jeff



