From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: CONFIG_ATA is libata
Date: Tue, 18 Feb 2014 18:27:20 -0500
Message-ID: <20140218232720.GN31892@mtj.dyndns.org>
References: <52FED10E.3070808@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:42216 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbaBRX1X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Feb 2014 18:27:23 -0500
Received: by mail-qa0-f44.google.com with SMTP id w5so24711352qac.31
        for <linux-ide@vger.kernel.org>; Tue, 18 Feb 2014 15:27:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52FED10E.3070808@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-ide@vger.kernel.org, Gene Heskett <gheskett@wdtv.com>

On Fri, Feb 14, 2014 at 06:29:34PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Let users know that CONFIG_ATA is the kconfig symbol for libata,
> since libata is mentioned in documentation and messages several
> times.
> 
> Also correct a grammar typo.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied to libata/for-3.15.

Thanks.

-- 
tejun
