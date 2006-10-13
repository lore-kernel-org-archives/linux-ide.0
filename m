From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] ahci updates regarding vt8251 support
Date: Fri, 13 Oct 2006 11:18:08 +0900
Message-ID: <11607058883329-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:46449 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751506AbWJMCSR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Oct 2006 22:18:17 -0400
Received: by ug-out-1314.google.com with SMTP id o38so390722ugd
        for <linux-ide@vger.kernel.org>; Thu, 12 Oct 2006 19:18:16 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, aalderd.boac@wanadoo.nl, linux-ide@vger.kernel.org, htejun@gmail.com

Hello,

This patchset updates libata and ahci to improve vt8251 EH and hotplug
support.

#01 : separate out sata_port_hardreset(), to be used by vt8251 reset
#02 : update CLO handling in softreset and kill RESET_NEEDS_CLO
#03 : update vt8251 support in ahci

This patchset is against the current #upstream
(da54f5fe54c7d75e2db7d17961fb36a8c28a8501).

Aalderd, can you test this patchset?

Thanks.

--
tejun


