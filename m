From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: sata_inic162x driver for 2.6.19
Date: Thu, 11 Jan 2007 00:04:53 +0000
Message-ID: <20070111000453.651dedfa@localhost.localdomain>
References: <20061221041618.12158.qmail@web813.biz.mail.mud.yahoo.com>
	<1168472072.14261.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45084 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965254AbXAJXxv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Jan 2007 18:53:51 -0500
In-Reply-To: <1168472072.14261.5.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Bob Stewart <bob@evoria.net>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

> I tried both the 2.6.19 version and one based on 2.6.20-rc4, same
> problem. Is there anything specific the driver needs to do work with
> disks > 137GB?

It is the boundary for LBA48 accesses.
