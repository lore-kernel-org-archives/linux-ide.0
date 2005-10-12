From: Jeff Garzik <jgarzik@pobox.com>
Subject: SCSI EH tidbit
Date: Wed, 12 Oct 2005 11:05:30 -0400
Message-ID: <434D263A.1070708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:9188 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964802AbVJLPFk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2005 11:05:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Tejun Heo <htejun@gmail.com>


I'm thinking that __scsi_done() might be more appropriate than 
scsi_finish_command(), for use in completing commands in the EH path. 
There may need to be some timer-related mods somewhere to make that 
work, though.

	Jeff



