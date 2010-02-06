From: Tim Small <tim@buttersideup.com>
Subject: Re: Corrupt data - RAID sata_sil 3114 chip
Date: Sat, 06 Feb 2010 15:16:47 +0000
Message-ID: <4B6D87DF.6030305@buttersideup.com>
References: <4B630914.9010503@fs.ei.tum.de> <4B6338E2.1040507@gmail.com> <4B6CE7E0.1060209@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([63.246.152.102]:38754 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab0BFPUE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Feb 2010 10:20:04 -0500
In-Reply-To: <4B6CE7E0.1060209@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, "Ulli.Brennenstuhl" <Ulli.Brennenstuhl@fs.ei.tum.de>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> It would be great if there's some knob we can turn in the controller
> PCI config space but I really have no idea whatsoever.  :-(
>   

I wonder if enabling EDAC PCI parity error detection would show up these
problems - either on the controller itself, or its upstream PCI bridge chip?

modprobe edac_core check_pci_errors=1

alternatively, "setpci -s <slot> STATUS" should also show status
register bit 15 having been asserted, I think, and lspci -vv should say
"<PERR+"

Cheers,

Tim.
