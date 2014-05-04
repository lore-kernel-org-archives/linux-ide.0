From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHv3 1/5] Documentation: dt-bindings: reformat and order
 list of ahci-platform compatibles
Date: Sun, 4 May 2014 15:28:27 -0400
Message-ID: <20140504192827.GF26279@htj.dyndns.org>
References: <1397574006-5868-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397574006-5868-2-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:40520 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbaEDT2b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 May 2014 15:28:31 -0400
Received: by mail-qc0-f171.google.com with SMTP id c9so7055769qcz.30
        for <linux-ide@vger.kernel.org>; Sun, 04 May 2014 12:28:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1397574006-5868-2-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Tue, Apr 15, 2014 at 05:00:02PM +0200, Thomas Petazzoni wrote:
> The ahci-platform.txt Device Tree binding documentation is gaining a
> growing number of compatible strings, and it will gain one more with
> the addition of the Marvell Armada 380 AHCI support. It is therefore
> time to reformat this list into a proper bullet list, and more
> importantly order it alphabetically;
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Acked-by: Andrew Lunn <andrew@lunn.ch>

Applied to libata/for-3.16.

Thanks.

-- 
tejun
