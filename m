From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata_sil.c 2.4.27 timeout
Date: Fri, 19 Nov 2004 05:27:22 -0500
Message-ID: <419DCA8A.2060007@pobox.com>
References: <009a01c4ce07$08a7e3d0$0d01a8c0@bryandesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27035 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261343AbUKSK1i
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Nov 2004 05:27:38 -0500
In-Reply-To: <009a01c4ce07$08a7e3d0$0d01a8c0@bryandesktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bryan Heitman <bryanh@fusemail.com>
Cc: linux-ide@vger.kernel.org

Bryan Heitman wrote:
> linux kernel 2.4.27 w/ built-in sil image driver
> Supermicro: SuperServer 6013P-T
> Supermicro motherboard: Super X5DPR-TG2+

You are not using sata_sil as the email subject claims, but rather the 
IDE subsystem's siimage.c.


> I have 4 x SATA Western Digital 1600 drives installed on a new box.  First
> drive has 8 gig ext3, 4 gig swap, and rest reiserfs, the remaining drives
> have a 160GB reiser partition.
> 
> When accessing multiple drives (>2) under moderate load we receive dma
> timeouts and ultimately disk lockups until reboot.  Here is a timeout &
> dump:
> 
> Any assistance you could provide would be greatly appreciated, I am shipping
> an identical box overnight to the Equinix Ashburn datacenter tonight to
> alleviate other unrelated hardware problems, hoping I can rely on it :)
> 
> 
> Nov 19 00:33:42 fuse6 kernel: hde: dma_timer_expiry: dma status == 0x60
> Nov 19 00:33:42 fuse6 kernel: hde: timeout waiting for DMA
> Nov 19 00:33:42 fuse6 kernel: hde: timeout waiting for DMA
> Nov 19 00:33:42 fuse6 kernel: hde: status timeout: status=0xd8 { Busy }

I would recommend using the sata_sil driver.


> Nov 19 00:34:43 fuse6 kernel: journal-601, buffer write failed
> Nov 19 00:34:43 fuse6 kernel:  (device ide2(33,1))
> Nov 19 00:34:43 fuse6 kernel: kernel BUG at prints.c:341!
> Nov 19 00:34:43 fuse6 kernel: invalid operand: 0000
> Nov 19 00:34:43 fuse6 kernel: CPU:    3
> Nov 19 00:34:43 fuse6 kernel: EIP:    0010:[<f8a0e748>]    Not tainted
> Nov 19 00:34:43 fuse6 kernel: EFLAGS: 00010286
> Nov 19 00:34:43 fuse6 kernel: eax: 00000039   ebx: f6b92c00   ecx: 00000001
> edx: c02f85a0
> Nov 19 00:34:43 fuse6 kernel: esi: 00000000   edi: 00000096   ebp: f6b92c00
> esp: f7befe1c
> Nov 19 00:34:43 fuse6 kernel: ds: 0018   es: 0018   ss: 0018
> Nov 19 00:34:43 fuse6 kernel: Process kupdated (pid: 9, stackpage=f7bef000)
> Nov 19 00:34:43 fuse6 kernel: Stack: f8a28623 f8a2cec0 c039cbe0 f8ba20e4
> f8a1a43a f6b92c00 f8a259a0 f7befe50
> Nov 19 00:34:43 fuse6 kernel:        00001502 00000099 00000000 00000097
> 00000000 d7376f00 f6b92c00 00000000
> Nov 19 00:34:43 fuse6 kernel:        00000004 00000002 f8a1ecdd f6b92c00
> f8ba20e4 00000001 00000006 00000000
> Nov 19 00:34:43 fuse6 kernel: Call Trace:    [<f8a28623>] [<f8a2cec0>]
> [<f8a1a43a>] [<f8a259a0>] [<f8a1ecdd>]
> Nov 19 00:34:43 fuse6 kernel:   [<f8a1deb7>] [<f8a288fa>] [<f8a0b5e0>]
> [<c0144a9c>] [<c0143a9c>] [<c0143e52>]
> Nov 19 00:34:43 fuse6 kernel:   [<c010724a>] [<c0143d10>] [<c0105000>]
> [<c010578e>] [<c0143d10>]
> Nov 19 00:34:43 fuse6 kernel:
> Nov 19 00:34:43 fuse6 kernel: Code: 0f 0b 55 01 36 86 a2 f8 85 db 74 0e 0f
> b7 43 08 89 04 24 e8

An undecoded oops is useless.

	Jeff


