From: "Daniel J Blueman" <daniel.blueman@gmail.com>
Subject: Re: Compact Flash performance...
Date: Thu, 31 May 2007 10:18:48 +0100
Message-ID: <6278d2220705310218x2736f652wb8d17095a9a82e6f@mail.gmail.com>
References: <6278d2220705301510y2d81f69eu38fb778d32de05e1@mail.gmail.com>
	 <75b66ecd0705301531q1ba78d39od07d2611573c9150@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:20540 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756656AbXEaJSu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 May 2007 05:18:50 -0400
Received: by wr-out-0506.google.com with SMTP id 76so95228wra
        for <linux-ide@vger.kernel.org>; Thu, 31 May 2007 02:18:49 -0700 (PDT)
In-Reply-To: <75b66ecd0705301531q1ba78d39od07d2611573c9150@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On 30/05/07, Lee Revell <rlrevell@joe-job.com> wrote:
> On 5/30/07, Daniel J Blueman <daniel.blueman@gmail.com> wrote:
> > I have a SanDisk Extreme IV 4GB CF card, capable of 40MB/s read, but
> > am seeing 30MB/s read [1], connected directly to the IDE bus on my
> > ICH8 controller.
>
> How do you know it's capable of 40MB/s read?

Hi Lee,

There are various reports of users getting 40MB/s == 38.1MiB/s with
UDMA mode 6 media readers (which are few and far between):

http://www.robgalbraith.com/bins/content_page.asp?cid=7-7896-8475
http://www.it-enquirer.com/media/screenshots/sandisk-extreme-bench.png

If a particular reader is able to get 40MB/s through the CF interface,
then this most likely will be achievable with ICH8+Linux also, but
perhaps parameters need to be tuned or the right IDE configuration
needs to be reached etc.

> Lee
-- 
Daniel J Blueman
