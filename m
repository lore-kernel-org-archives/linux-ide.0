From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] ide: Allow disabling of UDMA for Compact Flash
	devices
Date: Tue, 18 Apr 2006 12:14:18 +0100
Message-ID: <1145358858.18736.16.camel@localhost.localdomain>
References: <b79f23070604171611j784cc9afpd1bc6660cd25eed5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:3968 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932179AbWDRLEo
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Apr 2006 07:04:44 -0400
In-Reply-To: <b79f23070604171611j784cc9afpd1bc6660cd25eed5@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Ausmus <james.ausmus@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Llu, 2006-04-17 at 16:11 -0700, James Ausmus wrote:
> Some IDE -> Compact Flash media adapters are not capable of supporting
> UDMA, which can cause very slow boot times when the CF media itself
> reports as capable of UDMA transfer speeds. Create Kconfig option to
> turn off the UDMA capability bit when media is identified as Compact
> Flash.

This would be far better if it was a boot time option than a kernel
configuration or set using sysfs/procfs controls as users will not want
to recompile their kernel in such cases.

