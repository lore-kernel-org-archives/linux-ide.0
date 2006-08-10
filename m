From: Jeff Garzik <jeff@garzik.org>
Subject: libata moved to drivers/ata
Date: Thu, 10 Aug 2006 07:58:08 -0400
Message-ID: <44DB1F50.5040302@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>, SCSI Mailing List <linux-scsi@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

I just moved all branches of libata-dev.git to drivers/ata.

Please test and make sure I didn't break anything.

In particular, the move highlighted where libata and ata-generic were 
incorrectly using drivers/scsi local headers.  That was fixed too.

	Jeff


