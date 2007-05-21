From: Tejun Heo <htejun@gmail.com>
Subject: Re: something strange in libata-core.c for kernel 2.6.22-rc3
Date: Mon, 21 May 2007 11:09:03 +0200
Message-ID: <465161AF.6030002@gmail.com>
References: <fa.MCe9nCgx+WnsHp+weZyM9LiDF0s@ifi.uio.no> <fa.rv8/6n3uBnAIoUHHNUW3eR7cJd8@ifi.uio.no> <fa.LXy58QwLlPXDhsfVUU9kEfA3QbI@ifi.uio.no> <fa.Ldjy2OubeKomZD0OV2gRm/wpUFo@ifi.uio.no> <46515983.6030206@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:12755 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375AbXEUJJ2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 05:09:28 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1315709wra
        for <linux-ide@vger.kernel.org>; Mon, 21 May 2007 02:09:27 -0700 (PDT)
In-Reply-To: <46515983.6030206@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, l.genoni@oltrelinux.com, Alan Cox <alan@lxorguk.ukuu.org.uk>

Robert Hancock wrote:
>> Alan, did you have a chance to test the ACPI cable detection?  It just
>> didn't work when I tried it.  It always returned 80c on my machine.
> 
> On a whim I started poking around in the disassembled ACPI DSDT code for
> my Asus A8N-SLI Deluxe board, which is one of these chipsets. The
> original thought was that the STM/GTM trick on these chipsets is
> supposed to allow us to determine what modes we should use based on what
> modes it sets up appropriately. Unfortunately, unless I'm missing
> something in the AML (which is possible) it doesn't seem like there is
> any validation being done on the settings passed in. The settings appear
> to essentially just get programmed into the controller when STM is
> called and read back on GTM.

Yeah, that's consistent to what I've seen on my machine which is a
variant of A8N.  No matter what value I through at _STM, _GTM just
echoed the result thus always leading to 80c configuration.

> I guess this means that what we have to do is trust that the BIOS set up
> a reasonable mode and base the cable detect on that (either by reading
> back the boot-up controller registers, or by calling GTM). I imagine
> this is what the Windows default IDE driver is doing (just using the
> boot-up mode and feeding it back using GTM/STM on suspend/resume cycles).

Alan, what do you think?

-- 
tejun
