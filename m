From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: CHRP PCI fixup for Pegasos IDE (looking for testers)
Date: Mon, 09 Jul 2007 16:00:31 +0100
Message-ID: <46924D8F.4060506@genesi-usa.com>
References: <46924C27.8020100@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mithrandir.softwarenexus.net ([66.98.186.96]:4740 "EHLO
	mail.genesi-usa.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169AbXGIO7k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 10:59:40 -0400
Received: from 82-46-178-156.cable.ubr06.king.blueyonder.co.uk ([82.46.178.156] helo=[192.168.2.228])
	by mail.genesi-usa.com with esmtpa (Exim 4.66 (FreeBSD))
	(envelope-from <matt@genesi-usa.com>)
	id 1I7uSK-000C5M-Sq
	for linux-ide@vger.kernel.org; Mon, 09 Jul 2007 14:43:17 +0000
In-Reply-To: <46924C27.8020100@genesi-usa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I should note it goes at the end of arch/powerpc/platforms/chrp/pci.c
under the Winbond native fix :)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Matt Sealey wrote:
> Hi guys,
> 
> Just a heads up here, I hammered out this little bit of code over the
> weekend which "solves" the Pegasos IDE problem by making PCI native
> mode work like PCI native mode should (it tweaks the ISA bridge to
> steer both IDE IRQs to 14)
> 
> http://www.powerdeveloper.org/files/Pegasos/ide_fixup.c
> 
> I definitely need someone to test it though. I can't compile it and
> I can't run it on a Pegasos here, and I am not sure if the fix is
> being done early enough (Alan said "before pci_setup_device"..).
> 
> It would be nice to see if this interacts with Tejun's patches just
> recently sent.
> 
