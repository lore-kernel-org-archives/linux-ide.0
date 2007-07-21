From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_via with software raid1: "attempt to access beyond end of
 device"
Date: Sat, 21 Jul 2007 01:13:32 +0100
Message-ID: <20070721011332.2d06c254@the-village.bc.nu>
References: <ohu2n4-lcf.ln1@tux.abusar.org>
	<20070720001714.7b6aaf95@the-village.bc.nu>
	<k0c5n4-dl4.ln1@tux.abusar.org>
	<20070720163709.04e5999c@the-village.bc.nu>
	<b1l7n4-7p4.ln1@tux.abusar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41379 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750853AbXGUAGm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jul 2007 20:06:42 -0400
In-Reply-To: <b1l7n4-7p4.ln1@tux.abusar.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Cc: linux-ide@vger.kernel.org

> 	But I really don't know why mkreiserfs is creating a filesystem
> with 64k more than allowed by the device... maybe a bug in mkreiserfs?
> 
> 	The strange is that it didn't happen with the OLD IDE
> drivers... could it be a pata_via bug?

pata_via doesn't deal with disk sizes. That is handled by the core libata
code (and on the whole by the scsi midlayer)

Once you've created a raid volume the sizing is however handled by the
raid code not by the underlying code at all so it suggests a bug (or some
kind of shared misbehaviour) in the various mk* tools. However I've no
idea what that should suddenly show up now, and not with every scsi user.

> 	And it seems that mdadm's method to determine the size of the
> partition is different from mkreiserfs/mke2fs etc, right?

You would need to ask someone familiar with those applications or take a
look at the source.
