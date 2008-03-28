From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET #upstream] libata: improve FLUSH error handling
Date: Fri, 28 Mar 2008 17:53:58 +0900
Message-ID: <47ECB226.40009@gmail.com>
References: <12066128663306-git-send-email-htejun@gmail.com>	<47EBAE2B.8070102@rtr.ca> <87bq4zl29s.fsf@basil.nowhere.org>	<47ECACBB.2060207@gmail.com> <873aqbkzde.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.246]:3992 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbYC1IyO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Mar 2008 04:54:14 -0400
Received: by hs-out-0708.google.com with SMTP id 4so129654hsl.5
        for <linux-ide@vger.kernel.org>; Fri, 28 Mar 2008 01:54:14 -0700 (PDT)
In-Reply-To: <873aqbkzde.fsf@basil.nowhere.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Mark Lord <liml@rtr.ca>, jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Hello,

Andi Kleen wrote:
> Tejun Heo <htejun@gmail.com> writes:
> 
>> Regarding the boot time exception, which
>> version was it and do you have logs?
> 
> I tried first 2.6.25-rc4 and then 2.6.24 (similar behaviour).

Hmmm...

> My impression was also that the exception handling was very 
> heavy handed -- is it really needed to always reset the link
> on each error? 

It depends on the type of error.  For things like state machine 
violation and timeouts, I think it's safer to reset.

> I'll send you full logs (huge) in separate mail.

Alright.

-- 
tejun
