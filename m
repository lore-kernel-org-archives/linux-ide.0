From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Deal with ATA8-ACS proposed Trusted/Treacherous
 Computing features
Date: Tue, 30 Oct 2007 09:58:01 -0400
Message-ID: <47273869.50508@garzik.org>
References: <20071012173918.3f6d2760@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57973 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753391AbXJ3N6E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 09:58:04 -0400
In-Reply-To: <20071012173918.3f6d2760@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> Historically word 48 in the identify data was used to mean 32bit I/O was
> supported for VLB IDE etc. ATA8 reassigns this word to the Trusted
> Computing Group, where it is used for TCG features. This means that an
> ATA8 TCG drive is going to trigger 32bit I/O on some systems which will
> be funny. Perhaps thats why T13 gave them the word.
> 
> Anyway we need to sort this out ready for ATA8 so:
> - Reorder the ata.h header a bit so the ata_version function occurs early
> in it
> - Make dword_io check the ATA version
> - Add an ATA8 version checking TCG presence test
> 
> While we are at it the current drafts have a flaw where it may not be
> possible to disable TCG features at boot (and opt out of the trusted
> model) as TCG intends because it relies on presence of a different
> optional feature (DCS). Handle this in software by refusing the TCG
> commands if libata.allow_tpm is not set. (We must make it possible as
> some environments such as proprietary VDR devices will doubtless want to
> use it to lock up content)
> 
> Finally as with CPRM print a warning so that the user knows they may not
> be able to full access and use the device.
> 
> Alan
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

would you rediff against latest torvalds/linux-2.6.git pretty please?


