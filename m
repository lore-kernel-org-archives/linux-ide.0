From: Ognyan Kulev <ogi@fmi.uni-sofia.bg>
Subject: Re: [BUG] OPTi 621, chipset revision 18, hangs with enabled DMA
Date: Sat, 31 Jul 2004 17:25:43 +0300
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <410BABE7.1040005@fmi.uni-sofia.bg>
References: <410B8555.6090209@fmi.uni-sofia.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dig-image.evro.net ([80.72.64.50]:22276 "EHLO
	batman.fmi.uni-sofia.bg") by vger.kernel.org with ESMTP
	id S267704AbUGaOUP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 31 Jul 2004 10:20:15 -0400
Received: from fmi.uni-sofia.bg (localhost [127.0.0.1])
	by batman.fmi.uni-sofia.bg (Postfix) with ESMTP id 0533B1074
	for <linux-ide@vger.kernel.org>; Sat, 31 Jul 2004 17:25:43 +0300 (EEST)
In-Reply-To: <410B8555.6090209@fmi.uni-sofia.bg>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Ognyan Kulev wrote:
> After adding "ide=nodma", everything works fine.

Alexander Atanasov replied to me privately and said it seems that 
OPTi621 doesn't support DMA.  But after searching in Google, it looks 
that there is some OPTi621 that supports DMA, although not 100% confirmed:

http://seclists.org/lists/linux-kernel/2002/Sep/2187.html
http://seclists.org/lists/linux-kernel/2002/Sep/2428.html

Is there reliable way to test if IDE controller suports DMA?  I can test 
patches, but after some weeks, because I don't have the laptop right now.

BTW My problem is that same as described in 
http://www.mail-archive.com/redhat-list@redhat.com/msg82172.html 
(revision 18 too!)

Regards,
ogi
