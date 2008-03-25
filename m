From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 0/2] libata: power usage patches
Date: Tue, 25 Mar 2008 15:27:58 -0700
Message-ID: <20080325152758.6ee5bb81@appleyard>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:54890 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753770AbYCYWjG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Mar 2008 18:39:06 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, arjan@linux.intel.com

Hi, 
The libata core leaves the phy powered on for unoccupied ports, costing
us about .75 Watts of extra power usage.  If the port is not hotpluggable,
there's no reason to leave the port powered on if there are no devices attached
after initial probe.

As I was investigating this issue I also ran across a bug in the ahci driver -
it sets PxCMD.ST without checking to see if any devices are attached.
thanks,
Kristen

-- 
