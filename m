From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
Subject: Re: [RFC] libata feature list
Date: Thu, 15 Dec 2005 16:42:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512151636170.28969@dingo.iwr.uni-heidelberg.de>
References: <43A10FED.4060808@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay.uni-heidelberg.de ([129.206.100.212]:41373 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S1750778AbVLOPmh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Dec 2005 10:42:37 -0500
In-Reply-To: <43A10FED.4060808@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Thu, 15 Dec 2005, Jeff Garzik wrote:

> Comments welcome.

In the list of "Host controllers" there are manufacturer names that 
appear in more than one of the PCI IDE SATA, Advanced SATA or PCI IDE 
PATA categories; it might be less confusing if the chipset or series 
number is given, when possible.

Lower, in the "Not supported" section, "ATA/ATAPI device support" 
lists "hotplug (early patch available)"; it might be less confusing to 
make a similar note as higher when talking about the controller, like:

 	* hotplug (i.e. plug/unplug the drive)

Thanks!

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De
