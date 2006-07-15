From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: tighten ATA kconfig dependancies
Date: Sat, 15 Jul 2006 07:49:08 +0200
Message-ID: <1152942548.3114.4.camel@laptopd505.fenrus.org>
References: <20060715053418.GA5557@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:61112 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161059AbWGOFtK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Jul 2006 01:49:10 -0400
In-Reply-To: <20060715053418.GA5557@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On Sat, 2006-07-15 at 01:34 -0400, Dave Jones wrote:
> A lot of prehistoric junk shows up on x86-64 configs.


... but in general it helps compile testing if you're hacking stuff;
if your hacking IDE on x86-64 you now have to compile 32 bit as well to
see if you didn't break the compile for these as well

So please don't do this, just disable them in your config...

