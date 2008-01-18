From: kfc@10k.org
Subject: libata makes SATA 40xDVDRW appear as 0xCDROM
Date: Fri, 18 Jan 2008 16:45:58 -0500 (EST)
Message-ID: <Pine.BSO.4.64.0801181631210.2837@transpose.10k.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bruno.cs.columbia.edu ([128.59.18.129]:48348 "EHLO
	bruno.cs.columbia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758568AbYARVqa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jan 2008 16:46:30 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello, Jeff:

I am on an Nforce4-Ultra board with a mix of ATA/SATA
disk drives and a SATA burner(GSA-H30L), while the
writer has been working well under a 2.6.16 kernel
with the old IDE-SATA driver. My recent upgrade to
2.6.23 resulted the drive being identified as a 0xCDROM
drive(I have disabled the entire IDE branch and am now
only using the libata drivers). Same result on an unpatched
2.6.24-rc7 kernel. An extended discussion can be found here

http://forums.gentoo.org/viewtopic-t-644915.html

would you please shed some light on this?

Thank you, Jake
