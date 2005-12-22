From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
Subject: Re: Kernel or patch suggestions for DMA enables Marvell Driver
Date: Thu, 22 Dec 2005 15:53:27 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512221550060.10585@dingo.iwr.uni-heidelberg.de>
References: <43A86AF2.2080508@physics.ucsd.edu> <E1EooUH-0008VA-Vj@highlab.com>
 <43A87273.2060403@physics.ucsd.edu> <43A88218.1040205@physics.ucsd.edu>
 <E1Eoq94-00009u-SS@highlab.com> <43A8BF6B.1090006@physics.ucsd.edu>
 <Pine.LNX.4.63.0512211451500.7522@dingo.iwr.uni-heidelberg.de>
 <43A9BA8D.9040200@physics.ucsd.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay.uni-heidelberg.de ([129.206.100.212]:42112 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S1750936AbVLVOxh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Dec 2005 09:53:37 -0500
In-Reply-To: <43A9BA8D.9040200@physics.ucsd.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Terrence Martin <tmartin@physics.ucsd.edu>
Cc: Sebastian Kuzminsky <seb@highlab.com>, linux-ide@vger.kernel.org

On Wed, 21 Dec 2005, Terrence Martin wrote:

> So I compiled 2.6.15-r5 without MSI enabled.

Hmm, so far all reports indicated that MSI had to be disabled... so 
maybe the Marvell controller is at fault.

> Looking at MSI though it seems to indicate that without it I cannot 
> get PCI-Express to work?

I think that INTx emulation should be present by default if MSI is not 
enabled, but I'm not sure...

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De
