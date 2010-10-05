From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [BUG] libahci returns stale result tf much of the time.
Date: Tue, 05 Oct 2010 10:06:50 -0400
Message-ID: <4CAB30FA.2010508@teksavvy.com>
References: <4C9C3878.9010206@teksavvy.com> <AANLkTi=85A9ueu9YYrh0jOKFgc+fqbaUhkRLt7=Bzx2M@mail.gmail.com> <4C9C44D0.1030409@teksavvy.com> <AANLkTinOECHi_7+y7yT-GZXxW0c4vrJOuRz80kejt2+N@mail.gmail.com> <4C9CA385.5090709@teksavvy.com> <4C9CA673.4090104@teksavvy.com> <4C9D33C0.8050900@gmail.com> <4CA99BCB.8080904@gmail.com> <4CAA0885.8060906@teksavvy.com> <4CAA0996.5080403@teksavvy.com> <4CAA0F6C.6080609@teksavvy.com> <4CAA21F4.5060000@teksavvy.com> <4CAA2AA6.2010204@pobox.com> <4CAA2C6F.2090603@teksavvy.com> <4CAA2E16.4010905@pobox.com> <4CAA3033.8030405@teksavvy.com> <4CAACEBE.1000104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:42394 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751634Ab0JEOGx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Oct 2010 10:06:53 -0400
In-Reply-To: <4CAACEBE.1000104@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Robert Hancock <hancockrwd@gmail.com>, Seed <seedrubbish@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 10-10-05 03:07 AM, Tejun Heo wrote:
> Hello,
>
> On 10/04/2010 09:51 PM, Mark Lord wrote:
>>> Which opcodes are you using? I see set-acoustic-mgmt in one email...
>>
>> opcode 0xec : IDENTIFY
>>
>> The result_tf it receives is from whatever non-data command last preceeds it.
>> So if the previous non-data command failed (eg. hdparm -Z),
>> then the IDENTIFY command actually works, but appears to fail.
>
> I've been thinking about it and it occurred to me that PIO data
> commands don't use D2H Reg FIS for command completion.  I don't recall
> exactly but the PIO Setup FIS contains the result register, right?  It
> seems like we should look at different places or simulate output
> depending on the command executed.  Hmmm....
..

Yeah, maybe something like that.

But do note that I have verified that "hdparm -C" does work correctly,
and is dependent upon correctly returned result_tf values.

It's not a PIO "data" command, though.  Does it get issued the same way?

