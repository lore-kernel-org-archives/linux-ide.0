From: Marek Podmaka <marki@marki-online.net>
Subject: AHCI and add_disk_randomness()
Date: Wed, 15 Nov 2006 22:01:30 +0100
Message-ID: <1124564609.20061115220130@marki-online.net>
Reply-To: Marek Podmaka <marki@marki-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kenny.oneemedia.com ([85.248.115.102]:40673 "EHLO
	kenny.oneemedia.com") by vger.kernel.org with ESMTP
	id S1030734AbWKOVBf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Nov 2006 16:01:35 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello,

  I have server with Intel 5000V motherboard with integrated AHCI SATA
  controller. It works well with kernel 2.6.18.2. But I have problem
  with little entropy available and I'm not sure if one of the reasons
  is that AHCI driver does not use add_disk_randomness() to contribute
  to the kernel entropy pool.

  I'm not very skilled on kernel "hacking"... I tried finding where
  this is called (it's defined in drivers/char/random.c and used for
  example in Comapaq SmartArray driver in drivers/block/cciss.c). For
  the SCSI part, I found it in scsi_lib.c, but I was not able to
  determine if this is actually used by ahci/libata drivers.

  If not, would it be possible to implement it? I tried to figure out
  where to call it by looking at cciss.c, but it seems that this is
  totally different case, at least for me. I don't know where to add
  it, because its parameter is struct gendisk *disk and didn't find it
  used anywhere in ahci or libata.

-- 
  bYE, Marki


