From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: hpt374 sata (Highpoint Rocket 1540)
Date: Wed, 1 Aug 2007 17:14:28 +0100
Message-ID: <20070801171428.706f884f@the-village.bc.nu>
References: <1185880124.3483.25.camel@localhost>
	<46AF3939.8020805@ru.mvista.com>
	<46AF76D7.8050800@ru.mvista.com>
	<1185916925.8484.23.camel@orchid.arb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43832 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752142AbXHAQHg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 12:07:36 -0400
In-Reply-To: <1185916925.8484.23.camel@orchid.arb.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Ham <rah@bash.sh>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

> The pata_hpt37x driver is refusing to work as well but it doesn't crash
> the machine.  Here is the relevant error message:
> 
> hpt37x: DPLL did not stabilize.
> pata_hpt37x: BIOS has not set timing clocks.
> hpt37x: DPLL did not stabilize.

Should be fixed in the latest updates. 

