From: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Subject: Re: ICH10 not working with AHCI kernel option
Date: Thu, 8 Apr 2010 11:15:16 -0300
Message-ID: <4bbde4f7.1702be0a.5f6c.028e@mx.google.com>
References: <eo2197-4lb.ln1@tux.abusar.org.br>
	<20100408144525.2f3f5718@lxorguk.ukuu.org.uk>
	<4bbdde49.e302be0a.3106.0220@mx.google.com>
	<20100408145916.50dbe8de@lxorguk.ukuu.org.uk>
	<4bbde1ea.c701be0a.60ec.0270@mx.google.com>
	<20100408150920.5689564b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53882 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720Ab0DHOPW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Apr 2010 10:15:22 -0400
Received: by pwj9 with SMTP id 9so1902254pwj.19
        for <linux-ide@vger.kernel.org>; Thu, 08 Apr 2010 07:15:21 -0700 (PDT)
In-Reply-To: <20100408150920.5689564b@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Thu, 8 Apr 2010 15:09:20 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Yes

	Ok, problem solved. You're right, the BIOS option was wrong.
The problem is that it's called "RAID mode" and I found it not
intuitive since I don't use RAID (so I didn't touch it). I changed it
from IDE to AHCI and it worked.

	So just a quick and last question. I read here the following:

http://forum-en.msi.com/index.php?topic=106575.120

"AHCI is a native SATA Mode.  There is not necessarely a major
performance difference between IDE/Legacy Mode and AHCI Mode".

	Of course this guy is talking about Windows, but can it be
applied to Linux too? I mean, does AHCI offers no significant
performance improvement over SFF/Legacy mode?

	Thanks.

-- 
