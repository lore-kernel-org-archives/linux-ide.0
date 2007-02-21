From: Suleiman Souhlal <ssouhlal@freebsd.org>
Subject: Re: [PATCH 1/3] Make the IDE DMA timeout modifiable
Date: Tue, 20 Feb 2007 18:13:53 -0800
Message-ID: <3063A690-4E3D-4A6E-A7DC-3E624121FBB8@freebsd.org>
References: <20070221011922.GA1777@freefall.freebsd.org> <200702210244.53514.bzolnier@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elvis.mu.org ([192.203.228.196]:51525 "EHLO elvis.mu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965039AbXBUCc3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Feb 2007 21:32:29 -0500
In-Reply-To: <200702210244.53514.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


On Feb 20, 2007, at 5:44 PM, Bartlomiej Zolnierkiewicz wrote:

>
> On Wednesday 21 February 2007 02:19, Suleiman Souhlal wrote:
>> It can be changed via /proc/ide/hd?/settings.
>
> Why do we need to change IDE DMA timeout dynamically?

I've used it to test error recovery (for example).

> BTW /proc/ide/hd?/settings is obsoleted

What's the preferred way of changing such settings, these days?

-- Suleiman


