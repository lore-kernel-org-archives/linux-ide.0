From: Tejun Heo <tj@kernel.org>
Subject: Re: storage-fixup
Date: Tue, 10 Nov 2009 00:05:15 +0900
Message-ID: <4AF82FAB.6050407@kernel.org>
References: <200910290056.49057.nouskas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33289 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753085AbZKIPFO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Nov 2009 10:05:14 -0500
In-Reply-To: <200910290056.49057.nouskas@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christos Nouskas <nouskas@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

Christos Nouskas wrote:
> Dell Vostro 1500, 250GB Seagate model ST9250827AS clicks. hdparm -B 254 
> fixes.

Isn't this entry already covered by the following entry in
storage-fixup.conf?

 # Reported drive model: ST9160821AS
 rule dell-Vostro-1500
 dmi system-manufacturer		Dell Inc.
 dmi system-product-name		Vostro 1500
 ata model				ST9*AS
 act hdparm -B 254 $DEV

Thanks.

-- 
tejun
