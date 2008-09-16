From: James Andrewartha <jamesa@daa.com.au>
Subject: Re: Recommended PCI Express or PCI-X SATA (Raid) Controller?
Date: Wed, 17 Sep 2008 04:01:31 +0800
Message-ID: <1221595291.23098.8.camel@zarvora>
References: <f4527be0809130200i23053c1m34855368bac129c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound.icp-qv1-irony-out2.iinet.net.au ([203.59.1.107]:31287
	"EHLO outbound.icp-qv1-irony-out2.iinet.net.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751176AbYIPUMZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Sep 2008 16:12:25 -0400
In-Reply-To: <f4527be0809130200i23053c1m34855368bac129c7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lyon <andrew.lyon@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sat, 2008-09-13 at 10:00 +0100, Andrew Lyon wrote:
> I want to add a PCI Express or PCI-X SATA Controller to my system for
> an additional 2 or 4 sata ports, however I am running Xen so I am
> stuck with a older kernel version, gentoo xen 2.6.21 has proved to be
> fairly stable on my hardware but I may attempt to upgrade to 2.6.25 if
> necessary, can anybody recommend a pci-x or pci express sata
> controller with 2 or 4 ports that has been well supported since at
> least 2.6.21?
> 
> I assumed that any real hardware raid device would be beyond my budget
> but I might just be able to afford a Areca ICAe1210, has anybody used
> Areca cards with older kernels?

The Sil 3132 is a good 2-port PCIe controller, or the 3124 is 4 ports on
PCI-X. Going up a bit, the supermicro AOC-USAS-S8i is an 8-port PCIe SAS
controller based on the LSISAS1068E which has had a Linux driver for a
while, but I don't know what the support for SATA drives on it in Linux
is like.

The Areca cards are good and have drivers for older kernels (2.6.18 if
not earlier).

James Andrewartha
