From: Jeff Garzik <jgarzik@pobox.com>
Subject: queued_cmd ownership
Date: Fri, 11 Nov 2005 05:58:20 -0500
Message-ID: <4374794C.6010701@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:16519 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932356AbVKKK6Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Nov 2005 05:58:24 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Albert Lee <albertcc@tw.ibm.com>


I think we need to go to an alloc/free model for ata_queued_cmd, so that 
the creator can own the results after the queued_cmd is complete.

	Jeff



