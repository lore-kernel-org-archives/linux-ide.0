From: Chris Webb <chris.webb@elastichosts.com>
Subject: Re: IO_PAGE_FAULT from SATA card during boot
Date: Thu, 17 Feb 2011 09:40:06 +0000
Message-ID: <20110217094005.GS21289@arachsys.com>
References: <AANLkTim7+9WVVJAjbj4pNMB9OKVmf2B+XNQ+exDt9_Tm@mail.gmail.com>
 <20110202135644.GG11670@arachsys.com>
 <4D49FB9F.9040304@gmail.com>
 <20110203085601.GB2490@arachsys.com>
 <20110207174838.GA21124@arachsys.com>
 <4D50A4B8.2070608@gmail.com>
 <20110208104157.GU2106@amd.com>
 <20110208110036.GA18763@arachsys.com>
 <AANLkTikTBi7FHoXS1JmKXgvmv4j7ramezO09kksGrJA1@mail.gmail.com>
 <20110208144805.GF19483@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alpha.arachsys.com ([91.203.57.7]:56449 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab1BQJkN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Feb 2011 04:40:13 -0500
Content-Disposition: inline
In-Reply-To: <20110208144805.GF19483@arachsys.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: "Roedel, Joerg" <Joerg.Roedel@amd.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Chris Webb <chris.webb@elastichosts.com> writes:

> Robert Hancock <hancockrwd@gmail.com> writes:
> 
> > Did you try different chipsets? The two sets of output you posted are
> > both from Marvell 88SE9123-based cards.
> 
> Oh, I may have been a muppet here then. I assumed the HPT cards would be a
> different chipset. I'll find something completely different!

A SIL-based AHCI controller card turns out to work fine in the same setup,
so it does look like a problem specific to Marvell 88SE9123-based cards.

Cheers,

Chris.
