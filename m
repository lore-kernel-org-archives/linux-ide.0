From: Jeff Garzik <jgarzik@pobox.com>
Subject: [RFT] ICH5 SATA in latest 2.6-bk snapshot
Date: Wed, 23 Jun 2004 16:11:54 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40D9E40A.8090906@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47581 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266656AbUFWUMI
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Jun 2004 16:12:08 -0400
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Cc: andersen@codepoet.org


The libata update in the latest -bk snapshot has updated interrupt 
acknowledgement code, that may address the problems some were seeing 
with an abnormally high amount of interrupts.


