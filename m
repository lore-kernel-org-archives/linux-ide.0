From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_sil24 EH complete
Date: Wed, 06 May 2009 09:32:24 +0900
Message-ID: <4A00DA98.5060201@kernel.org>
References: <alpine.DEB.2.00.0905060004100.15177@dirac.rather.puzzling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54736 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753038AbZEFAck (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 May 2009 20:32:40 -0400
In-Reply-To: <alpine.DEB.2.00.0905060004100.15177@dirac.rather.puzzling.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Connors <tconnors@rather.puzzling.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Tim Connors wrote:
> With 2.6.29, when I hotplug a western digital mybook into a 'Silicon
> Image, Inc. SiI 3132 Serial ATA Raid II Controller', the drive is not
> found:
> 
> 
> *** drive failed due to user induced sillyness
> ...
> [18676.308750] sd 0:0:0:0: [sdb] Stopping disk
> [18676.308770] sd 0:0:0:0: [sdb] START_STOP FAILED
> [18676.308774] sd 0:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
> *** drive plugged back in
> [18767.821747] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
> [18767.821756] ata1: irq_stat 0x00b40090, PHY RDY changed
> [18767.821775] ata1: hard resetting link
> [18774.633185] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> [18774.773591] ata1.00: applying link speed limit horkage to 1.5 Gbps
> [18779.655674] ata1: hard resetting link
> [18781.861074] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
> [18782.178565] ata1.00: configured for UDMA/100
> [18782.178579] ata1: EH complete
> 
> And then nothing.  The device is still alive - if I plug it back in
> through its usb interface, it comes up normally.  I know from experience
> that if I was to reboot the machine, it would have come up quite nicely
> from boot:

Hmm... "ata1.00: configured for UDMA/100" means libata part of
configuration went okay but it looks like SCSI probing didn't kick in
for reason.  Is this always reproducible?

Thanks.

-- 
tejun
