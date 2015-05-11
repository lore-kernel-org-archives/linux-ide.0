From: Matthew Garrett <matthew.garrett@coreos.com>
Subject: Re: [PATCH 2/3] libata: Add firmware_default LPM policy
Date: Mon, 11 May 2015 13:34:40 -0700
Message-ID: <CAPeXnHtVZ-fuzxYiCFBTn_5g_z+mbLHGnD5yQpam_3Ypjfv0HQ@mail.gmail.com>
References: <1429370796-5881-1-git-send-email-mjg59@coreos.com>
	<1429370796-5881-3-git-send-email-mjg59@coreos.com>
	<20150422144812.GA10592@htj.duckdns.org>
	<CAPeXnHuSccpYkDRmWO5tKuec2q0WqX7Ktxk_yX9te77xrEe=SA@mail.gmail.com>
	<20150511202830.GH11388@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35047 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036AbbEKUel (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 May 2015 16:34:41 -0400
Received: by oign205 with SMTP id n205so114236928oig.2
        for <linux-ide@vger.kernel.org>; Mon, 11 May 2015 13:34:40 -0700 (PDT)
In-Reply-To: <20150511202830.GH11388@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Matthew Garrett <mjg59@coreos.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, kristen@linux.intel.com, sgunderson@bigfoot.com

On Mon, May 11, 2015 at 1:28 PM, Tejun Heo <tj@kernel.org> wrote:

> CommWake isn't the problem here.  SError is being dumped just for
> information.  The disk is reporting failure on a write command which
> is diagnosed as "device error" and thus the link is not reset.  It's
> really the device actively reporting command failure.

Ok, that makes sense. Is there any practical way for us to identify
why the device might be doing that? It seems to be limited to the LPM
case, but this is (theoretically) in the same configuration that the
firmware programmed, so it's a little surprising.

-- 
Matthew Garrett | matthew.garrett@coreos.com
