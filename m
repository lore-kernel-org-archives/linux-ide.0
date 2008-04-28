From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: Add Intel SCH PATA support (revised)
Date: Mon, 28 Apr 2008 09:41:23 +0100
Message-ID: <20080428094123.59d055c7@core>
References: <20080426140007.63cfeede@dxy.sh.intel.com>
	<20080426103012.21dcf0fb@core>
	<20080427075115.3ea40204@dxy.sh.intel.com>
	<20080427093434.182a2137@core>
	<20080427220315.794a6df3@dxy.sh.intel.com>
	<20080427153111.3438dce8@core>
	<20080428120517.3025b6c6@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41159 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752619AbYD1Isn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Apr 2008 04:48:43 -0400
In-Reply-To: <20080428120517.3025b6c6@dxy.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alek Du <alek.du@intel.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Mon, 28 Apr 2008 12:05:17 +0800
Alek Du <alek.du@intel.com> wrote:

> Hi Alan, Jeff
> 
> I re-write the patch according to the kind comments from Alan, I also did the test on my SCH machine. Please review it again. Thanks a lot.

Much nicer. We have a standard library helper for cable types you can use

ata_cable_unknown()

does the same as your private routine.

Alan


