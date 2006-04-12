From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.17-rc1-mm2 1/1] ahci: add support for VIA VT8251
Date: Wed, 12 Apr 2006 18:27:58 -0400
Message-ID: <443D7EEE.3020102@garzik.org>
References: <200604111915.45564.b.jacques@planet.nl> <200604122259.05546.b.jacques@planet.nl> <443D7527.6050805@garzik.org> <200604130019.28671.b.jacques@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47285 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932360AbWDLW2A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Apr 2006 18:28:00 -0400
In-Reply-To: <200604130019.28671.b.jacques@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bastiaan Jacques <b.jacques@planet.nl>
Cc: linux-ide@vger.kernel.org

Bastiaan Jacques wrote:
> Adds AHCI support for the VIA VT8251.
> 
> Includes a workaround for a hardware bug which requires a Command List
> Override before reset.
> 
> Signed-off-by: Bastiaan Jacques <b.jacques@planet.nl>

ACK.

It doesn't currently apply to branch 'upstream'[1] of libata-dev.git. 
Can you send a patch against that?

	Jeff



[1] 26ec634c31a11a003040e10b4d650495158632fd
