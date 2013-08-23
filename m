From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 0/3] Introduce new SATA queued commands
Date: Fri, 23 Aug 2013 12:08:40 -0400
Message-ID: <20130823160840.GJ3277@htj.dyndns.org>
References: <1377250847-24132-1-git-send-email-marc.ceeeee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:33859 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190Ab3HWQIo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Aug 2013 12:08:44 -0400
Received: by mail-qc0-f178.google.com with SMTP id p19so429237qcv.37
        for <linux-ide@vger.kernel.org>; Fri, 23 Aug 2013 09:08:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1377250847-24132-1-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

On Fri, Aug 23, 2013 at 02:40:44AM -0700, Marc C wrote:
> From: Marc C <marc.ceeeee@gmail.com>
> 
> This patch series updates the libata driver with some additional
> commands which are specified in the more recent versions of the
> SATA and ATA specifications. These commands are:

Generally looks good to me other than the cosmetic points.  Can you
please update the series to Sergei's and my comments?

Thanks!

-- 
tejun
