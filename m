From: "Carlos Pardo" <Carlos.Pardo@siliconimage.com>
Subject: > 2TB storage
Date: Mon, 24 Oct 2005 08:35:03 -0700
Message-ID: <2E9B8131C44AF746B1E06BF9B15A434B088E37B7@mail.siliconimage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.siimage.com ([12.24.47.101]:39222 "EHLO mail.siimage.com")
	by vger.kernel.org with ESMTP id S1751094AbVJXPb5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Oct 2005 11:31:57 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Edward Falk <efalk@google.com>

To everyone,

Has anyone tested libATA drivers using disks bigger than 2 Terabytes? I just attached what is
essentially a 2.2 TB disk drive to a Silicon Image 3114 chipset. It reported around 300 Megabytes
instead of the expected 2200 Megabytes. How is the disk geometry determined ? Is it done by 
reading the IDENTIFY data or by accessing the BIOS ? Thanks in advance for any feedback.  

C Pardo
