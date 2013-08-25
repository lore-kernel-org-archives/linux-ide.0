From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v5 0/4] Introduce new SATA queued commands
Date: Sun, 25 Aug 2013 09:40:01 -0400
Message-ID: <20130825134001.GA3890@htj.dyndns.org>
References: <1377411771-3733-1-git-send-email-marc.ceeeee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:51356 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263Ab3HYNkG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Aug 2013 09:40:06 -0400
Received: by mail-qa0-f53.google.com with SMTP id i13so160966qae.5
        for <linux-ide@vger.kernel.org>; Sun, 25 Aug 2013 06:40:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1377411771-3733-1-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sat, Aug 24, 2013 at 11:22:47PM -0700, Marc C wrote:
> From: Marc C <marc.ceeeee@gmail.com>
> 
> This patch series updates the libata driver with some additional
> commands which are specified in the more recent versions of the
> SATA and ATA specifications. These commands are:
> 
>         SEND FPDMA QUEUED
>         RECEIVE FPDMA QUEUED.

Applied to libata/for-3.12.

Thank you very much!

-- 
tejun
