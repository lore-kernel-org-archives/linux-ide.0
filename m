From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Linux Kernel 2.6.13-rc7 (WORKS) (2.6.13, DRQ/System CRASH)
Date: Mon, 5 Sep 2005 09:26:57 +0200
Message-ID: <58cb370e050905002630a0e02e@mail.gmail.com>
References: <Pine.LNX.4.63.0508311328230.1945@p34>
	 <Pine.LNX.4.63.0508311408320.1945@p34>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.206]:8939 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932269AbVIEH1E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Sep 2005 03:27:04 -0400
Received: by nproxy.gmail.com with SMTP id x37so309260nfc
        for <linux-ide@vger.kernel.org>; Mon, 05 Sep 2005 00:26:57 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.63.0508311408320.1945@p34>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, support@promise.com, linux-ide@vger.kernel.org, apiszcz@lucidpixels.com

On 8/31/05, Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
> I do not even have IDE Taskfile Access enabled, so how is the kernel
> printing these error messages before it freezes?
> 
> linux-2.6.13/drivers/ide/ide-taskfile.c:                printk(KERN_ERR
> "%s: no DRQ after issuing %sWRITE%s\n",
> 
> 
>    lqqqqqqqqqqqqqqqqqqqqqqq ATA/ATAPI/MFM/RLL support qqqqqqqqqqqqqqqqqqqqqqqk
>    x x[ ]     IDE Taskfile Access

After DMA timeout driver reverted back to PIO,
ide-taskfile.c also holds PIO code besides IDE Taskfile Access.

Bartlomiej
