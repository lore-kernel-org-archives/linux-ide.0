From: Tom Herbert <herbert@vanteon.com>
Subject: Intel 31244
Date: Thu, 09 Dec 2004 10:23:06 -0500
Message-ID: <41B86DDA.6000204@vanteon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [64.80.217.99] ([64.80.217.99]:43635 "EHLO RDC03.vanteon.com")
	by vger.kernel.org with ESMTP id S261535AbULIPWg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Dec 2004 10:22:36 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: herbert@infosecuresystems.com, jgarzik@pobox.com

Jeremy,

Hi.

I am working on a project to update an embedded RAID controller to use 
the Intel 31244 chip. I would like to use the sata_vsc driver as an 
alternative to the Intel sample sources. There are very recent comments 
in various places in the driver code and at 
http://www.linuxmafia.com/faq/Hardware/sata.html#via suggesting that the 
Vitesse VSC7174 chip is compatible. This also appears to be likely  
after a preliminary comparision of the code with the 31244 Intel docs.

Before I jump in and commit to using this driver, I would appreciate it 
if you or Jeff have any information as to whether the sata_vsc chip has 
been tested yet with the Intel chip.

Thanks,

--Tom Herbert
herbert@infosecuresystems.com
