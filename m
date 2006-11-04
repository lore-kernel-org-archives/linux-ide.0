From: Tejun Heo <htejun@gmail.com>
Subject: Re: Supported chipsets with sata_sil24?
Date: Sun, 05 Nov 2006 08:53:15 +0900
Message-ID: <454D27EB.1070907@gmail.com>
References: <fnjo4zvd52iy.1rdumsth8vh91$.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.202]:8573 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965749AbWKDXxa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Nov 2006 18:53:30 -0500
Received: by nz-out-0102.google.com with SMTP id z3so573533nzf
        for <linux-ide@vger.kernel.org>; Sat, 04 Nov 2006 15:53:29 -0800 (PST)
In-Reply-To: <fnjo4zvd52iy.1rdumsth8vh91$.dlg@40tude.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jwoznack@d-a-s.com
Cc: linux-ide@vger.kernel.org

John Woznack wrote:
> Out of curiosity, which Silicon Image chipsets are supported by the
> sata_sil24 driver? (3124/3132 obviously,but what about 3512, 3112, 3531,
> and 3726?)

sata_sil24	: 3124, 3132, 3131, 3531
sata_sil	: 3112, 3114, 3512 and some other variants

3726 and 4726 are port multipliers and supported by pending PMP patchset.

-- 
tejun
