From: Richard Crewe <rcrewe@plxtech.com>
Subject: Soft-reset on a FIS-Based-Switching AHCI interface
Date: Mon, 12 Sep 2011 15:02:45 +0100
Message-ID: <4E6E1105.6060103@plxtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jupiter.oxsemi.com ([62.255.240.98]:45170 "EHLO
	jupiter.oxsemi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756913Ab1ILOeO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Sep 2011 10:34:14 -0400
Received: from mercury.oxsemi.com (mercury.oxsemi.com [192.168.8.11])
	by jupiter.oxsemi.com (8.12.11/8.12.11) with ESMTP id p8CE3B4F018451
	for <linux-ide@vger.kernel.org>; Mon, 12 Sep 2011 15:03:15 +0100
Received: from muttley.corp.oxsemi.com (muttley.corp.oxsemi.com [192.168.9.11])
	by mercury.oxsemi.com (8.12.11/8.12.11) with ESMTP id p8CE36AL020613
	for <linux-ide@vger.kernel.org>; Mon, 12 Sep 2011 15:03:06 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

The AHCI spec. seems to indicate that a soft-reset can only be performed 
if FBS is disabled.

Looking at the LibATA and LibAHCI code at the moment, I can't see where 
this is done. The soft-reset happens during error recovery when the port 
re-enumerates devices.

Am I missing something or is this a _relatively_ less-well tested area 
of the LibATA/AHCI operation?

-- 
Richard Crewe, Software Engineer
PLX Technology Ltd. Registered in England, company number 2733820
Registered Address: 25 Milton Park, Abingdon, Oxfordshire. UK. OX14 4SH

