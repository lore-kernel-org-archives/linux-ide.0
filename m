From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] [resend] Resume from hibernation fails with pata_it821x
 RAID volume
Date: Fri, 6 Feb 2009 17:56:35 +0000
Message-ID: <20090206175635.5344ce37@lxorguk.ukuu.org.uk>
References: <200902061412.09839.linux@rainbow-software.org>
	<498C778B.7020309@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40080 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760488AbZBFR4R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Feb 2009 12:56:17 -0500
In-Reply-To: <498C778B.7020309@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Ondrej Zary <linux@rainbow-software.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

>     See CodingStyle chapter 8 for the preferred multiline comment style.
> 
> > +		memset(&id[ATA_ID_SERNO], 0x20, ATA_ID_SERNO_LEN);
> 
>     Why not ' '?
> 
> MBR, Sergei


Digging into the docs the RAID serial number (and what that means isn't
defined anywhere I can see) is byte offset 54-73 in each of the 4 128
byte blocks returned by the chip status query we do at boot
(it821x_probe_firmware).

Alan
