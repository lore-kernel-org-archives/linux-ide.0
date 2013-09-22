From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata_piix: minor typo fixes and threading fix
Date: Sun, 22 Sep 2013 11:39:59 -0400
Message-ID: <20130922153959.GB28571@htj.dyndns.org>
References: <523EF645.7050808@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:58681 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab3IVPkC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Sep 2013 11:40:02 -0400
Received: by mail-qa0-f46.google.com with SMTP id j7so889813qaq.12
        for <linux-ide@vger.kernel.org>; Sun, 22 Sep 2013 08:40:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <523EF645.7050808@linux.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Levente Kurusa <levex@linux.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sun, Sep 22, 2013 at 03:53:09PM +0200, Levente Kurusa wrote:
> Hi,
> 
> The following patch fixes a printk() call, which was originally used
> with pr_cont, which will however fail. Fixed that with setting up a

Why would pr_cont() fail?

Thanks.

-- 
tejun
