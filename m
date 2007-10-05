From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: pata_cs5536: ATA driver for Geode companion chip (MSR)
Date: Fri, 5 Oct 2007 08:53:56 -0600
Message-ID: <20071005145356.GC32104@cosmic.amd.com>
References: <20071003233012.GA8721@cosmic.amd.com>
 <yq1przva76x.fsf@sermon.lab.mkp.net>
 <20071004165819.003b86c6@the-village.bc.nu>
 <20071004160834.GA28667@cosmic.amd.com>
 <yq13awq857h.fsf_-_@sermon.lab.mkp.net>
 <20071005130127.6165e2e3@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:5535 "EHLO
	outbound5-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756768AbXJEOxv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Oct 2007 10:53:51 -0400
In-Reply-To: <20071005130127.6165e2e3@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Martin K. Petersen" <mkp@mkp.net>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On 05/10/07 13:01 +0100, Alan Cox wrote:
> > pata_cs5536.c relies on Geode Machine Specific Registers to configure
> > the ATA function and uses the correct PIO timings for the chip.
> 
> Any reason for not supporting both methods ? Though I guess as you say
> msr is sufficient.
> 
> 
> > +#ifndef CONFIG_PATA_CS5536	/* Temporary */
> 
> 	!defined(FOO) && ! defined(FOO_MODULE)
> 
> otherwise ACK

ACK as well, but I put a call out on the Geode list for testing - I want
to make sure that we get some time on different platforms with different
BIOSes to make sure it is solid.

Jordan

-- 
Jordan Crouse
Systems Software Development Engineer 
Advanced Micro Devices, Inc.


