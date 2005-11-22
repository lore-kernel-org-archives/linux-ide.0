From: Andrew Joyce <joyce@webcreations.ca>
Subject: Re: VIA VT8251 support
Date: Tue, 22 Nov 2005 16:32:30 +0000 (UTC)
Message-ID: <loom.20051122T172918-9@post.gmane.org>
References: <4636434.1132656410238.JavaMail.root@pswm17.cp.tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:42429 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964994AbVKVQn7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Nov 2005 11:43:59 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Eeb97-0000X4-LX
	for linux-ide@vger.kernel.org; Tue, 22 Nov 2005 17:37:30 +0100
Received: from d226-53-149.home.cgocable.net ([24.226.53.149])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 22 Nov 2005 17:37:29 +0100
Received: from joyce by d226-53-149.home.cgocable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 22 Nov 2005 17:37:29 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

y3kniceday <at> tin.it <y3kniceday <at> tin.it> writes:
> 
> hi i have an asus a8v-mx motherboard with via vt8251 southbridge.
> my 
> dmesg says: VP_IDE: Unknown VIA SouthBridge, disabling DMA
> and i don't 
> have dma and sata support with latest kernel 2.6.X
> 
> it is vt8251 
> support planned?
> 
> Many thanks and sorry for my english

This message just means that the PCI ID needs to be added into the kernel so
that it recognizes the southbridge.  The VT8251 was only recently released and
it doesn't seem that support is available in the kernel for it yet;
theoretically, the AHCI driver should work but I don't know of anyone who has
had success with it yet.  If you check the mailing list archives
(http://news.gmane.org/gmane.linux.ide) you will find a couple of posts relating
to this chipset.

Andrew



