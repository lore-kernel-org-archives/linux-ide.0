From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream-fixes] libata: use atapi_cmd_type() to
 determine cmd type instead of transfer size
Date: Wed, 12 Mar 2008 13:18:50 +0000
Message-ID: <20080312131850.330765aa@the-village.bc.nu>
References: <47D5EFD4.2090801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zux006-051-205.adsl.green.ch ([81.6.51.205]:10915 "EHLO
	the-village.bc.nu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751130AbYCLNjz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Mar 2008 09:39:55 -0400
In-Reply-To: <47D5EFD4.2090801@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Tue, 11 Mar 2008 11:35:00 +0900
Tejun Heo <htejun@gmail.com> wrote:

> pata_ali and pata_it821x were using qc->nbytes to determine whether a
> command is data transfer type or not.  As now qc->nbytes can be
> extended by padding and draining buffers, this tests are not useful
> anymore.  Use atapi_cmd_type() instead.

NAK

The it821x case really seems to be about bytes transferred not command
type. ALi one looks fine
