From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: Fix CS55xx dependencies
Date: Tue, 11 Mar 2014 08:19:32 -0400
Message-ID: <20140311121932.GA11477@htj.dyndns.org>
References: <20140311125524.673b62a3@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:60170 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbaCKMTg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2014 08:19:36 -0400
Received: by mail-qg0-f44.google.com with SMTP id a108so24648674qge.3
        for <linux-ide@vger.kernel.org>; Tue, 11 Mar 2014 05:19:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140311125524.673b62a3@endymion.delvare>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-ide@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

On Tue, Mar 11, 2014 at 12:55:24PM +0100, Jean Delvare wrote:
> As far as I know, the CS5520 and CS5530 chipsets were only used with
> 32-bit x86 Geode processors, so I think their drivers are only needed
> on this architecture, except for build testing purpose.
> 
> While we're here, simplify the dependencies for the CS5535 driver.
> 
> The CS5536 was used with the Geode processors, but also on MIPS
> Loongson/Lemote 2 systems, so let its driver be built for these two
> architectures only, except for build testing purpose.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>

Applied to libata/for-3.15.

Thanks.

-- 
tejun
