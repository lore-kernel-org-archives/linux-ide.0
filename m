From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/3] libata: Add firmware_default LPM policy
Date: Mon, 11 May 2015 16:43:30 -0400
Message-ID: <20150511204330.GJ11388@htj.duckdns.org>
References: <1429370796-5881-1-git-send-email-mjg59@coreos.com>
 <1429370796-5881-3-git-send-email-mjg59@coreos.com>
 <20150422144812.GA10592@htj.duckdns.org>
 <CAPeXnHuSccpYkDRmWO5tKuec2q0WqX7Ktxk_yX9te77xrEe=SA@mail.gmail.com>
 <20150511202830.GH11388@htj.duckdns.org>
 <CAPeXnHtVZ-fuzxYiCFBTn_5g_z+mbLHGnD5yQpam_3Ypjfv0HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:33442 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbbEKUne (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 May 2015 16:43:34 -0400
Content-Disposition: inline
In-Reply-To: <CAPeXnHtVZ-fuzxYiCFBTn_5g_z+mbLHGnD5yQpam_3Ypjfv0HQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <matthew.garrett@coreos.com>
Cc: Matthew Garrett <mjg59@coreos.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, kristen@linux.intel.com, sgunderson@bigfoot.com

Hello, Matthew.

On Mon, May 11, 2015 at 01:34:40PM -0700, Matthew Garrett wrote:
> On Mon, May 11, 2015 at 1:28 PM, Tejun Heo <tj@kernel.org> wrote:
> 
> > CommWake isn't the problem here.  SError is being dumped just for
> > information.  The disk is reporting failure on a write command which
> > is diagnosed as "device error" and thus the link is not reset.  It's
> > really the device actively reporting command failure.
> 
> Ok, that makes sense. Is there any practical way for us to identify
> why the device might be doing that? It seems to be limited to the LPM
> case, but this is (theoretically) in the same configuration that the
> firmware programmed, so it's a little surprising.

Modern ATA spec do implement extended error reporting and Hannes
recently (not mainline yet) added support for it and the kernel will
print out sense codes if the device reports it ("NCQ Autosense
xx/xx/xx").  Another vector could be SMART error log which is
accessible through smartctl, but it's quite possible that the ABRT bit
is the only thing the device is exposing at all.

Thanks.

-- 
tejun
