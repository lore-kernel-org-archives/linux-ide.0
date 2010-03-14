From: Mark Lord <kernel@teksavvy.com>
Subject: Re: WDC WD15EARS-00Z5B1: harddrive which does crazy unloading
Date: Sun, 14 Mar 2010 11:57:38 -0400
Message-ID: <4B9D0772.4080306@teksavvy.com>
References: <201002081933.10144.suse-linux@ml082.pinguin.uni.cc> <4B96013F.1050904@kernel.org> <4B965DE7.7000109@teksavvy.com> <4B9881C8.10506@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:26038 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751834Ab0CNP5p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Mar 2010 11:57:45 -0400
In-Reply-To: <4B9881C8.10506@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Al Bogner <suse-linux@ml082.pinguin.uni.cc>, linux-ide@vger.kernel.org

On 03/11/10 00:38, Tejun Heo wrote:
>
>> The wdidle3-1.03 DOS tool can fix that.  Google it.
>>
>> I have disassembled that tool here, and found a few
>> vendor-unique commands inside it.  But thus far have
>> not managed to get them working natively in Linux.
>>
>> I really need a SATA tracer/analyser..
>
> Hmmm... so they don't respond to ATA APM command?
..

No.  The vendor-unique commands appear to download a small firmware
packet to the drive, which reprograms it for a longer "IDLE-3" timeout.

"IDLE-3" is what WD call this vendor-specific "powersaving" mode,
and it is not intended to be adjustable.  Except via that little
DOS utility hack, and even WD no longer make that available.

But I found it by googling for it, and it can change the timeout
up to 30 seconds from the default of 8.  So I set my WD 1.5TB drive
to use 30, and things are now acceptable.

Ugh (again)!
