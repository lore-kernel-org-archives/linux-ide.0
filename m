From: Ognyan Kulev <ogi@fmi.uni-sofia.bg>
Subject: Re: [BUG] OPTi 621, chipset revision 18, hangs with enabled DMA
Date: Sun, 01 Aug 2004 08:55:51 +0300
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <410C85E7.1070300@fmi.uni-sofia.bg>
References: <410B8555.6090209@fmi.uni-sofia.bg> <410BABE7.1040005@fmi.uni-sofia.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dig-image.evro.net ([80.72.64.50]:40964 "EHLO
	batman.fmi.uni-sofia.bg") by vger.kernel.org with ESMTP
	id S264843AbUHAFuS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Aug 2004 01:50:18 -0400
Received: from fmi.uni-sofia.bg (localhost [127.0.0.1])
	by batman.fmi.uni-sofia.bg (Postfix) with ESMTP id 9DFC2151
	for <linux-ide@vger.kernel.org>; Sun,  1 Aug 2004 08:55:52 +0300 (EEST)
In-Reply-To: <410BABE7.1040005@fmi.uni-sofia.bg>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Ognyan Kulev wrote:
> Alexander Atanasov replied to me privately and said it seems that 
> OPTi621 doesn't support DMA.  But after searching in Google, it looks 
> that there is some OPTi621 that supports DMA, although not 100% confirmed:

I've found the following code in NetBSD's src/sys/dev/pci/optiide.c:

	aprint_normal("%s: bus-master DMA support present",
	    sc->sc_wdcdev.sc_dev.dv_xname);

	/*
	 * XXXSCW:
	 * There seem to be a couple of buggy revisions/implementations
	 * of the OPTi pciide chipset. This kludge seems to fix one of
	 * the reported problems (PR/11644) but still fails for the
	 * other (PR/13151), although the latter may be due to other
	 * issues too...
	 */
	if (PCI_REVISION(pa->pa_class) <= 0x12) {
		aprint_normal(" but disabled due to chip rev. <= 0x12");
		sc->sc_dma_ok = 0;
	} else
		pciide_mapreg_dma(sc, pa);

The relevant PRs are:

http://www.netbsd.org/cgi-bin/query-pr-single.pl?number=11644
http://www.netbsd.org/cgi-bin/query-pr-single.pl?number=13151

Notice that revision of my OPTi is 18 (0x12, which is <= 0x12).  As 
scw@netbsd says in PR/13151, he developed the driver on revision 0x30, 
so I guess this "revision <= 0x12" check is the best we've got for now.

FreeBSD doesn't have anything special for this IDE: 
http://www.freebsd.org/releases/5.2.1R/hardware-i386.html#AEN65

Regards,
ogi
