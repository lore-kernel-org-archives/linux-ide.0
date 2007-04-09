From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: AHCI hot replace sdX incrementing
Date: Mon, 9 Apr 2007 10:43:59 -0700
Message-ID: <39B20DF628532344BC7A2692CB6AEE070127216E@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24035 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753247AbXDIRoE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Apr 2007 13:44:04 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello,

When I hot-remove a SATA HD in AHCI mode and then hot-plug the drive
back in again, the /dev/sdX number changes to the next available number.
Is this going to be a problem when using a RAID array that includes that
drive?

Thanks,

Jason
