From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_serverworks: disable 64-KB DMA transfers on
 Broadcom OSB4 IDE Controller
Date: Thu, 25 Sep 2014 11:19:55 -0400
Message-ID: <20140925151955.GB23044@htj.dyndns.org>
References: <Pine.LNX.4.64.1409241809150.12147@mail.funsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:65487 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbaIYPT6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Sep 2014 11:19:58 -0400
Received: by mail-qc0-f172.google.com with SMTP id c9so5456632qcz.3
        for <linux-ide@vger.kernel.org>; Thu, 25 Sep 2014 08:19:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1409241809150.12147@mail.funsoft.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ccscott@funsoft.com
Cc: linux-ide@vger.kernel.org

On Wed, Sep 24, 2014 at 06:13:09PM -0700, ccscott@funsoft.com wrote:
> From: Scott Carter <ccscott@funsoft.com>
> 
> The Broadcom OSB4 IDE Controller (vendor and device IDs: 1166:0211)
> does not support 64-KB DMA transfers.
> Whenever a 64-KB DMA transfer is attempted,
> the transfer fails and messages similar to the following
> are written to the console log:
...

Applied to libata/for-3.17-fixes w/ stable cc'd.

Thanks.

-- 
tejun
