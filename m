From: Mark Lord <liml@rtr.ca>
Subject: hdparm-9.2 now available:  w/ DCO and firmware support
Date: Mon, 03 Nov 2008 13:17:20 -0500
Message-ID: <490F4030.5030709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:55155 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbYKCSQl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Nov 2008 13:16:41 -0500
Received: from [10.0.0.6] (corey.localnet [10.0.0.6])
	by mail.rtr.ca (Postfix) with ESMTP id 5AC3394672F
	for <linux-ide@vger.kernel.org>; Mon,  3 Nov 2008 13:17:21 -0500 (EST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

hdparm v9.2 is now available from sourceforge.

	http://sourceforge.net/projects/hdparm/

New since v8.9 are:

1. Support for Device Configuration Overlay (DCO),
   with the --dco-identify, --dco-freeze, and --dco-restore flags.
   DCO is a feature set that enables vendors/OEMs to disable/hide
   certain drive features (eg. NCQ, LBA48, ..) for whatever reason
   (eg. compatibility with a specific b0rked BIOS).
   This release of hdparm can display/reset DCO, but not selectively
   disable features yet.

2. Support for firmware download (upgrade) using the
   standard ATA DOWNLOAD_MICROCODE protocols 7 (preferred) and 3.
   This is initiated via the new --fwdownload flag,
   or the --fwdownload80 flag for a non-standard final packet
   (needed by some vendors).

3. Fixed WorldWideName display, and added cache-size display in -I output.

4. Detect/warn of kernel driver bugs in -N output.
   Eg. sata_sil24 misbehaves here in 2.6.25, but is fine in 2.6.27.

5. General fixes and tidiness in the sg16 routines.

Enjoy.
