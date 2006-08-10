From: Jeff Garzik <jeff@garzik.org>
Subject: [SATA] max-sect and sii-m15w branches merged
Date: Thu, 10 Aug 2006 06:54:36 -0400
Message-ID: <44DB106C.6090504@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:25307 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161158AbWHJKyj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Aug 2006 06:54:39 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>

I just merged the max-sect and sii-m15w branches into the upstream branch.

This means that the following two changes are queued for 2.6.19:

* increase max sectors from 200 to 256 (for lba28)
* better mod15write support for sata_sil

