From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.25-rc2 + smartd = hang
Date: Fri, 22 Feb 2008 13:00:45 -0500
Message-ID: <47BF0DCD.4060400@garzik.org>
References: <20080222165122.8D2BB93C12F@tippex.mynet.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762766AbYBVSBG@vger.kernel.org>
In-Reply-To: <20080222165122.8D2BB93C12F@tippex.mynet.homeunix.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Anders Eriksson <aeriksson@fastmail.fm>
Cc: linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>
List-Id: linux-ide@vger.kernel.org

Anders Eriksson wrote:
> Hi,
> 
> Trying out 2.6.25-rc2 smartd always causes my box to hang. I can switch 
> vt:s and the keyboard seems to work.
> 
> Using sysrq-e I noticed a callpath open -> ext3 -> journals -> sync_buffer -> 
> io_scheduel -> generic_unplig_device.
> 
> I'd guess the open stems from smartd. Removing smartd from the startup, I'm 
> now using rc2 fine...
> 
> I got a nice jpg showing it as well.

The sysrq-e output is probably just standard ext3 journalling unrelated 
to the problem...  what does dmesg say?  lspci?  What's your hardware setup?

	Jeff
