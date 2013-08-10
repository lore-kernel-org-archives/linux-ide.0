From: Marc C <marc.ceeeee@gmail.com>
Subject: Re: [PATCH v3 3/3] libata: Add support for queued DSM TRIM
Date: Fri, 09 Aug 2013 19:14:07 -0700
Message-ID: <5205A1EF.10808@gmail.com>
References: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com> <1376023752-3105-4-git-send-email-marc.ceeeee@gmail.com> <20130809140840.GC20515@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:47047 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031757Ab3HJCON (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 22:14:13 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so7642883oag.21
        for <linux-ide@vger.kernel.org>; Fri, 09 Aug 2013 19:14:13 -0700 (PDT)
In-Reply-To: <20130809140840.GC20515@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, sergei.shtylyov@cogentembedded.com

Hello,

On 8/9/2013 7:08 AM, Tejun Heo wrote:

> So, there are controllers which actually look at the command code and
> thus will choke on new commands and just looking at whether the device
> supports the new commands is likely to be insufficient.  Have you
> tested this?  If so, on which controllers / devices?  We're likely to
> need whitelisting on controller side, I think.
Not entirely sure. Non-AHCI controllers scare me since they typically
don't come along with specs, or are just finicky. This is especially
true since this is a new NCQ command. Anyway, I'll use a flag (as
suggested in the other thread) to differentiate between controllers that
_should_ be able to handle this properly (AHCI) and other
vendor-specific SATA controllers.

Thanks,
Marc
