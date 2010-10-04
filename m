From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [BUG] libahci returns stale result tf much of the time.
Date: Mon, 04 Oct 2010 15:35:11 -0400
Message-ID: <4CAA2C6F.2090603@teksavvy.com>
References: <4C9C3878.9010206@teksavvy.com> <AANLkTi=85A9ueu9YYrh0jOKFgc+fqbaUhkRLt7=Bzx2M@mail.gmail.com> <4C9C44D0.1030409@teksavvy.com> <AANLkTinOECHi_7+y7yT-GZXxW0c4vrJOuRz80kejt2+N@mail.gmail.com> <4C9CA385.5090709@teksavvy.com> <4C9CA673.4090104@teksavvy.com> <4C9D33C0.8050900@gmail.com> <4CA99BCB.8080904@gmail.com> <4CAA0885.8060906@teksavvy.com> <4CAA0996.5080403@teksavvy.com> <4CAA0F6C.6080609@teksavvy.com> <4CAA21F4.5060000@teksavvy.com> <4CAA2AA6.2010204@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:44394 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932368Ab0JDTfN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Oct 2010 15:35:13 -0400
In-Reply-To: <4CAA2AA6.2010204@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Robert Hancock <hancockrwd@gmail.com>, Seed <seedrubbish@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 10-10-04 03:27 PM, Jeff Garzik wrote:
> On 10/04/2010 02:50 PM, Mark Lord wrote:
>> I've dug a bit deeper, and worked around the issue.
>> It seems that libata is not always happy about DATA-xfer commands
>> that also have the check-sense bit set (0x20 in cdb[2]).
>> Perhaps that's not even valid in SCSI ??
>
>
> Very interesting... poking at this now on pre- and post-libahci platforms. As you said, don't see much difference in behavior WRT libahci -- which I expected/hoped, since that split shouldn't have changed behavior at all[1].


Yeah.  Non-data commands still get a (correct) updated result_tf from AHCI,
but data commands don't get one, unless they fail.

Weird, but I've worked around it now.

Cheers
