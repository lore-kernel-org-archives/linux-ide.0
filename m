From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: Add Intel SCH PATA support
Date: Sun, 27 Apr 2008 15:31:11 +0100
Message-ID: <20080427153111.3438dce8@core>
References: <20080426140007.63cfeede@dxy.sh.intel.com>
	<20080426103012.21dcf0fb@core>
	<20080427075115.3ea40204@dxy.sh.intel.com>
	<20080427093434.182a2137@core>
	<20080427220315.794a6df3@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58523 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752574AbYD0Oi0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Apr 2008 10:38:26 -0400
In-Reply-To: <20080427220315.794a6df3@dxy.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alek Du <alek.du@intel.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On Sun, 27 Apr 2008 22:03:15 +0800
Alek Du <alek.du@intel.com> wrote:

> Alan,
> 
> One problem I still do not understand, if I return PATA_UNK for cable detection result, could the
> driver finally set the disk to UDMA5 mode if I plug in 80 wire disk?

You tell me - you've got the hardware documentation I assume. Assuming the
system implements detection then it should. If a PATA controller doesn't
implement any detection (cable or host side) and it does UDMA5 then I
believe the correct description for it is usually "broken" as people will
have horrible problems trying to use things like flash drives with it.

Alan
