From: Tejun Heo <htejun@gmail.com>
Subject: Re: [BUG] libahci returns stale result tf much of the time.
Date: Tue, 05 Oct 2010 18:06:01 +0200
Message-ID: <4CAB4CE9.9070709@gmail.com>
References: <4C9C3878.9010206@teksavvy.com> <AANLkTi=85A9ueu9YYrh0jOKFgc+fqbaUhkRLt7=Bzx2M@mail.gmail.com> <4C9C44D0.1030409@teksavvy.com> <AANLkTinOECHi_7+y7yT-GZXxW0c4vrJOuRz80kejt2+N@mail.gmail.com> <4C9CA385.5090709@teksavvy.com> <4C9CA673.4090104@teksavvy.com> <4C9D33C0.8050900@gmail.com> <4CA99BCB.8080904@gmail.com> <4CAA0885.8060906@teksavvy.com> <4CAA0996.5080403@teksavvy.com> <4CAA0F6C.6080609@teksavvy.com> <4CAA21F4.5060000@teksavvy.com> <4CAA2AA6.2010204@pobox.com> <4CAA2C6F.2090603@teksavvy.com> <4CAA2E16.4010905@pobox.com> <4CAA3033.8030405@teksavvy.com> <4CAACEBE.1000104@gmail.com> <4CAB30FA.2010508@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57728 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121Ab0JEQEG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Oct 2010 12:04:06 -0400
Received: by fxm4 with SMTP id 4so515641fxm.19
        for <linux-ide@vger.kernel.org>; Tue, 05 Oct 2010 09:04:05 -0700 (PDT)
In-Reply-To: <4CAB30FA.2010508@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Robert Hancock <hancockrwd@gmail.com>, Seed <seedrubbish@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello,

On 10/05/2010 04:06 PM, Mark Lord wrote:
> Yeah, maybe something like that.
> 
> But do note that I have verified that "hdparm -C" does work correctly,
> and is dependent upon correctly returned result_tf values.
> 
> It's not a PIO "data" command, though.  Does it get issued the same way?

PIO Setup FIS is not used for nodata commands.  IIRC, nodata uses D2H
Reg FIS for command completion.  I think the only exception is PIO
data commands.  The weird hack is to satisfy PIO data command protocol
timing requirement stemming from PATA specification.  Eh... ugly.

Thanks.

-- 
tejun
