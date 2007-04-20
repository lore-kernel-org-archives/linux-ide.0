From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Handle drives that require a spin-up command
 before first access
Date: Fri, 20 Apr 2007 13:46:07 +0900
Message-ID: <4628458F.7070809@gmail.com>
References: <4627716B.9060408@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:40684 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979AbXDTEqM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Apr 2007 00:46:12 -0400
Received: by wr-out-0506.google.com with SMTP id 76so820652wra
        for <linux-ide@vger.kernel.org>; Thu, 19 Apr 2007 21:46:12 -0700 (PDT)
In-Reply-To: <4627716B.9060408@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>

Mark Lord wrote:
> I'm resending this now that reverse-DNS has been fixed on
> our out-going mail server.
> 
> Jeff, this would be a very good thing to queue up for 2.6.22,
> as otherwise drives become permanent paperweights when
> the "power-up-in-standby" feature is turned on.
> 
> Cheers
> 
> 
> -------- Original Message --------
> Subject: [PATCH] libata: Handle drives that require a spin-up command
> before first access
> Date: Tue, 17 Apr 2007 18:26:07 -0400
> From: Mark Lord <liml@rtr.ca>
> To: Jeff Garzik <jgarzik@pobox.com>,  IDE/ATA development list
> <linux-ide@vger.kernel.org>
> CC: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>
> 
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

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
