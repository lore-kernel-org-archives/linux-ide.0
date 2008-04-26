From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: Add Intel SCH PATA support
Date: Sun, 27 Apr 2008 00:50:11 +0100
Message-ID: <20080427005011.026048df@core>
References: <20080426140007.63cfeede@dxy.sh.intel.com>
	<48135C56.507@ru.mvista.com>
	<20080427073237.45f799a2@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53568 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753480AbYDZX5S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Apr 2008 19:57:18 -0400
In-Reply-To: <20080427073237.45f799a2@dxy.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alek Du <alek.du@intel.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, jgarzik@pobox.com

> Currently, it only use device ID to decide if force to go SCH way (force
> to PATA_80 and skip port enabling bit check), but it would be easier for expanding
> if I define a structure here. (looks like ich_laptop)

Just define an sch_pata type for those controller types and fix up the
relevant methods accordingly. Much cleaner
