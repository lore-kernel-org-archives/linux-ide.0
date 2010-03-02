From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH RFC 0/12] ahci: Add support for non-PCI devices
Date: Tue, 02 Mar 2010 16:34:39 -0500
Message-ID: <4B8D846F.3080400@garzik.org>
References: <20100302182850.GA32057@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:48482 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab0CBVep (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Mar 2010 16:34:45 -0500
In-Reply-To: <20100302182850.GA32057@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/02/2010 01:28 PM, Anton Vorontsov wrote:
> Hi all,
>
> This patch set refactors AHCI code to make it more generic, plus
> adds a new platform driver to support AHCI interfaces integrated
> into System-On-Chip devices.
>
> The patches should apply on top of v2.6.33 (soon will be rebased
> on top of linux-next).
>
> I don't have any PCI AHCI handy (yet, but I plan to find one), so
> PCI AHCI was only compile-tested.

As demonstrated in libata-dev.git#libahci, I think the best route is to 
move generic code into libahci.  In #libahci you will see

	libahci -> common code
	ahci -> standard PCI driver, req's libahci
	mv-ahci -> Marvell AHCI driver, req's libahci
	acard-ahci -> ACard AHCI driver, req's libahci

and to this we could easily add

	platform-ahci -> platform AHCI driver, req's libahci

WARNING:  #libahci should not be used directly, it is meant for 
illustration purposes only.  It has not been properly updated for 
several recent ahci.c changes upstream, which implies that the 
trivial-and-obvious task of moving generic code from ahci.c to libahci.c 
must be redone.

	Jeff



P.S.  Please use the email addresses in MAINTAINERS,

	M:      Jeff Garzik <jgarzik@pobox.com>
	L:      linux-ide@vger.kernel.org

The redhat.com email address is only used for legal (sign-off) purposes, 
not normal use.

