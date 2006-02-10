From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata janitor project
Date: Fri, 10 Feb 2006 07:46:22 -0500
Message-ID: <43EC8B1E.8050207@pobox.com>
References: <43EC7EFB.5020100@pobox.com> <loom.20060210T132349-817@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:44992 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751252AbWBJMq3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2006 07:46:29 -0500
In-Reply-To: <loom.20060210T132349-817@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Philippe Seewer <philippe.seewer@bfh.ch>
Cc: linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Philippe Seewer wrote:
> Jeff Garzik <jgarzik <at> pobox.com> writes:

(please don't cut CC's, particularly linux-ide)


>>Long term, we should work to replace the assert() in libata with 
>>standard kernel WARN_ON().
>>
>>If someone wanted to handle that conversion, that would be useful.  Make 
>>sure to pay attention, the sense of each test must be reversed.
>>
>>	Jeff
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>>the body of a message to majordomo <at> vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> 
> 
> Just so stupid little me understands this:
> replace for example: 
>   assert(sg != NULL)
> with
>   WARN_ON(sg == NULL)
> 
> right? 

Correct.


> ...What about WARN_ON being defined bu HAVE_ARCH_BUG_ON and assert by ATA_DEBUG?

I would rather just unconditionally use WARN_ON(), and eliminate assert().

	Jeff


