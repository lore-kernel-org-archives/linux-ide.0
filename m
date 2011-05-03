From: Mark Lord <kernel@teksavvy.com>
Subject: Re: How to perform SECURITY ERASE on a SEC4 (security enabled/locked)
 PATA drive ?
Date: Tue, 03 May 2011 10:55:00 -0400
Message-ID: <4DC01744.6040206@teksavvy.com>
References: <BANLkTikZt4Nr3DK3CkZXZ_ORgqjy-MGOUA@mail.gmail.com>	<4DBAC18A.20407@teksavvy.com>	<BANLkTimFg_=KmCRVL=QoO9s-4+T3DmbNQw@mail.gmail.com>	<4DBB7341.1070600@teksavvy.com> <BANLkTi==R1tb-oNp4Sf5DJHS3wjZyC_wLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:63974 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752757Ab1ECOzE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 May 2011 10:55:04 -0400
In-Reply-To: <BANLkTi==R1tb-oNp4Sf5DJHS3wjZyC_wLg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Maciej Grela <maciej.grela@gmail.com>
Cc: linux-ide@vger.kernel.org

On 11-04-30 04:10 AM, Maciej Grela wrote:
> 2011/4/30 Mark Lord <kernel@teksavvy.com>:
>>
>> Okay.  Now please do exactly this (and I mean EXACTLY):
>>
>> 1. shut down and completely power off the system.
>> 2. boot up again, and immediately do "hdparm --Istdout /dev/sdb
>> and post the results here.
>>
>> I want to see what the default security state of the drive is,
>> and that sequence above will tell all.
>>
>
> Hi,
>
> Here is the data:
..

> Security:
>         Master password revision code = 65534
>                 supported
>                 enabled
>                 locked
>         not     frozen
>         not     expired: security count
>         not     supported: enhanced erase
>         Security level high
>         42min for SECURITY ERASE UNIT.
..

Okay, your drive already has a password set on it.
So to do a --security-erase, you will likely need to
know and supply that exact password on the command line:

    hdparm --security-erase XXXXXXXX /dev/sdb

If you don't know the password, then you can try this:

    hdparm --security-set-pass NULL --user-master m /dev/sdb
    hdparm --security-erase    NULL --user-master m /dev/sdb

If that also fails, then you'll have to read through the ATA
security feature documentation (from the t13 standards),
and try and understand how the quirky state machine model
for it is supposed to work.  And then puzzle it out from there.

Not all drives do it in exactly the same way,
and not all of them strictly follow the standard.
So it may take some playing around to figure it out.

I don't do this often enough here to remember which brands
prefer what sequences etc.

Cheers
-ml
