From: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
Subject: Re: FUA and DPO unsupported using sata_nv on MCP55?
Date: Mon, 09 Apr 2007 09:24:21 +0100
Message-ID: <1176107061.20487.5.camel@ukabzc383.uk.saic.com>
References: <1175778811.5181.9.camel@ukabzc383.uk.saic.com>
	 <4619EF07.5090008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpmx2.mail.saic.com ([139.121.17.172]:40681 "EHLO
	cpmx2.mail.saic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342AbXDIIYr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Apr 2007 04:24:47 -0400
In-Reply-To: <4619EF07.5090008@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi,

I'm glad to hear that my data is looking safe, although my XFS
filesystem reports "Disabling barriers, not supported by underlying
device" when I try to mount a RAID-1 of these two disks. I guess it's
something to do with the software raid code?

Anyway, thanks for the help, it's always a pleasure :)

Oh, I don't suppose anybody has any idea when the NCQ support might go
into the sata_nv driver? I seem to recall it was being talked about
months ago?

Cheers,
Eamonn


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

