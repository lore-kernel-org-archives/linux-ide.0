From: "Konstantin A. Lepikhov" <lakostis@unsafe.ru>
Subject: Re: About forcing 32bit DMA patch for AMD690G(SB600)
Date: Fri, 25 Jan 2008 23:57:43 +0300
Message-ID: <20080125205743.GA26124@lks.home>
References: <B90463BC30D2E446BA423D888DC85E501BF3CB@sshaexmb1.amd.com> <47992BA3.3070104@gmail.com> <76366b180801242019h382fd604vd1458dab8b64dd4c@mail.gmail.com> <4799788E.1030600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mojo.unsafe.ru ([83.222.2.183]:2288 "EHLO mojo.unsafe.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754532AbYAYU5v (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Jan 2008 15:57:51 -0500
Content-Disposition: inline
In-Reply-To: <4799788E.1030600@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Paprocki <andrew@ishiboo.com>, Shane Huang <Shane.Huang@amd.com>, sriharivijayaraghavan@yahoo.com.au, linux-ide@vger.kernel.org

Hi Tejun!

Friday 25, at 02:50:06 PM you wrote:

> Andrew Paprocki wrote:
> > I have an SB600/RS690 here with SATA drives connected. I haven't been
> > following this thread, but I can help test something if it would help.
> 
> We're trying to determine whether SB600 ahci controller can do 64bit DMA
> or not.  Srihari's couldn't but Shane's test result tells a different
> story.  Do you have memory mapped over 4G (if you have 4G some of them
> will be over 4G, you can know this by looking at the e820 map printed
> during boot)?
$ lspci -nn
00:00.0 Host bridge [0600]: ATI Technologies Inc RD580 [CrossFire Xpress 3200] Chipset Host Bridge [1002:5952]
00:02.0 PCI bridge [0604]: ATI Technologies Inc RS480 PCI-X Root Port [1002:5a34]
00:05.0 PCI bridge [0604]: ATI Technologies Inc RS480 PCI Bridge [1002:5a37]
00:12.0 SATA controller [0106]: ATI Technologies Inc SB600 Non-Raid-5 SATA [1002:4380]
...

Is this hardware enough for testing? I can add 2G to existing 4G of RAM
and post dmesg.

-- 
WBR et al.
