From: Tejun Heo <htejun@gmail.com>
Subject: Re: Do SATA tape drives work?
Date: Wed, 09 Jan 2008 14:18:21 +0900
Message-ID: <4784591D.3060000@gmail.com>
References: <200801090329.m093T7Op019488@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:53071 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184AbYAIFS3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 00:18:29 -0500
Received: by rv-out-0910.google.com with SMTP id k20so97567rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 08 Jan 2008 21:18:28 -0800 (PST)
In-Reply-To: <200801090329.m093T7Op019488@turbo.physics.adelaide.edu.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>

[cc'ing linux-ide]

Jonathan Woithe wrote:
> Hi guys
> 
> I was wondering whether anyone can shed any light on the status of SATA tape
> drives.  There's very little info on the net about this at least in the
> places I've checked; the only thing of any significance I've found thus far
> is a note in a Bacula document dated April 2007 which states that drives
> other than real SCSI units don't generally work with Bacula.
> 
> To put this into context, I'm looking at purchasing a Sony SDX470VRB SATA
> AIT-1 tape drive for use with the SATA controller on an Intel DG31PR
> mainboard.  The drive will be used primarily with tar/cpio.  Obvsiouly
> however I only want to make the purchase if there's a reasonable chance of
> it working.
> 
> I would appreciate any information you can shed on this issue.

It's supposed to with recent updates.  Mark, right?

-- 
tejun
