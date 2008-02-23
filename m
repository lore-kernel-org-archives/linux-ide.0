From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: 2.6.25-rc2 + smartd = hang
Date: Sat, 23 Feb 2008 09:39:46 +0300
Message-ID: <20080223063943.4EF77364D5@smtp02.mtu.ru>
References: <20080222165122.8D2BB93C12F@tippex.mynet.homeunix.org> <47BF0DCD.4060400@garzik.org> <20080222185645.9DD9C93C12F@tippex.mynet.homeunix.org> <47BF3DE3.4000100@rtr.ca> <20080222213932.3403F93C12F@tippex.mynet.homeunix.org> <47BF45E4.4020006@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758933AbYBWGkE@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, aeriksson@fastmail.fm, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Jeff Garzik wrote:

>> If this is the prefered driver these days, maybe it shouldn't be marked
>> experimental in the menu anymore?
> 
> It's not marked experimental.
>

the comment on the very top of drivers/ata says:

tristate "Serial ATA (prod) and Parallel ATA (experimental) drivers"

this is a bit confusing
