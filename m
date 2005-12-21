From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
Subject: Re: Kernel or patch suggestions for DMA enables Marvell Driver
Date: Wed, 21 Dec 2005 14:55:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512211451500.7522@dingo.iwr.uni-heidelberg.de>
References: <43A86AF2.2080508@physics.ucsd.edu> <E1EooUH-0008VA-Vj@highlab.com>
 <43A87273.2060403@physics.ucsd.edu> <43A88218.1040205@physics.ucsd.edu>
 <E1Eoq94-00009u-SS@highlab.com> <43A8BF6B.1090006@physics.ucsd.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:43203 "EHLO
	relay2.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S932409AbVLUNzz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Dec 2005 08:55:55 -0500
In-Reply-To: <43A8BF6B.1090006@physics.ucsd.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Terrence Martin <tmartin@physics.ucsd.edu>
Cc: Sebastian Kuzminsky <seb@highlab.com>, linux-ide@vger.kernel.org

On Tue, 20 Dec 2005, Terrence Martin wrote:

> sata_mv 0000:03:04.0: 32 slots 4 ports unknown mode IRQ via MSI

This line seems to suggest that you have MSI enabled in your kernel 
config. Both me and Jeff Garzik had to disable it in order to get the 
driver to work with our Marvell controllers. However, your log shows 
the driver proceeding further than in my case, so maybe you have a 
setup that would allow using MSI - what mainboard is this ? (you 
mentioned Supermicro, but not the model number, unless I missed it...)

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De
