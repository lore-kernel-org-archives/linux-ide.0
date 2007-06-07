From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/6] libata: ATA passthru fixes
Date: Thu, 07 Jun 2007 15:44:39 +0800
Message-ID: <4667B767.5060601@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:52208 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbXFGHpD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jun 2007 03:45:03 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l577j2Ya028788
	for <linux-ide@vger.kernel.org>; Thu, 7 Jun 2007 03:45:02 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l577j2b3107084
	for <linux-ide@vger.kernel.org>; Thu, 7 Jun 2007 01:45:02 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l577j13D004739
	for <linux-ide@vger.kernel.org>; Thu, 7 Jun 2007 01:45:02 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>

1/6: update protocol numbers
2/6: support PIO multi commands
3/6: map UDMA protocols
4/6: always enforce correct DEV bit
5/6: support ATAPI devices
6/6: update cached device parameters

Patch against the libata-dev tree for your review, thanks.

