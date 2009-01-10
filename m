From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Support for Marvel 6141 in ahci.c
Date: Sat, 10 Jan 2009 12:24:38 +0000
Message-ID: <20090110122438.0992c319@lxorguk.ukuu.org.uk>
References: <49686AE8.1050209@digadd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36524 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751361AbZAJMYV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Jan 2009 07:24:21 -0500
In-Reply-To: <49686AE8.1050209@digadd.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Christian P. Schmidt" <schmidt@digadd.de>
Cc: linux-ide@vger.kernel.org

On Sat, 10 Jan 2009 12:31:20 +0300
"Christian P. Schmidt" <schmidt@digadd.de> wrote:

> Hi all,
> 
> The Marvell 6141
> 08:00.0 SATA controller: Marvell Technology Group Ltd. 88SE614x SATA II PCI-E controller (rev 01)
> 08:00.0 0106: 11ab:6141 (rev 01)
> seems to work with the ahci driver with the attached patch:

Try using the PATA port.

For 2.6.29 we can probably add this ID to AHCI now as our AHCI code
ignores Marvell devices when the pata_marvell driver is present.

Alan
