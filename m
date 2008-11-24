From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ata_pio_need_iordy vs. CF spec. V4.1
Date: Mon, 24 Nov 2008 17:45:21 +0000
Message-ID: <20081124174521.491e727b@lxorguk.ukuu.org.uk>
References: <492AE6FA.5000809@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47420 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752734AbYKXRpL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Nov 2008 12:45:11 -0500
In-Reply-To: <492AE6FA.5000809@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, 24 Nov 2008 09:40:10 -0800
David Daney <ddaney@caviumnetworks.com> wrote:

> Table 22 on page 51 of CF Specification Rev. 4.1 indicates that iordy is 
> not supported in PIO5 and PIO6.  This seems to be in conflict with the 
> code in ata_pio_need_iordy, which asserts that it is mandatory in any 
> mode greater than PIO2.
> 
> Which is correct?  Or am I misreading something?

The ATA spec says that modes > PIO2 requires IORDY

The CFI spec does indeed say PIO5/6 do not use IORDY so probably you
should tweak that function at least for CFA devices.

Alan

