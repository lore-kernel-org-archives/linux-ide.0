From: David Greaves <lkml@dgreaves.com>
Subject: Re: Promise Ultra100TX2 PDC20286 broken in 2.6.0-test9
Date: Wed, 26 Nov 2003 22:50:09 +0000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3FC52E21.6020605@dgreaves.com>
References: <3FAD5145.5040603@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail18.svr.pol.co.uk ([195.92.67.23]:29710 "EHLO
	mail18.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S264361AbTKZWwW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Nov 2003 17:52:22 -0500
Received: from modem-382.hyena.dialup.pol.co.uk ([81.78.113.126] helo=oak.dgreaves.com)
	by mail18.svr.pol.co.uk with esmtp (Exim 4.14)
	id 1AP8VB-0005Fj-1m
	for linux-ide@vger.kernel.org; Wed, 26 Nov 2003 22:51:17 +0000
Received: from 80.dgreaves.com ([10.0.0.80] helo=dgreaves.com)
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1AP9VT-0003in-Ie
	for linux-ide@vger.kernel.org; Wed, 26 Nov 2003 23:55:39 +0000
In-Reply-To: <3FAD5145.5040603@dgreaves.com>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi Bart
I've downloaded (but not yet tried) -test10 but as you said elsewhere, 
there are no patches that seem to touch the area I had a problem with.

Do you think my problem is likely to be touched by -test11?
Are there any other patches you'd like me to try?

BTW this list is now on  

http://marc.theaimsgroup.com/?l=linux-ide&r=1&w=2

Hank says

>I don't think vger keeps copies of older messages, but if you know of
>anywhere I can find 'em I'd be happy to bulk-add them to our archives.
>
I figured you may have them/some?

David

David Greaves wrote:

> Summary:
> PDC20286 fails horribly with 2 UDMA drives on its primary channel
> If I move one drive to the second channel it seems OK.
>
>
> I have compiled with and without "DMA on by default".
> I've also used the autotune options (and ata66)
> I looked for the most conservative config I could find before posting 
> (well, I thought I did) :)
>
> ok...
> I tried again with:
> * DMA on by default (IDEDMA_PCI_AUTO) (done a partial config dump 
> later...)
> * removed noapic and used both autotune options (not tried before)
>  kernel /vmlinuz-2.6.0-test9 ro root=/dev/hdc3 ide2=autotune 
> ide3=autotune single
>
> Result:
> same problem


