From: Dave Howorth <dhoworth@mrc-lmb.cam.ac.uk>
Subject: Re: [PATCH #upstream-fixes] libata: fix unexpectedly frozen port
 after ata_eh_reset()
Date: Wed, 25 May 2011 11:33:54 +0100
Message-ID: <4DDCDB12.3020904@mrc-lmb.cam.ac.uk>
References: <20110525100232.GG10146@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:56257 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab1EYK5J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 May 2011 06:57:09 -0400
In-Reply-To: <20110525100232.GG10146@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Bruce Stenning <b.stenning@indigovision.com>

Tejun Heo wrote:

> -	 * Some controllers can't be frozen very well and may set
> -	 * spuruious error conditions during reset.  Clear accumulated
> -	 * error information.  As reset is the final recovery action,
> -	 * nothing is lost by doing this.
> +	 * Some controllers can't be frozen very well and may set spuruious
> +	 * error conditions during reset.  Clear accumulated error
> +	 * information and re-thaw the port if frozen.  As reset is the
> +	 * final recovery action and we cross check link onlineness against
> +	 * device classification later, no hotplug event is lost by this.

spuruious -> spurious
