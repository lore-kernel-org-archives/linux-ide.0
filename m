From: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Subject: how to flush write back cache of storage driver
Date: Tue, 29 Dec 2009 11:20:03 +0800
Message-ID: <1EC975D79B8B1F4BBDC50EA54418A004071E7344C4@shzsmsx501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51158 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638AbZL2DSv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Dec 2009 22:18:51 -0500
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

To my understanding, the 'sync' shell command is not aware of the existence of write-back cache in the block device driver layer. 
So, if a storge driver (ide, scsi hard disk, nand flash disk and so on) uses write-back cache, then even if user executes 'sync' before power off the hardware,
there's still the possibilities that the cached data are not really write back into the block device.

I'm not sure whether there are any storage drivers in Linux kernel use write-back caches or not. If any, can someone give me an example and tell me how it handles the issue of write-back cache flush? That is, how to ensure the data not lost if user executes 'sync' and then power off the hardware? Thanks a lot.

Best Regards,
Yunpeng
