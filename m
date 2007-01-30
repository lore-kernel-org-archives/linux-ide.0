From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: fix translation for START STOP UNIT
Date: Tue, 30 Jan 2007 09:43:16 -0500
Message-ID: <45BF5984.1030508@garzik.org>
References: <45BD4E0A.7060501@shaw.ca> <45BF5525.5040709@garzik.org> <45BF57EA.6060201@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46257 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965528AbXA3OnS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Jan 2007 09:43:18 -0500
In-Reply-To: <45BF57EA.6060201@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Robert Hancock wrote:
> Jeff Garzik wrote:
>> * Include the patch inline rather than as an attachment.  Even a 
>> text/plain attachment is very difficult to review and quote in popular 
>> email programs.
>>
>>     Jeff
> 
> I'd love to, but unfortunately nobody seems to have come up with a way 
> of doing this in Thunderbird that keeps it from mangling whitespace 
> without a ton of hassle. I was able to get it to cooperate once (sort 
> of, anyway, I think it may have still damaged something on the first 
> try), but it required mangling a bunch of settings that made using it 
> for normal mail impossible.
> 
> The last time I looked, the main "how-to" page I found had an addendum 
> that "I gave up on this, it's too hard, I just attach the patches". If 
> anyone has gotten any new insight..

Just use "cat mail | sendmail -t" or git-send-email, Thunderbird will 
never get this stuff right.

I'm fighting Thunderbird right this second, in fact, because it randomly 
decided to stop supporting drag-n-drop to sub-folders in Fedora Core 6 :(

	Jeff



