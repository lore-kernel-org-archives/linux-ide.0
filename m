From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] libata: add ATA_HORKAGE_NOTRIM
Date: Tue, 14 Jul 2015 14:50:47 -0400
Message-ID: <20150714185047.GA2273@mtj.duckdns.org>
References: <1436873314-22563-1-git-send-email-arne_f@ipfire.org>
 <1436873314-22563-2-git-send-email-arne_f@ipfire.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:36499 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbbGNSuu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jul 2015 14:50:50 -0400
Received: by qgy5 with SMTP id 5so8365399qgy.3
        for <linux-ide@vger.kernel.org>; Tue, 14 Jul 2015 11:50:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436873314-22563-2-git-send-email-arne_f@ipfire.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arne Fitzenreiter <arne_f@ipfire.org>
Cc: linux-ide@vger.kernel.org

On Tue, Jul 14, 2015 at 01:28:33PM +0200, Arne Fitzenreiter wrote:
> sone disks lose data at trim also with disabled ncq
> so this add a switch to force disable trim.

Some devices lose data on TRIM whether queued or not.  This patch adds
a horkage to disable TRIM.

Signed-off-by:....

Thanks.

-- 
tejun
