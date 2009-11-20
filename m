From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Fri, 20 Nov 2009 21:20:50 +0300
Message-ID: <4B06DE02.2070607@ru.mvista.com>
References: <20091117144450.15430.83450.stgit@localhost.localdomain>	<200911191838.11791.bzolnier@gmail.com>	<20091119175051.6a91d160@lxorguk.ukuu.org.uk>	<200911191852.23061.bzolnier@gmail.com>	<20091119182132.5155f819@lxorguk.ukuu.org.uk>	<4B0590A2.9050306@ru.mvista.com> <20091119194008.2c97edcd@lxorguk.ukuu.org.uk> <4B05B6E3.6080604@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:47305 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753908AbZKTSUF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Nov 2009 13:20:05 -0500
In-Reply-To: <4B05B6E3.6080604@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Hello, I wrote:

>> I agree entirely with that and I'll push the udelay(10) into all three

>   I can't say anything about pata_hpt36x, I don't think I have HPT 
> drivers that old...

    No, actually I can. On HPT36x cable detection bit simply isn't 
multiplexed, so there's no point in debouncing.

>> plus the drivers/ide one unless Bart beats me to it.

>   I could beat you to it as well. :-)

    Working in it right now...

>> Alan

WBR, Sergei

