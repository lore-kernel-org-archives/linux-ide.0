From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Sata_Sil24: how to disable hotplug
Date: Thu, 12 Jul 2007 21:16:47 -0400
Message-ID: <4696D27F.9070605@garzik.org>
References: <8202f4270707121432h1b1b7b85u7156c54748e3dc93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59762 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846AbXGMBQs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Jul 2007 21:16:48 -0400
In-Reply-To: <8202f4270707121432h1b1b7b85u7156c54748e3dc93@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Fajun Chen wrote:
> I wonder if there's an official way to disable hotplug for SATA Sil24?

Not really.  We do need to get our act together and figure out how to 
export "knobs" to blktool and similar programs, so that people can 
easily control this stuff without resorting to module options.

	Jeff


