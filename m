From: Michael Tokarev <mjt@tls.msk.ru>
Subject: SATA: Is "DPO and FUA" ever supported?
Date: Thu, 21 Jun 2007 17:30:02 +0400
Message-ID: <467A7D5A.9070009@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.94.6]:22245 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106AbXFUNhV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Jun 2007 09:37:21 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On each and every machine out there, and on every dmesg
output posted on numerous mailinglists, I see messages
similar to this:

scsi 0:0:0:0: Direct-Access     ATA      ST3250620NS      3.AE PQ: 0 ANSI: 5
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA

for SATA disk drives.  And I wonder -- are those features
supported at all by linux, and/or are there disk drives
out there which supports it as well?

For my Seagate ST3250620NS SATA drive (it's a "server" drive,
whatever it means), I can see -- at least --

           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT

reported by hdparm -I.  I wonder what "FLUSH CACHE EXT" means,
and whenever it can be used to support DPO and/or FUA...

Thanks.

/mjt
