From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2] ata: add AMD Seattle platform driver
Date: Fri, 29 Jan 2016 21:31:27 +0000
Message-ID: <20160129213127.14ca55d5@lxorguk.ukuu.org.uk>
References: <1452789071-4090-1-git-send-email-brijesh.singh@amd.com>
	<5730117.gx9ezcyLp7@wuerfel>
	<56A7A534.6040208@amd.com>
	<3904852.c3HykPsQQ2@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:36756 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbcA2Vbu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jan 2016 16:31:50 -0500
In-Reply-To: <3904852.c3HykPsQQ2@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Brijesh Singh <brijesh.singh@amd.com>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, hdegoede@redhat.com, linux-ide@vger.kernel.org

> For the ACPI case, I still think that an AML call from the AHCI driver
> is the most logical solution. You mentioned that you believe that calling
> into the AML interpreter up to 100 times per second is a noticeable
> overhead, but I doubt that and would like to see actual number backing
> that up. Note that most of the time, the status of the LEDs won't even
> change, so the driver does not have to call into the AML while I/O
> is in progress, or while it is stopped, only for the transition or in
> case of locate and fault events that should be extremely rare.

It can also be delayed - you don't need to adjust the LED at any great
rate - it's for a human not a machine to read.

Alan
