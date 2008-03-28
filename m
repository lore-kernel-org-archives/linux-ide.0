From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET #upstream] libata: improve FLUSH error handling
Date: Fri, 28 Mar 2008 11:02:43 +0900
Message-ID: <47EC51C3.1080104@gmail.com>
References: <12066128663306-git-send-email-htejun@gmail.com> <47EBDE84.1070802@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.240]:23471 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593AbYC1CCu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Mar 2008 22:02:50 -0400
Received: by an-out-0708.google.com with SMTP id d31so10804and.103
        for <linux-ide@vger.kernel.org>; Thu, 27 Mar 2008 19:02:50 -0700 (PDT)
In-Reply-To: <47EBDE84.1070802@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ric@emc.com
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca

Ric Wheeler wrote:
>>   4. If retried FLUSH fails for something other than device error,
>>      don't keep retrying.  We're likely wasting time.
> 
> Are we sure that it is ever the right thing to do to reissue a flush
> command?
> 
> I am worried that this might be much closer to the media error class of
> device errors than something that will benefit from a retry of any type.

Heh.. yeah, as Alan and Jeff said, that's the spec.  If write failure
occurs during flush, the drive is supposed to stop flushing, remove the
sector from cache and report error to the host.  If the host re-issues
flush, the drive continues flushing after the failed sector.

> Also, I am unclear as to how we measure the progress of the device if
> the flush command has failed?

Yes by reporting the first failing sector.  Probably it's better to test
failed > last_failed than failed == last_failed.

>> as there is a humongous patchset pending review #upstream.  Once this
>> gets acked, I'll move it over to #upstream.  It shouldn't interfere
>> too much anyway.
>>
> We have access to a fair number of flaky drives, I can see if we can
> test some of this...

If you can trigger flush errors, please go ahead.

Thanks.

-- 
tejun
