From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata_hpt3x2n: fix overclocked MWDMA0 timing
Date: Fri, 27 Nov 2009 22:47:49 +0300
Message-ID: <4B102CE5.1050901@ru.mvista.com>
References: <200911271956.55939.bzolnier@gmail.com> <4B102B83.1080102@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:5062 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751732AbZK0Tqu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Nov 2009 14:46:50 -0500
In-Reply-To: <4B102B83.1080102@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, I wrote:

>> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>> ---
>> Sergei, XFER_UDMA_5 timing also looks suspicious,
>> please take a look when you have a minute, thanks.

>    Yeah, but it's the same as XFER_UDMA_4, so actually underclocked... 
> However, it matches what the HPT371N datasheet and the vendor drivers 
> have. The 'hpt366' driver uses more speedy mode, with 22.5 ns cycle. ;-)

    I have just verified: this driver has always used this timing 
historically, at least for HPT372+ chips.

MBR, Sergei

