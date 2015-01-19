From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] libata: prevent HSM state change race between ISR and
 PIO
Date: Mon, 19 Jan 2015 14:57:26 -0500
Message-ID: <20150119195726.GA4556@htj.dyndns.org>
References: <1421694205-14944-1-git-send-email-dmilburn@redhat.com>
 <20150119191524.GC10570@htj.dyndns.org>
 <54BD5CEF.2050808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:61037 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbbASUDZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2015 15:03:25 -0500
Received: by mail-qg0-f54.google.com with SMTP id z60so18236582qgd.13
        for <linux-ide@vger.kernel.org>; Mon, 19 Jan 2015 12:03:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54BD5CEF.2050808@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org

On Mon, Jan 19, 2015 at 01:37:19PM -0600, David Milburn wrote:
> Wouldn't we still have to use host lock instead of port lock to sync
> with ISR?

They're the same lock for SFF controllers.  If I'm not mistaken, ahci
is currently the only one which splits the host lock when MMSI is
enabled.

Thanks.

-- 
tejun
