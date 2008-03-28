From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET #upstream] libata: improve FLUSH error handling
Date: Fri, 28 Mar 2008 17:30:51 +0900
Message-ID: <47ECACBB.2060207@gmail.com>
References: <12066128663306-git-send-email-htejun@gmail.com>	<47EBAE2B.8070102@rtr.ca> <87bq4zl29s.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:54403 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbYC1Ia7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Mar 2008 04:30:59 -0400
Received: by an-out-0708.google.com with SMTP id d31so43280and.103
        for <linux-ide@vger.kernel.org>; Fri, 28 Mar 2008 01:30:58 -0700 (PDT)
In-Reply-To: <87bq4zl29s.fsf@basil.nowhere.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Mark Lord <liml@rtr.ca>, jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Hello, Andi.

Andi Kleen wrote:
> Mark Lord <liml@rtr.ca> writes:
>> Really, the entire flush + retries etc.. should never, ever, be
>> permitted to take more than XX seconds total.  Not 60 seconds per
>> retry, but XX seconds total for the original command + however many
>> retries we can fit in there.
> 
> I fully agree. Also please make that user limit settable use
> module_param too, not only sysfs. I recently had the pleasure to deal
> with a failing disk which started to spew errors already on device
> probing and it somewhat annoyed me that that slowed down boot up time
> that much. Perhaps the default during device probing should be also
> lower?

Adding global timeout now.  Regarding the boot time exception, which 
version was it and do you have logs?

-- 
tejun
