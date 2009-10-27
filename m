From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH ide] : Increase WAIT_DRQ to support slow CF cards
Date: Tue, 27 Oct 2009 13:24:48 +0300
Message-ID: <4AE6CA70.3000002@ru.mvista.com>
References: <51f3faa70910261807h54f05f73j48b67067ee3dde70@mail.gmail.com> <20091026.181922.261475236.davem@davemloft.net> <51f3faa70910261840v16444067uc323de7129b7592f@mail.gmail.com> <20091026.184318.205708741.davem@davemloft.net> <20091027094503.GA3116@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:58726 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752760AbZJ0KY6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Oct 2009 06:24:58 -0400
In-Reply-To: <20091027094503.GA3116@frolo.macqel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Philippe De Muyter <phdm@macqel.be>
Cc: David Miller <davem@davemloft.net>, hancockrwd@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Philippe De Muyter wrote:

>> From: Robert Hancock <hancockrwd@gmail.com>
>> Date: Mon, 26 Oct 2009 19:40:03 -0600
>>
>>     
>>> On Mon, Oct 26, 2009 at 7:19 PM, David Miller <davem@davemloft.net> wrote:
>>>       
>>>> Meanwhile we should provide a way for things to work, and
>>>> realistically the only way to do that currently is to bump the
>>>> WAIT_DRQ value to some large number.
>>>>
>>>> And that's exactly the kind of patch I'm willing to accept for this.
>>>>         
>>> I agree, it's sub-optimal but it helps.. if the user wants better
>>> behavior they should a) fix it so that the card isn't using PIO, at
>>> least if it supports DMA and b) not use drivers/ide..
>>>       
>
> Strangely enough, I also had no timeout problem if I started my kernel with
> 'ide=nodma', instead of increasing WAIT_DRQ.

    Hm, interesting...

>  So I surmise that WAIT_DRQ is used in the dma case.
>
>   

   It's used only for the PIO write commands -- see do_rw_taskfile() in 
ide-taskfile.c... DMA commands don't require waiting for BSY=0, DRQ=1 
condition.

> Philippe
>   

WBR, Sergei


