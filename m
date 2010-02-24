From: Yuhong Bao <yuhongbao_386@hotmail.com>
Subject: SB600 64-bit DMA BIOS misconfiguration (formerly RE: [PATCH 2.6.34]
 ehci-hcd: add option to enable 64-bit DMA support)
Date: Tue, 23 Feb 2010 19:53:05 -0800
Message-ID: <SNT125-W3300E8CCB5A9BD2D7B9942C3410@phx.gbl>
References: <4B7CAF95.6020306@gmail.com>
 <20100218042626.GB11649@kroah.com>,<51f3faa71002172113o65a85ed6y5fa39d0b3a96f7ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51f3faa71002172113o65a85ed6y5fa39d0b3a96f7ce@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hancockrwd@gmail.com, greg@kroah.com, shane.huang@amd.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, tj@kernel.org
List-Id: linux-ide@vger.kernel.org


> it doesn't work. Based on the libata experience with AHCI which has a
> similar 64-bit feature flag, there are some controllers that didn't do
> it properly, but not many (only ATI SB600 it appears, and only on
> certain boards, as it seems it was a BIOS configuration issue).
It seems it was solved by a DMI whitelist, but if it is a BIOS configuration issue, I think it would be better if it could be detected directly instead by reading the configuration directly from the device and correcting it if possible. Is that possible?

Yuhong Bao
 		 	   		  
_________________________________________________________________
Your E-mail and More On-the-Go. Get Windows Live Hotmail Free.
http://clk.atdmt.com/GBL/go/201469229/direct/01/