From: Tejun Heo <tj@kernel.org>
Subject: Re: delay & msgs on S3 wakeup, Dell XPS m1330 laptop
Date: Sat, 30 Aug 2008 13:03:12 +0200
Message-ID: <48B928F0.2020106@kernel.org>
References: <c0a09e5c0808262156u1ed7777ay5f1e6c196a8be6b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38973 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210AbYH3LEW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Aug 2008 07:04:22 -0400
In-Reply-To: <c0a09e5c0808262156u1ed7777ay5f1e6c196a8be6b7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Grover <andy.grover@gmail.com>
Cc: linux-ide@vger.kernel.org

Andrew Grover wrote:
> Laptop comes out of suspend and then spends a long time (10 sec)
> waiting, and then finishes coming up. Everything seems to be working
> fine, but the delay is worrisome.
> 
> Any tips? Running latest bios (a12) on Ubuntu 2.6.24-19 kernel.
> 
> [    2.946116] sd 2:0:0:0: [sda] Starting disk
> [    6.128124] ata3: port is slow to respond, please be patient (Status 0x80)
> [   10.941192] ata3: softreset failed (device not ready)
> [   11.240148] ata3: port is slow to respond, please be patient (Status 0x80)
> [   11.482698] ata3: COMRESET failed (errno=-16)
> [   11.508223] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   11.583731] ata3.00: configured for UDMA/133
> [   11.585389] sd 2:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)

Please post full boot log and the result of "lspci -nn" and do you
happen to be using ALPM?

-- 
tejun
