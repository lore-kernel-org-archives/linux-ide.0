From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 0/4] Updated SATA Link Power Management patches
Date: Thu, 9 Aug 2007 14:23:31 -0700
Message-ID: <20070809142331.df657d05.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37561 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757429AbXHIV0X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Aug 2007 17:26:23 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: htejun@gmail.com, akpm@linux-foundation.org, arjan@linux.intel.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello,
Here are some updated ALPM patches.  These patches are different from the
last version in that they now use the error handler to enable link power
management.  Please review and let me know what you think.

Kristen

-- 
