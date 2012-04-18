From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/2] Hyper-V disk support V3
Date: Wed, 18 Apr 2012 21:12:35 +0100
Message-ID: <20120418211235.55b9befc@pyramind.ukuu.org.uk>
References: <20120414170223.24f6ea31@pyramind.ukuu.org.uk>
	<1334575229-7493-1-git-send-email-apw@canonical.com>
	<20120416122634.7d1357e1@ultron>
	<20120416182927.GB3346@shadowen.org>
	<426367E2313C2449837CD2DE46E7EAF92CE0B5@CH1PRD0310MB381.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:37588 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab2DRUJ5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2012 16:09:57 -0400
In-Reply-To: <426367E2313C2449837CD2DE46E7EAF92CE0B5@CH1PRD0310MB381.namprd03.prod.outlook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Andy Whitcroft <apw@canonical.com>, Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Sterling <mike.sterling@microsoft.com>

> The notion of "pass through" in Hyper-V  is a little different. IDE devices can be configured
> under either one of the supported controllers and these devices can either be virtual disks
> (VHDs) or physical disks. In either case these will be presented to the guest as IDE devices.

So what ensures that by skipping it at the ATA device level we will
always find it as a VHD ?

Alan
