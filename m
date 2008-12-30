From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: 2.6.28: Driver 'sd' needs updating - please use bus_type methods
Date: Tue, 30 Dec 2008 07:26:48 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0812300615210.11356@p34.internal.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([75.144.35.66]:54662 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754481AbYL3M0s (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Dec 2008 07:26:48 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

I have seen these for a few kernel versions now, is this related to 
generic scsi support?

[    0.368254] Driver 'sd' needs updating - please use bus_type methods
[    0.368320] Driver 'sr' needs updating - please use bus_type methods

