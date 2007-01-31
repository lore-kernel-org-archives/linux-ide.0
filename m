From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 13/15] ide: fix UDMA/MWDMA/SWDMA masks
Date: Wed, 31 Jan 2007 23:24:25 +0000
Message-ID: <20070131232425.5e767d0b@localhost.localdomain>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
	<20070119003226.14846.87052.sendpatchset@localhost.localdomain>
	<45B4FFBD.40507@ru.mvista.com>
	<20070122184620.1c8b87ac@localhost.localdomain>
	<45C0FE30.4000800@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49183 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030191AbXAaXMP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 18:12:15 -0500
In-Reply-To: <45C0FE30.4000800@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> should be slightly overclocking PIO modes 0/1 (ULi docs don't shed much light 
> on how it should be calculated)... Well, this seems fixed in libata drivers.

The libata code for tuning is based upon the BIOS programmers guide. That
seemed to be the best coverage of a minimal selection. It's also got a
big "confidential" stamp on it so I can't pass it on.

Alan
