From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 1/4] Store interrupt value
Date: Wed, 01 Aug 2007 17:18:01 +0900
Message-ID: <46B041B9.7050508@gmail.com>
References: <20070705194909.337398431@intel.com> <20070705130500.ad5f7739.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.238]:8971 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759565AbXHAISJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 04:18:09 -0400
Received: by qb-out-0506.google.com with SMTP id e11so135707qbe
        for <linux-ide@vger.kernel.org>; Wed, 01 Aug 2007 01:18:09 -0700 (PDT)
In-Reply-To: <20070705130500.ad5f7739.kristen.c.accardi@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: jeff@garzik.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, James.Bottomley@steeleye.com, edwintorok@gmail.com, axboe@kernel.dk, linux-scsi@vger.kernel.org

Kristen Carlson Accardi wrote:
> Use a stored value for which interrupts to enable.  Changing this allows
> us to selectively turn off certain interrupts later and have them 
> stay off.
> 
> Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
