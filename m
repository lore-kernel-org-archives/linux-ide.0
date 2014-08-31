From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: ahci_p5wdh_workaround - constify DMI table
Date: Sun, 31 Aug 2014 05:37:14 -0400
Message-ID: <20140831093714.GA19853@htj.dyndns.org>
References: <1409475429-11356-1-git-send-email-minipli@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:42050 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbaHaJhS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 Aug 2014 05:37:18 -0400
Received: by mail-qa0-f51.google.com with SMTP id j7so3802182qaq.38
        for <linux-ide@vger.kernel.org>; Sun, 31 Aug 2014 02:37:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1409475429-11356-1-git-send-email-minipli@googlemail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mathias Krause <minipli@googlemail.com>
Cc: linux-ide@vger.kernel.org

On Sun, Aug 31, 2014 at 10:57:09AM +0200, Mathias Krause wrote:
> The DMI table does not need to be written to, make it r/o.
> 
> Signed-off-by: Mathias Krause <minipli@googlemail.com>

Applied to libata/for-3.18.

Thanks.

-- 
tejun
