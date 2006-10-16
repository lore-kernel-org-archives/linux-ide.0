From: Len Brown <len.brown@intel.com>
Subject: hdparm -C on SATA always prints "standby"
Date: Mon, 16 Oct 2006 11:36:04 -0400
Message-ID: <200610161136.04754.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:63110 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1422660AbWJPPd5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Oct 2006 11:33:57 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, bltk-discussion@lists.sourceforge.net

hdparm -C seems to work on the PATA laptops I have,
but it always returns standby on the SATA laptops I have.

Is this a known issue?

thanks,
-Len
