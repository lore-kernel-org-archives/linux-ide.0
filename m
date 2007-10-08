From: idurdanovic@comcast.net (Igor Durdanovic)
Subject: Re: sata_sil24 and sil-4726
Date: Sun, 7 Oct 2007 20:27:32 -0400
Message-ID: <18185.31092.208800.637059@kitty1.shrimp.net>
References: <18180.26625.216781.626572@kitty1.shrimp.net>
	<470468EE.909@gmail.com>
	<18180.30643.554165.292012@kitty1.shrimp.net>
	<4704790C.7060901@gmail.com>
	<18180.31651.305092.579581@kitty1.shrimp.net>
	<470480C9.9030309@gmail.com>
	<18180.34107.704754.565573@kitty1.shrimp.net>
	<47048C2B.1060202@gmail.com>
	<47049344.6010603@gmail.com>
	<18180.38483.139258.690293@kitty1.shrimp.net>
	<47049799.3030509@gmail.com>
	<18180.39323.750969.577889@kitty1.shrimp.net>
	<47049A74.3080000@gmail.com>
Reply-To: idurdanovic@comcast.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sccrmhc14.comcast.net ([204.127.200.84]:35377 "EHLO
	sccrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965AbXJHA1n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Oct 2007 20:27:43 -0400
In-Reply-To: <47049A74.3080000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: idurdanovic@comcast.net, linux-ide@vger.kernel.org

Hi Tejun,

I have made the following experimental observation on the
SIL-3132 <-> SIL-4726 writing speed.

I have 5 Seagate 750GB disks, each running at 3.0 Gbps
All have write-cache enabled.

I can write to 1 disk at 74MB/s

Writing to 2 disks simultaneously, the speed drops down to 37MB/s
per disk (sum is still 74MB/s)

Writing to 3 disks simultaneously, the speed drops down to 25MB/s
per disk, etc.

Any idea why each disk gets only a fraction of the bandwidth when
accessed simultaneously? The port multiplier ought to sustain 300MB/s


Thanks, Igor
