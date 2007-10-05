From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_cs5536: ATA driver for Geode companion chip (MSR)
Date: Fri, 5 Oct 2007 13:01:27 +0100
Message-ID: <20071005130127.6165e2e3@the-village.bc.nu>
References: <20071003233012.GA8721@cosmic.amd.com>
	<yq1przva76x.fsf@sermon.lab.mkp.net>
	<20071004165819.003b86c6@the-village.bc.nu>
	<20071004160834.GA28667@cosmic.amd.com>
	<yq13awq857h.fsf_-_@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60224 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755473AbXJEL5I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Oct 2007 07:57:08 -0400
In-Reply-To: <yq13awq857h.fsf_-_@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <mkp@mkp.net>
Cc: Jordan Crouse <jordan.crouse@amd.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

> pata_cs5536.c relies on Geode Machine Specific Registers to configure
> the ATA function and uses the correct PIO timings for the chip.

Any reason for not supporting both methods ? Though I guess as you say
msr is sufficient.


> +#ifndef CONFIG_PATA_CS5536	/* Temporary */

	!defined(FOO) && ! defined(FOO_MODULE)

otherwise ACK


Alan
