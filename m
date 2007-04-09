From: Tejun Heo <htejun@gmail.com>
Subject: Re: FUA and DPO unsupported using sata_nv on MCP55?
Date: Mon, 09 Apr 2007 16:45:11 +0900
Message-ID: <4619EF07.5090008@gmail.com>
References: <1175778811.5181.9.camel@ukabzc383.uk.saic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:36942 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbXDIHpT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Apr 2007 03:45:19 -0400
Received: by wr-out-0506.google.com with SMTP id 71so816436wri
        for <linux-ide@vger.kernel.org>; Mon, 09 Apr 2007 00:45:18 -0700 (PDT)
In-Reply-To: <1175778811.5181.9.camel@ukabzc383.uk.saic.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
Cc: linux-ide@vger.kernel.org

Eamonn Hamilton wrote:
> Hi,
> 
> I've got a couple of Samsung HD501LJ drives attached to a KN9 Ultra
> board using the MCp55 chipset, and I'm getting an NCQ depth of 0
> reported at boot, which as I understand it is because support for NCQ
> isn't in the sata_nv driver yet for this chipset.
> 
> ata1.00: ATA-7, max UDMA7, 976773168 sectors: LBA48 NCQ (depth 0/32)
> ata2.00: ATA-7, max UDMA7, 976773168 sectors: LBA48 NCQ (depth 0/32)

Yeap.

> Later in the boot, however, I get 
> SCSI device sda: write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> SCSI device sda: write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> 
> which as I understand it means my data ( plus the wifes picture
> archive! ) is at risk, as I have write cache enabled and barrier support
> is disabled because of the lack of FUA. Is this caused by my drives, or
> is there something I need to enable?

Nothing is in danger.  FUA just speeds up barrier a tad bit.  Doesn't
matter really.

-- 
tejun
