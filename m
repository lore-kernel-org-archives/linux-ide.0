From: Chris Webb <chris@arachsys.com>
Subject: Re: IO_PAGE_FAULT from SATA card during boot
Date: Thu, 3 Feb 2011 08:56:01 +0000
Message-ID: <20110203085601.GB2490@arachsys.com>
References: <20110129112456.GA13204@arachsys.com>
 <4D44433F.1040607@gmail.com>
 <20110130015442.GB13204@arachsys.com>
 <AANLkTim7+9WVVJAjbj4pNMB9OKVmf2B+XNQ+exDt9_Tm@mail.gmail.com>
 <20110202135644.GG11670@arachsys.com>
 <4D49FB9F.9040304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alpha.arachsys.com ([91.203.57.7]:51219 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778Ab1BCI4J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2011 03:56:09 -0500
Content-Disposition: inline
In-Reply-To: <4D49FB9F.9040304@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

Robert Hancock <hancockrwd@gmail.com> writes:

> Is it the same model of add-on card?

Hi. Yes, they're four identical machines with four identical SATA
controllers.

> This controller apparently has both a SATA and PATA controller on
> it. The PATA portion doesn't seem to be showing up in lspci, but
> obviously the BIOS saw some sign of it - and if the IOMMU reporting
> can be believed, it's trying to do a read request for some reason..

Since SATA cards are cheap, I've ordered a different AHCI card to try
swapping out, so will be able to confirm if it's specific to this SATA card.

Cheers,

Chris.
