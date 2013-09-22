From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata_piix: minor typo fixes and threading fix
Date: Sun, 22 Sep 2013 12:05:51 -0400
Message-ID: <20130922160551.GD28571@htj.dyndns.org>
References: <523EF645.7050808@linux.com>
 <20130922153959.GB28571@htj.dyndns.org>
 <523F10BB.8020503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:43950 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186Ab3IVQFz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Sep 2013 12:05:55 -0400
Received: by mail-qc0-f175.google.com with SMTP id v2so1434979qcr.20
        for <linux-ide@vger.kernel.org>; Sun, 22 Sep 2013 09:05:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <523F10BB.8020503@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Levente Kurusa <ilevex.linux@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, Sep 22, 2013 at 05:46:03PM +0200, Levente Kurusa wrote:
> As far as I know pr_cont is not thread-safe. Without this patch I
> was only getting "... MAP [" and the rest would be scattered through
> the dmesg.

Continuations are now properly handled by printk.  Please see commits
leading to eab072609e11a357181806ab5a5c309ef6eb76f5.

Thanks.

-- 
tejun
