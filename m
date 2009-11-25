From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: not full working ata_piix
Date: Wed, 25 Nov 2009 10:43:12 +0000
Message-ID: <20091125104312.76d1b986@lxorguk.ukuu.org.uk>
References: <931603659.20091125091656@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47234 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758541AbZKYKlp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 05:41:45 -0500
In-Reply-To: <931603659.20091125091656@gmx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gorgone <gorgone@gmx.de>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

>     00:1f.2 SATA controller: Intel Corporation 82801GR/GH (ICH7 Family) SATA AHCI Controller (rev 01)
>     00:1f.2 0106: 8086:27c1 (rev 01)

This should be handled by the AHCI driver under the SATA configuration
options.
