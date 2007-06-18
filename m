From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata: ATA_PIIX missing ICH8M PCIIDs.
Date: Mon, 18 Jun 2007 21:41:04 +0100
Message-ID: <20070618214104.20ddcac4@the-village.bc.nu>
References: <200706181520.06682.chunkeey@web.de>
	<39B20DF628532344BC7A2692CB6AEE07016FE47F@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55770 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1763449AbXFRUf0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 16:35:26 -0400
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE07016FE47F@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: Chr <chunkeey@web.de>, linux-ide@vger.kernel.org

On Mon, 18 Jun 2007 11:00:33 -0700
"Gaston, Jason D" <jason.d.gaston@intel.com> wrote:

> I don't think we want to have a PATA controller DID added to the SATA IDE mode driver.  

ata_piix drives both
