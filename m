From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Swarm: Fix crash due to missing initialization
Date: Sat, 27 Sep 2008 18:30:23 +0200
Message-ID: <200809271830.23240.bzolnier@gmail.com>
References: <20080921204716.GA29927@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:63134 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbYI0R26 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Sep 2008 13:28:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so963865fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 27 Sep 2008 10:28:57 -0700 (PDT)
In-Reply-To: <20080921204716.GA29927@linux-mips.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org

On Sunday 21 September 2008, Ralf Baechle wrote:
> If things are just right this will result in the hws[0]->parent being
> passed to ide_host_add() being non-zero and an ooops a little later.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

thanks, applied
