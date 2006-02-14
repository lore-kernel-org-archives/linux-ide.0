From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: Allow IDE interface to specify its not capable of 32-bit operations
Date: Tue, 14 Feb 2006 18:00:41 +0100
Message-ID: <58cb370e0602140900n4558d608p36e73a58c132b8ac@mail.gmail.com>
References: <Pine.LNX.4.44.0602141022000.27351-100000@gate.crashing.org>
	 <1139935828.10394.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.202]:59219 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422664AbWBNRAp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Feb 2006 12:00:45 -0500
Received: by nproxy.gmail.com with SMTP id m18so455839nfc
        for <linux-ide@vger.kernel.org>; Tue, 14 Feb 2006 09:00:42 -0800 (PST)
In-Reply-To: <1139935828.10394.44.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kumar Gala <galak@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 2/14/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2006-02-14 at 10:22 -0600, Kumar Gala wrote:
> > In some embedded systems the IDE hardware interface may only support 16-bit
> > or smaller accesses.  Allow the interface to specify if this is the case
> > and don't allow the drive or user to override the setting.
>
> The "no_io_32bit" is just a dead leftover. It has no effect at all
> anyway so this patch is a bit pointless.
>
> Do a grep over the code for no_io_32bit and you will see its essentially
> a private variable in the CMD640 driver.

Please grep ide.c for "no_io_32bit".  Thank you.

Bartlomiej
