From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Remove unneeded __le32 in ata_tf_to_fis
Date: Sun, 1 Sep 2013 09:21:08 -0400
Message-ID: <20130901132108.GA11520@htj.dyndns.org>
References: <1377966033-12256-1-git-send-email-marc.ceeeee@gmail.com>
 <1377966033-12256-2-git-send-email-marc.ceeeee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:60452 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191Ab3IANVM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Sep 2013 09:21:12 -0400
Received: by mail-qa0-f46.google.com with SMTP id i13so540733qae.19
        for <linux-ide@vger.kernel.org>; Sun, 01 Sep 2013 06:21:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1377966033-12256-2-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sat, Aug 31, 2013 at 09:20:33AM -0700, Marc C wrote:
> From: Marc Carino <marc.ceeeee@gmail.com>
> 
> The endianness attribute on the 'aux' local variable wasn't
> necessary, so remove it.

This is a bug fix on big endian machines, right?  The above
description doesn't match the patch content.

Thanks.

-- 
tejun
