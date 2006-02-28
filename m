From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [ltp] ICH6M legacy hotswap?
Date: Tue, 28 Feb 2006 20:26:42 +0000
Message-ID: <20060228202642.GA15624@srcf.ucam.org>
References: <41840b750602280135j511a7584m80b0b1f549780bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:46255 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932482AbWB1U1C (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Feb 2006 15:27:02 -0500
Content-Disposition: inline
In-Reply-To: <41840b750602280135j511a7584m80b0b1f549780bf@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-thinkpad@linux-thinkpad.org
Cc: linux-ide@vger.kernel.org

On Tue, Feb 28, 2006 at 11:35:45AM +0200, Shem Multinymous wrote:

> Is there currently any kludge/patch/hack for hot/warm/cold swapping on
> the PATA port of ICH6M in legacy mode with ata_piix/libata? Or a way
> to switch the ICH6M to AHCI mode (in the absence of BIOS support) and
> then get AHCI hot/warm/coldwap?

To the best of my knowledge, there is no way to get an ICH6 into AHCI 
mode if the BIOS has set it up in legacy mode. I wrote some code that 
basically does what lt_hotswap does for SATA devices that worked fine on 
my ICH6 test machine (a Dell rather than a Thinkpad, but shouldn't 
matter in this case), but it needs much more polish before it's 
integratable.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
