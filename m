From: Mark Lord <kernel@teksavvy.com>
Subject: Re: WDC WD15EARS-00Z5B1: harddrive which does crazy unloading
Date: Tue, 09 Mar 2010 09:40:39 -0500
Message-ID: <4B965DE7.7000109@teksavvy.com>
References: <201002081933.10144.suse-linux@ml082.pinguin.uni.cc> <4B96013F.1050904@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:35496 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752090Ab0CIOky (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Mar 2010 09:40:54 -0500
In-Reply-To: <4B96013F.1050904@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Al Bogner <suse-linux@ml082.pinguin.uni.cc>, linux-ide@vger.kernel.org

On 03/09/10 03:05, Tejun Heo wrote:
> Hello,
>
> Sorry about very late reply.
>
> On 02/09/2010 03:33 AM, Al Bogner wrote:
>> I append info of an 1.5 TB WD Caviar green drive with a lot of start/stop
>> cycles. I would like to mention, that I have 4 1 TB Caviar green (WD10EADS)
>> which work fine!
>>
>> The e-SATA drive is used with this machine:
>> http://www.smolts.org/client/show/pub_b214fce2-b5b5-4a32-ba7e-cf9de6d55757
>> but has problems with other machines too.
>>
>> I use Openesuse 11.1
>> Kernel 2.6.27.42-0.1-default
>> FANTEC Fanbox FB-35US2 (probably JMicron 20360/20363 AHCI Controller)
>> storage-fixup-0.2-25.3 is installed, but not especially configured
>>
>> If you need more info let me know.
>
> How fast does it increase?  ie. counts / hour.
..

The default on these drives is to unload heads
after a mere eight (8) seconds of inactivity.

Ugh.

The wdidle3-1.03 DOS tool can fix that.  Google it.

I have disassembled that tool here, and found a few
vendor-unique commands inside it.  But thus far have
not managed to get them working natively in Linux.

I really need a SATA tracer/analyser..

-ml
