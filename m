From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: (fwd) Re: Bug#289770: kernel-image-2.6.10-1-686: 2.6.10 fails to set up DMA on my IBM thinkpad
Date: Wed, 12 Jan 2005 14:48:15 +0100
Message-ID: <58cb370e050112054849767cfe@mail.gmail.com>
References: <20050111195345.GI2618@stro.at>
	 <20050112120245.GA24839@kantaka.co.uk>
	 <200501121352.33520.bzolnier@elka.pw.edu.pl>
	 <20050112133524.GA27287@kantaka.co.uk>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.206]:5931 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261190AbVALNsQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Jan 2005 08:48:16 -0500
Received: by wproxy.gmail.com with SMTP id 67so332734wri
        for <linux-ide@vger.kernel.org>; Wed, 12 Jan 2005 05:48:16 -0800 (PST)
In-Reply-To: <20050112133524.GA27287@kantaka.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: maximilian attems <debian@sternwelten.at>, linux-ide@vger.kernel.org, 289770@bugs.debian.org

On Wed, 12 Jan 2005 13:35:24 +0000, Philip Armstrong <phil@kantaka.co.uk> wrote:
> On Wed, Jan 12, 2005 at 01:52:33PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > "something" steals resource needed for IDE driver so no DMA
> 
> Does the kernel know what the 'something' is? Should I be routing
> around in /proc looking for something specific?

/proc/ioports for both kernels should tells us more...
