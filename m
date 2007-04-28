From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Handle drives that require a spin-up command
 before first access
Date: Sat, 28 Apr 2007 14:41:15 -0400
Message-ID: <4633954B.6040306@garzik.org>
References: <4625497F.7010109@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53322 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163504AbXD1SlT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 14:41:19 -0400
In-Reply-To: <4625497F.7010109@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

Mark Lord wrote:
> 
> (S)ATA drives can be configured for "power-up in standby",
> a mode whereby a specific "spin up now!" command is required
> before the first media access.
> 
> Currently, a drive with this feature enabled can not be used at all
> with libata, and once in this mode, the drive becomes a doorstop.
> 
> The older drivers/ide subsystem at least enumerates the drive,
> so that it can be woken up after the fact from a userspace HDIO_*
> command, but not libata.
> 
> This patch adds support to libata for the "power-up in standby"
> mode where a "spin up now!" command (SET_FEATURES) is needed.
> With this, libata will recognize such drives, spin them up,
> and then re-IDENTIFY them if necessary to get a full/complete
> set of drive features data.
> 
> Drives in this state are determined by looking for
> special values in id[2], as documented in the current ATA specs.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

applied

though I'm curious where the verify step went, that was in the previous 
rev of the patch


