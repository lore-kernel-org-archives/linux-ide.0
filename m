From: Jeff Garzik <jeff@garzik.org>
Subject: On the subject of DRQ and EH...
Date: Fri, 31 Mar 2006 19:31:35 -0500
Message-ID: <442DC9E7.5000203@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51658 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932358AbWDAAbj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 19:31:39 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

grep for try_to_flush_leftover_data in drivers/ide.

	Jeff


