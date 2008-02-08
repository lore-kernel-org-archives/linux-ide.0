From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 00/18] ide: warm-plug support for IDE devices and other
	goodies
Date: Fri, 08 Feb 2008 19:40:43 +1100
Message-ID: <1202460043.7079.157.camel@pasglop>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47937 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755470AbYBHIlF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Feb 2008 03:41:05 -0500
In-Reply-To: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org


On Fri, 2008-02-08 at 01:44 +0100, Bartlomiej Zolnierkiewicz wrote:
> - couple of fixes and preparatory patches
> 
> - rework of PowerMac media-bay support ([un]register IDE devices instead of
>   [un]registering IDE interface) [ it is the main reason for spamming PPC ML ]

Interesting... I was thinking about doing a full remove of the device at
a higher level instead but I suppose what you propose is easier.

I'll have a look & test next week hopefully.

Ben.


