From: girish <girishvg@gmail.com>
Subject: PCI/IDE generic IDE driver + bus master DMA logic errors
Date: Wed, 4 Oct 2006 19:07:58 +0900
Message-ID: <28EE04D1-1645-4D2C-9D8B-FB4877779223@gmail.com>
Mime-Version: 1.0 (Apple Message framework v749)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:50834 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030788AbWJDKIE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Oct 2006 06:08:04 -0400
Received: by py-out-1112.google.com with SMTP id n25so207982pyg
        for <linux-ide@vger.kernel.org>; Wed, 04 Oct 2006 03:08:04 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org


our hardware guys are designing an pci/ide controller which has  
interrupt wrapper such that the ide & bus master interrupts are  
packaged & delivered together.
according to current linux ide sub-system believe i have to do  
something like implement ide_ack_intr(). quite clear. would like to  
know how to escalate bus-master dma or device errors, on return from  
ide_ack_intr?

