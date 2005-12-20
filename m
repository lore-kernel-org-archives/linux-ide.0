From: Terrence Martin <tmartin@physics.ucsd.edu>
Subject: Kernel or patch suggestions for DMA enables Marvell Driver
Date: Tue, 20 Dec 2005 12:34:58 -0800
Message-ID: <43A86AF2.2080508@physics.ucsd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from newport.ucsd.edu ([132.239.73.89]:49643 "EHLO newport.ucsd.edu")
	by vger.kernel.org with ESMTP id S932080AbVLTUe6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Dec 2005 15:34:58 -0500
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by newport.ucsd.edu (8.13.1/8.13.1) with ESMTP id jBKKYwhT029635
	for <linux-ide@vger.kernel.org>; Tue, 20 Dec 2005 12:34:58 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I have tried several development kernels to try to get the DMA version 
of the  Marvell  SATA driver to work. The problem is that other problems 
with the kernels have made them unsuitable for use. For example I used 
the latest 2.6.14git kernel as well as the most recent patch for 
2.6.15-rc6. Both of which had problems.

Could someone suggest a version of the kernel that might work, or 
alternatively is it possible to extract the DMA supported driver itself 
for compilation in another version? For example 2.6.14.4.

The official kernel driver is the closest I have gotten to getting this 
controller supported on my system. The source code from Marvell and 
other sources seems to not want to compile at all.

Here is the card I have from lspci

03:04.0 RAID bus controller: Marvell Technology Group Ltd. MV88SX6041 
4-port SATA II PCI-X Controller (rev 03)

Thanks,

Terrence


