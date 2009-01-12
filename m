From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] pata_via.c: Support VX855 and future chips whose
 IDE controller use 0x0571.
Date: Mon, 12 Jan 2009 11:02:04 +0000
Message-ID: <20090112110204.67e3ff72@lxorguk.ukuu.org.uk>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8087369D7@exchtp03.taipei.via.com.tw>
	<496B226E.60108@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:32995 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752299AbZALLCW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jan 2009 06:02:22 -0500
In-Reply-To: <496B226E.60108@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: JosephChan@via.com.tw, linux-ide@vger.kernel.org, HaraldWelte@viatech.com, tj@kernel.org, BruceChang@via.com.tw

>    Why not:
> 
> 	if (pdev->device == 0xC409)
> 		if (ap->port_no == 0) {
> 			pci_read_config_dword(pdev, 0x52, &ata66);

More to the point - why not just register it as a single port device ?
