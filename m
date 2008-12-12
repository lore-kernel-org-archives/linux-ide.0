From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: AHCI problem with hotplug
Date: Fri, 12 Dec 2008 16:03:17 +0000
Message-ID: <20081212160317.7ad72603@lxorguk.ukuu.org.uk>
References: <494178E3.6030305@cybernetics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52860 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757310AbYLLQDN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Dec 2008 11:03:13 -0500
In-Reply-To: <494178E3.6030305@cybernetics.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tony Battersby <tonyb@cybernetics.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Thu, 11 Dec 2008 15:32:35 -0500
Tony Battersby <tonyb@cybernetics.com> wrote:

> I am having a problem getting Linux to detect hot-plugged SATA disks on my
> ICH7 AHCI controller (SuperMicro PDSME motherboard).  On any SATA port that
> already had a disk plugged in during BIOS POST, Linux will see the disk and
> detect hot-plug and hot-unplug events just fine.  On any SATA port that did
> not have a disk plugged in during BIOS POST, Linux will not see a disk no
> matter what.  Here are the different sequences of events that I have tried:

AHCI has a set of BIOS/Firmware set flags used to indicate which ports
are not hot pluggable and the kernel will honour that data and leave such
ports powered down.

