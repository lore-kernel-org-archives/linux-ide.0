From: hadmut@danisch.de (Hadmut Danisch)
Subject: BIOS does not recognize 500GB-disk
Date: Wed, 4 Jul 2007 00:55:17 +0200
Message-ID: <20070703225517.GA22912@danisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sklave3.rackland.de ([88.198.248.38]:58511 "EHLO
	sklave3.rackland.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739AbXGCXDu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 19:03:50 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

just a question:

I have an older computer with a ASRock K7VT4A Pro mainboard and a VIA sata
controller. 

A 320GB Seagate SATA disk worked pretty well with that board, but now I replaced
it with a 500GB Western Digital SATA, and the BIOS does not recognize that
new disk, allthough I've updated the BIOS to the latest available version.
The disk is not available under Linux (latest Ubuntu, 2.6.20). 

I guess it is a BIOS problem, since the disk works in a different, newer
machine with a newer mainboard. 

Is there any way to have Linux to ignore the BIOS and to access that disk
even if the BIOS didn't recognize it?

regards
Hadmut


 
