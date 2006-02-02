From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
Subject: Re: sata_mv and MV88SX6041 don't work
Date: Thu, 2 Feb 2006 13:27:03 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0602021321580.16428@dingo.iwr.uni-heidelberg.de>
References: <200602011543.00647.sojkam1@fel.cvut.cz> <43E105A2.3050800@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay.uni-heidelberg.de ([129.206.100.212]:21647 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S1750999AbWBBMkq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Feb 2006 07:40:46 -0500
In-Reply-To: <43E105A2.3050800@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, sojkam1@fel.cvut.cz, kelbelj@fel.cvut.cz, rheflin@atipa.com

On Wed, 1 Feb 2006, Jeff Garzik wrote:

> As was noted in another thread (I should put this in a FAQ somewhere), 
> disabling CONFIG_PCI_MSI will solve a lot of people's sata_mv problems.

Is there a case where sata_mv and CONFIG_PCI_MSI do work together ?

All the reports that I have seen so far indicate a negative answer, 
but this might simply be because only the problems are reported and 
not the success stories.

If indeed sata_mv and CONFIG_PCI_MSI don't work together now, wouldn't 
it be better to not use MSI in the driver ? You (Jeff) also indicated 
that there might be some errata that could be related to using MSI - 
any plans of releasing some code to take care of this ?

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De
