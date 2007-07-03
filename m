From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 01/12] libata: update EH report formatting
Date: Wed, 04 Jul 2007 00:02:55 +0900
Message-ID: <468A651F.3070306@gmail.com>
References: <1183283616149-git-send-email-htejun@gmail.com> <468A5BA8.9070705@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:1031 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760641AbXGCPDB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 11:03:01 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1245142nze
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 08:03:01 -0700 (PDT)
In-Reply-To: <468A5BA8.9070705@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Update formatting for LLD provided error descriptions such that...
>>
>> * No default () around it
>> * Each element is separated by <> not ,
>>
>> This change makes each element responsible for putting a space after
>> itself instead of before - e.g. "<elem> " not ", elem".  This is more
>> conventional and allows more flexible combination of messages.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> either way, it is messy.
> 
> I guarantee that programmers are not going to remember always to add a
> "magic space" after certain error descriptions.  It is far, far better
> for the upper layer to help out a bit, and insert a space and/or comma
> for the LLDD.  After all, the LLDD might not be the only one printing
> error messages at that time; the upper layer might also wish to do so in
> the same dmesg line.

Okay then, I guess it's __ata_ehi_push_desc()/ata_ehi_push_desc() time,
where the prefixed one is the raw one and the latter one is with
automatic "<> " added.  Will fix.

-- 
tejun
