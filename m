From: Jeff Garzik <jeff@garzik.org>
Subject: libata-dev.git rebased
Date: Fri, 01 Dec 2006 23:36:47 -0500
Message-ID: <457102DF.5020407@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44717 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1162774AbWLBEgw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Dec 2006 23:36:52 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@osdl.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

I just rebased all branches of libata-dev.git, and there was a bit of 
fallout:

1) Dan, I'll have to ask you to resend your sata_vsc MSI patch yet 
again, this time against 2.6.19.  Since it was against 
drivers/scsi/sata_vsc.c, that caused some cross-directory-move related 
problems.

2) Tejun, I'll have to ask you to rebase your 'upstream' branch again.

Here are the commits, so that you know when it has mirrored out to the 
kernel.org farm successfully:

[jgarzik@pretzel libata-dev]$ cat .git/refs/heads/upstream 
.git/refs/heads/ALL
664e8503fee2f299d0f96eaab0f5f8fae8fad325
f2e07d8e550dd4e6155ee8bf6b691c323ffb729f
