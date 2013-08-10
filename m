From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 3/3] libata: Add support for queued DSM TRIM
Date: Sat, 10 Aug 2013 11:11:51 -0400
Message-ID: <20130810151151.GA3806@htj.dyndns.org>
References: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com>
 <1376023752-3105-4-git-send-email-marc.ceeeee@gmail.com>
 <20130809140840.GC20515@mtj.dyndns.org>
 <5205A1EF.10808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172]:33469 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934060Ab3HJPLz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Aug 2013 11:11:55 -0400
Received: by mail-ve0-f172.google.com with SMTP id oz10so4689607veb.17
        for <linux-ide@vger.kernel.org>; Sat, 10 Aug 2013 08:11:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5205A1EF.10808@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: linux-ide@vger.kernel.org, sergei.shtylyov@cogentembedded.com

Hello,

On Fri, Aug 09, 2013 at 07:14:07PM -0700, Marc C wrote:
> Not entirely sure. Non-AHCI controllers scare me since they typically
> don't come along with specs, or are just finicky. This is especially
> true since this is a new NCQ command. Anyway, I'll use a flag (as
> suggested in the other thread) to differentiate between controllers that
> _should_ be able to handle this properly (AHCI) and other
> vendor-specific SATA controllers.

I'm fine with making it only available on ahci's, at least for now,
but can you please make the flag distinguish the specific feature
rather than the controller is AHCI or not?

Thanks.

-- 
tejun
