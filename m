From: Vedran Rodic <vedran@vodatel.hr>
Subject: Detecting CDROM Eject key press
Date: Wed, 06 Oct 2004 14:40:02 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4163E7A2.9060402@vodatel.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dnscache3.vodatel.hr ([217.14.208.34]:34244 "EHLO
	dns1.vodatel.hr") by vger.kernel.org with ESMTP id S269248AbUJFMlB
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Oct 2004 08:41:01 -0400
Received: from qs1.vodatel.hr (unknown [192.168.97.26])
	by dns1.vodatel.hr (Postfix) with SMTP id 1929348C44
	for <linux-ide@vger.kernel.org>; Wed,  6 Oct 2004 14:50:12 +0200 (CEST)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello

Can I detect that CDROM Eject key has been pressed when the cdrom is 
mounted and the CDROM door is locked?

This, together with kernel notifying me of CDROM status changes (cdrom 
has media, cdrom is empty) would completely solve the cdrom automount 
issues.

Userspace program then could detect that the eject key has been pressed, 
close files on the media, and do a clean unmount.


Thanks


Vedran Rodic
