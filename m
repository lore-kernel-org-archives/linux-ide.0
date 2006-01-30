From: Mattias Wadenstein <maswan@acc.umu.se>
Subject: Re: [PATCH v2] sata_sil: combined irq + LBT DMA patch for testing
Date: Mon, 30 Jan 2006 11:27:53 +0100 (MET)
Message-ID: <Pine.GSO.4.62.0601301107410.14030@shaka.acc.umu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.acc.umu.se ([130.239.18.156]:62081 "EHLO mail.acc.umu.se")
	by vger.kernel.org with ESMTP id S932202AbWA3K1z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2006 05:27:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id C7F312E
	for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2006 11:27:54 +0100 (MET)
Received: from shaka.acc.umu.se (shaka.acc.umu.se [130.239.18.148])
	by mail.acc.umu.se (Postfix) with ESMTP id 0F6B72B
	for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2006 11:27:54 +0100 (MET)
Received: from localhost (localhost [127.0.0.1])
	by shaka.acc.umu.se (Postfix) with ESMTP id 9F6EDD3D1
	for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2006 11:27:53 +0100 (MET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I just tried this patch because I have instability problems with my setup 
with two Sil3114 with 6 drives in total (running md raid5).

At first things looked fine, and reading from the md device went fine. But 
as soon as I tried writing anything to it I got hard errors which then 
dropped all disks and reported read errors from the md device. This was 
reproducable over two reboots (after which I reverted to 2.6.15).

What kind of debugging information do you need to figure out what goes 
wrong?

The setup kind of works on 2.6.15, except that on lots of IO to those 
disks the system locks up hard efter half an hour to a day. This seems 
related to sata_sil, since I can stress the other disks in the system for 
days without any stability problems.

/Mattias Wadenstein (not subscribed to list, please Cc:)
