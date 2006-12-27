From: Richard Scobie <richard@sauce.co.nz>
Subject: sata_sil24 performance weirdness
Date: Thu, 28 Dec 2006 07:25:53 +1300
Message-ID: <4592BAB1.1050900@sauce.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.sauce.co.nz ([210.48.49.72]:57706 "EHLO smtp.sauce.co.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670AbWL0SQE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Dec 2006 13:16:04 -0500
Received: from [192.168.4.111] (unknown [192.168.4.111])
	by test.sauce.co.nz (Postfix) with ESMTP id 7DF30B387B
	for <linux-ide@vger.kernel.org>; Thu, 28 Dec 2006 07:09:18 +1300 (NZDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Robin H. Johnson wrote:

 >While dmesg claims that 3.0Gbps was negotiated, the combined 
 >performance of the 5 disks never exceeds 1.5Gbps, no matter how I 
 >combine them. Is something in the driver overriding the 3Gbps speed 
 >bits somewhere?

Perhaps there is a hardware/firmware issue with the Sil3132, as this has 
been reported at a reputable Mac hardware performance site, see:

http://www.barefeats.com/quick.html

The December 23rd entry, "ExpressCard SATA bandwidth woes" mentions 
exactly this issue with an Express card using the Sil3132 and on a 
Sil3132 based SATA Adaptor card.

Regards,

Richard
