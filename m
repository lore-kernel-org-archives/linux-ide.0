From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] hdparm: Show form factor and media rotation rate
Date: Mon, 23 Feb 2009 15:26:30 -0500
Message-ID: <49A30676.4090906@rtr.ca>
References: <yq1fxi8eh7e.fsf@sermon.lab.mkp.net>	<49A08310.8020100@msgid.tls.msk.ru> <yq11vtpuo4t.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:53764 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753325AbZBWU0e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Feb 2009 15:26:34 -0500
In-Reply-To: <yq11vtpuo4t.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, linux-ide@vger.kernel.org

Martin K. Petersen wrote:
>>>>>> "Michael" == Michael Tokarev <mjt@tls.msk.ru> writes:
> 
> Michael> How about printing the actual (unrecognized) value here?  Like
> Michael> this:
> 
> Michael>   + default:
> Michael>   + printf("unknown (raw value = %d)", val[FORM_FACTOR]);
> Michael>   + break;
> 
> I'm ok with that.  Mark?
..

Already done, except in hex.

Cheers
