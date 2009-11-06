From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Check for broken HP bioses in ahci.c appears too broad
Date: Fri, 6 Nov 2009 16:28:24 +0000
Message-ID: <20091106162824.GA23611@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44777 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385AbZKFQ20 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Nov 2009 11:28:26 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, heinzm@redhat.com

https://bugzilla.redhat.com/show_bug.cgi?id=533402 describes a case 
where a machine is falling foul of the hp dv6 check in ahci.c. However, 
BIOS version F.04 appears to be the latest available for this machine - 
I suspect that the dv6 parameter is too broad and is picking up machines 
outside those with the affected BIOSes.

Heinz, could you attach the contents of 
/sys/devices/virtual/dmi/id/product_name, 
/sys/devices/virtual/dmi/id/product_version and 
/sys/devices/virtual/dmi/id/bios_*?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
