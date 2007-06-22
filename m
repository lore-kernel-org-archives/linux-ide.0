From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: Stop mapping ROMs
Date: Fri, 22 Jun 2007 17:59:21 +0400
Message-ID: <467BD5B9.3080307@ru.mvista.com>
References: <20070622142252.2ec0d148@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:8233 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754763AbXFVN5k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Jun 2007 09:57:40 -0400
In-Reply-To: <20070622142252.2ec0d148@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, bzolnier@gmail.com

Hello.

Alan Cox wrote:

> Various old IDE drivers go mapping ROM devices for no apparent reason and
> without using the ROM mapping API we now have. They don't actually use

    Hm, do you mean the sysfs based aproach? I've tried that and somehow it 
failed to work for me -- that's because I deferred removing this stuff from 
the drivers.

> the ROM they map and the new libata drivers are happy without it being

    I guess ROMs used to be mappen just for dumping BIOSes...

> mapped so rather than port them lets just junk it for the next -rc1.

    I'd agree to the patch -- the drivers were mapping ROMs in a bad way, 
often using the default addresses.

MBR, Sergei
