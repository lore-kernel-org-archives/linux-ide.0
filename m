From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: HPA patches
Date: Wed, 28 Mar 2007 21:08:29 +0100
Message-ID: <20070328200829.GA12776@srcf.ucam.org>
References: <20070323191321.5d00887a@lxorguk.ukuu.org.uk> <20070328000851.GA25551@srcf.ucam.org> <20070328105754.72b578bd@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:60673 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965748AbXC1UIk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Mar 2007 16:08:40 -0400
Content-Disposition: inline
In-Reply-To: <20070328105754.72b578bd@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kyle@canonical.com

On Wed, Mar 28, 2007 at 10:57:54AM +0100, Alan Cox wrote:

> Ok thanks. This is interesting as the only thing new it is doing is
> asking for the HPA size. Does I think explain the problem however: Can
> you move the HPA setting call to after the mode has been set and see if
> that makes the problem vanish ?

Hm. I tried adding it in the eh code after ata_set_mode() in 
ata_eh_recover(), which alters the problem slightly - hpa_sectors is 
still 0, so the taskfile call is still failing, but now the system just 
stops at around the time that anything attempts to access sda with no 
errors other than

sd: 2:0:1:0: timing out command, waited 180s
sd: 2:0:1:0: SCSI error: return code = 0x00000028
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0

-- 
Matthew Garrett | mjg59@srcf.ucam.org
