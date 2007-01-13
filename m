From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: Proposed changes for libata speed handling
Date: Sat, 13 Jan 2007 10:01:58 +0000
Message-ID: <20070113100158.1d79ba9f@localhost.localdomain>
References: <20070112135301.4cdba24f@localhost.localdomain>
	<45A83DD2.5020000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51053 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751197AbXAMJub (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Jan 2007 04:50:31 -0500
In-Reply-To: <45A83DD2.5020000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

O> Wouldn't it be better to have ->determine_xfer_mask() and
> ->set_specific_mode() than having two somewhat overlapping callbacks?
> Or is there some problem that can't be handled that way?

I'm not sure I follow what you are suggesting - can you explain further.

Right now ->set_mode does all the policy management with regards to
picking the right modes which is sometimes done by the usual ATA rules
and sometimes by card specific code.

->set_specific_mode does no policy work but merely sets up a mode.

The default behaviour of ->set_mode() is the ATA mode selection by best
mode available, and this function is normally not provided by a driver.

The default behaviour of ->set_specific_mode() is to verify the mode is
valid then issue ->set_pio|dma_mode() (for both devices in case a timing
change on both is triggered). This function is overridable because of
things like IT821x where the IDE mode is imaginary.

Alan
