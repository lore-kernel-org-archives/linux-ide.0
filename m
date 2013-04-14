From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC PATCH] AHCI: Workaround for ATAPI on buggy AHCI controller
Date: Sat, 13 Apr 2013 21:21:40 -0400
Message-ID: <516A04A4.7050709@pobox.com>
References: <CAO1A-8A0c=5GnH4wLYBz+N1tHLUO3CeuOSq_7S+ZxscNqt5Hnw@mail.gmail.com> <5168E78D.90805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f53.google.com ([209.85.128.53]:56461 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab3DNBVr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Apr 2013 21:21:47 -0400
Received: by mail-qe0-f53.google.com with SMTP id q19so2164227qeb.12
        for <linux-ide@vger.kernel.org>; Sat, 13 Apr 2013 18:21:46 -0700 (PDT)
In-Reply-To: <5168E78D.90805@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Marc C <marc.ceeeee@gmail.com>, jeff@garzik.org, linux-ide@vger.kernel.org

On 04/13/2013 01:05 AM, Robert Hancock wrote:
> On 04/12/2013 01:34 PM, Marc C wrote:
>> Hello Jeff,
>>
>> I'm working with a proprietary but AHCI-compatible SATA controller
>> that uses
>> the libata driver. Early versions of this controller have issues with
>> processing
>> non-data ATAPI commands. A workaround was identified which requires some
>> register pokes in the command completion path of the driver. I don't
>> expect to
>> push this patch upstream (yet). However, I would like to get some
>> feedback
>> regarding the workaround, and check if the placement of the code is
>> "acceptable"
>> or if there would be a better place to put it.
>>
>> The workaround itself is rather simple: toggle the START bit
>> immediately after a
>> non-data ATAPI command completes. The ST bit toggle would be performed
>> within
>> atomic context in the AHCI port interrupt ISR.
>>
>> Signed-off-by: Marc C <marc.ceeeee@gmail.com>
>
> This should likely be triggered off a host flag like some of the ones
> already in the driver so it can be done just for the affected
> controllers, not unconditionally.

Indeed -- you don't want to punish the non-buggy 99% case for one weird 
buggy hardware rev.

See AHCI_HFLAG_xxx

	Jeff




