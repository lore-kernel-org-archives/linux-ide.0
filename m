From: "F. P. Beekhof" <fpbeekhof@gmail.com>
Subject: Re: Machine check exception
Date: Wed, 27 Jul 2011 22:54:11 +0200
Message-ID: <4E307AF3.40109@gmail.com>
References: <4E2FF0EC.2020704@gmail.com> <20110727130319.GA26923@gere.osrc.amd.com> <4E302F6C.3@gmail.com> <20110727170309.GB26923@gere.osrc.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41978 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111Ab1G0UyP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jul 2011 16:54:15 -0400
Received: by wyg8 with SMTP id 8so1274466wyg.19
        for <linux-ide@vger.kernel.org>; Wed, 27 Jul 2011 13:54:14 -0700 (PDT)
In-Reply-To: <20110727170309.GB26923@gere.osrc.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@amd64.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

On 07/27/2011 07:03 PM, Borislav Petkov wrote:
> On Wed, Jul 27, 2011 at 05:31:56PM +0200, F. P. Beekhof wrote:
>> $ sudo rdmsr 0xc001001f
>> 8
>>
>> Is there anything else I can do ?
>
> Ok, I'd like you to try something out:
>
> Boot into runlevel 1: you need this because you get the MCE before
> you've done starting apache. For that, add a "1" to your kernel command
> line and boot. When you get the prompt, type in your root pwd and do
>
> wrmsr 0xc001001f $(( $(rdmsr -u 0xc001001f) | (1<<  20) ))
>
> Then do
>
> rdmsr -x 0xc001001f
>
> to verify that the write has succeeded. It should say
>
> 0x00100008.
>
> then exit the prompt to continue to runlevel 2 to see whether this
> setting fixes your MCE issue.
>
> This is for now,
> thanks.
>

Ok, writing the register worked.

Now we just need to wait, these crashes occur at random moments. 
Sometimes there is 5 minutes between two crashes, sometimes a few days...

I'll post an update as soon as I have more information.

Thanks for helping out!

