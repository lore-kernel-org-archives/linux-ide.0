From: Joe Perches <joe@perches.com>
Subject: Re: Peculiar out-of-sync boot log lines
Date: Thu, 29 Nov 2007 12:13:46 -0800
Message-ID: <1196367226.22120.53.camel@localhost>
References: <20071129193728.2f1c237e@linuxamd.linicks.net>
	 <1196365871.6473.107.camel@perihelion>
	 <20071129200332.2130298b@linuxamd.linicks.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from DSL022.labridge.com ([206.117.136.22]:4907 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757782AbXK2UQA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Nov 2007 15:16:00 -0500
In-Reply-To: <20071129200332.2130298b@linuxamd.linicks.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nick Warne <nick@ukfsn.org>
Cc: Jon Masters <jonathan@jonmasters.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Thu, 2007-11-29 at 20:03 +0000, Nick Warne wrote:
> Yes, but where does the <7> come from?

printk interleaving of functions in ide-cd and ide-iops.

drivers/ide/ide-cd.c ide_cdrom_probe_capabilities could
use something like the string_buf implementations talked
about awhile ago.


