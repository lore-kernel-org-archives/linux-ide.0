From: Tejun Heo <htejun@gmail.com>
Subject: [QUESTION] in ata_scsi_pass_thru()
Date: Wed, 30 Nov 2005 16:39:46 +0900
Message-ID: <438D5742.3000804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.200]:15804 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751104AbVK3Hjx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Nov 2005 02:39:53 -0500
Received: by zproxy.gmail.com with SMTP id 14so1855944nzn
        for <linux-ide@vger.kernel.org>; Tue, 29 Nov 2005 23:39:53 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: russb@emc.com, Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>

Hi, all.

In the translation function ata_scsi_pass_thru(), when it determines 
that the command cannot be translated and should be finished early, it 
does NOT set sense data or result code.  This seems buggy.  Is this 
intentional?

Thanks.

-- 
tejun
