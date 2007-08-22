From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: no need to add new DID's to AHCI driver?
Date: Wed, 22 Aug 2007 11:19:00 -0700
Message-ID: <39B20DF628532344BC7A2692CB6AEE0701AE8117@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:42451 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761628AbXHVSTR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 14:19:17 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

Hello,

Now that the AHCI driver has support for all controllers with the 0x0106
(AHCI) class code, I am not planning on adding controller DeviceID's for
AHCI controllers.  I want to verify that this is the correct course of
action.

Note:  I still will have to add the Intel SW "RAID" controller
DeviceID's as they have a 0x0104 (RAID) class code.

Thanks,

Jason
