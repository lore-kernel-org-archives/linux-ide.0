From: "Kien Pham" <kienca@lycos.com>
Subject: ATAPI Support Broken
Date: Tue, 11 Jan 2005 22:35:13 -0500
Message-ID: <20050112033513.F01CFCA07A@ws7-4.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:37770 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S261354AbVALDfY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Jan 2005 22:35:24 -0500
Received: from wfilter.us4.outblaze.com (wfilter.us4.outblaze.com [205.158.62.180])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id 21A4E18001CE
	for <linux-ide@vger.kernel.org>; Wed, 12 Jan 2005 03:35:23 +0000 (GMT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

Tried SATA (libata) ATAPI support on both an Intel ICH 5 chipset and a Silicon Image 3112 chipset. Seems to lockup at the same place. Debug dumps from dmesg available on request. Any hints on how to proceed to debug would be appreciated.

~K.P.
-- 
_______________________________________________
Find what you are looking for with the Lycos Yellow Pages
http://r.lycos.com/r/yp_emailfooter/http://yellowpages.lycos.com/default.asp?SRC=lycos10

