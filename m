From: Tejun Heo <htejun@gmail.com>
Subject: Re: [BUG] libahci returns stale result tf much of the time.
Date: Tue, 05 Oct 2010 09:07:42 +0200
Message-ID: <4CAACEBE.1000104@gmail.com>
References: <4C9C3878.9010206@teksavvy.com> <AANLkTi=85A9ueu9YYrh0jOKFgc+fqbaUhkRLt7=Bzx2M@mail.gmail.com> <4C9C44D0.1030409@teksavvy.com> <AANLkTinOECHi_7+y7yT-GZXxW0c4vrJOuRz80kejt2+N@mail.gmail.com> <4C9CA385.5090709@teksavvy.com> <4C9CA673.4090104@teksavvy.com> <4C9D33C0.8050900@gmail.com> <4CA99BCB.8080904@gmail.com> <4CAA0885.8060906@teksavvy.com> <4CAA0996.5080403@teksavvy.com> <4CAA0F6C.6080609@teksavvy.com> <4CAA21F4.5060000@teksavvy.com> <4CAA2AA6.2010204@pobox.com> <4CAA2C6F.2090603@teksavvy.com> <4CAA2E16.4010905@pobox.com> <4CAA3033.8030405@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36587 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756976Ab0JEHFl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Oct 2010 03:05:41 -0400
Received: by fxm4 with SMTP id 4so201900fxm.19
        for <linux-ide@vger.kernel.org>; Tue, 05 Oct 2010 00:05:40 -0700 (PDT)
In-Reply-To: <4CAA3033.8030405@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Robert Hancock <hancockrwd@gmail.com>, Seed <seedrubbish@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello,

On 10/04/2010 09:51 PM, Mark Lord wrote:
>> Which opcodes are you using? I see set-acoustic-mgmt in one email...
> 
> opcode 0xec : IDENTIFY
> 
> The result_tf it receives is from whatever non-data command last preceeds it.
> So if the previous non-data command failed (eg. hdparm -Z),
> then the IDENTIFY command actually works, but appears to fail.

I've been thinking about it and it occurred to me that PIO data
commands don't use D2H Reg FIS for command completion.  I don't recall
exactly but the PIO Setup FIS contains the result register, right?  It
seems like we should look at different places or simulate output
depending on the command executed.  Hmmm....

Thanks.

-- 
tejun
