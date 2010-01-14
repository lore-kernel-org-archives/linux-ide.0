From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 2.6.32.3] ahci: AHCI and RAID mode SATA patch for Intel
 Cougar Point DeviceIDs
Date: Thu, 14 Jan 2010 18:11:36 -0200
Message-ID: <20100114201136.GA3814@khazad-dum.debian.net>
References: <201001121700.18234.seth.heasley@intel.com>
 <4B4D4EAA.2010109@gmail.com>
 <4B4DAA68.60608@pobox.com>
 <51f3faa71001131611y343ad225n1acc73900fd49894@mail.gmail.com>
 <51f3faa71001131642u2cc9de80n8e73be7a8707afb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39697 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753312Ab0ANUVo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jan 2010 15:21:44 -0500
Content-Disposition: inline
In-Reply-To: <51f3faa71001131642u2cc9de80n8e73be7a8707afb2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Seth Heasley <seth.heasley@intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 13 Jan 2010, Robert Hancock wrote:
> Hmm, it seems like it's a bit more complicated than that. For ICH6R
> (0x2652), ata_piix attaches to it regardless of mode intentionally, it
> has specific logic to disable AHCI on the controller since it can be
> used in either mode. That seems a bit questionable. Having the same
> device being handled by different enabled drivers and depending on
> link or module load order to decide which one loads is fragile and
> prone to errors. I'd be in favor of removing the ICH6R support from
> ata_piix entirely and saying that you should be using ahci for that
> device. Maybe when ahci was immature there was a benefit to allowing
> ata_piix to run it, but I doubt that's true today.

Maybe it is the silicon AHCI in ICH6R that is immature, and one is much
better of using it in IDE mode?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
