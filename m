From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Prevent warning during PMP error recovery
Date: Thu, 21 Jul 2011 09:25:30 +0200
Message-ID: <20110721072530.GX3455@htj.dyndns.org>
References: <20110715155520.GB25319@merlins.org>
 <1310776322-12911-1-git-send-email-gwendal@google.com>
 <20110721072420.GW3455@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37247 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab1GUHZf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jul 2011 03:25:35 -0400
Received: by ewy4 with SMTP id 4so1011572ewy.19
        for <linux-ide@vger.kernel.org>; Thu, 21 Jul 2011 00:25:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110721072420.GW3455@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: mlord@pobox.com, linux-ide@vger.kernel.org, lil@marvell.com, hbailey@marvell.com, marc@merlins.org

On Thu, Jul 21, 2011 at 09:24:20AM +0200, Tejun Heo wrote:
> On Fri, Jul 15, 2011 at 05:32:02PM -0700, Gwendal Grignou wrote:
> > Cleanup sff_pio_task_link when a command is cancel while the
> > pio_task thread has been scheduled.
> > 
> > Change-Id: I4397bed3ee0878d92933d4897eed025ffaf3a9bd
> > 
> > Signed-off-by: Gwendal Grignou <gwendal@google.com>
> 
> Acked-by: Tejun Heo <tj@kernel.org>

Oooh, Jeff isn't cc'd.  Please re-send to jgarzik with Acked-by added.

Thank you.

-- 
tejun
