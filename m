From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/2] ide: remove deprecated use of pci api
Date: Mon, 13 Apr 2015 13:08:13 -0400 (EDT)
Message-ID: <20150413.130813.2058573928379941715.davem@davemloft.net>
References: <1428579988-10167-1-git-send-email-lambert.quentin@gmail.com>
	<1428579988-10167-2-git-send-email-lambert.quentin@gmail.com>
	<20150413132530.210f1d3b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20150413132530.210f1d3b@lxorguk.ukuu.org.uk>
Sender: kernel-janitors-owner@vger.kernel.org
To: gnomes@lxorguk.ukuu.org.uk
Cc: lambert.quentin@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Date: Mon, 13 Apr 2015 13:25:30 +0100

> On Thu,  9 Apr 2015 13:46:27 +0200
> Quentin Lambert <lambert.quentin@gmail.com> wrote:
> 
>> Replace occurences of the pci api by appropriate call to the dma api.
>> 
> 
> Drivers/ide is obsolete. It probably ought to go at this point but even
> so it exists solely in case of a problem or compatibility issue with
> drivers/ata. Cleaning it up without testing all the drivers makes no
> sense IMHO. Cleaning it up and testing them doesn't make much sense
> either.

It's a straightforward transformation, that actually evaluates to what
the definitions of the deprecated pci DMA interfaces are defined to.

So I intend to apply this patch, especially for the sake of allowing
these PCI DMA interfaces to be removed.
