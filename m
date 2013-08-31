From: Tejun Heo <tj@kernel.org>
Subject: Re: [drm-exynos:dmabuf-sync 6976/8283]
 drivers/ata/libata-core.c:574:19: sparse: restricted __le32 degrades to
 integer
Date: Sat, 31 Aug 2013 09:04:59 -0400
Message-ID: <20130831130459.GA16257@mtj.dyndns.org>
References: <52216105.LDLPibKhwtk4ZtnD%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:60707 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738Ab3HaNFD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Aug 2013 09:05:03 -0400
Received: by mail-qc0-f174.google.com with SMTP id e9so493576qcy.5
        for <linux-ide@vger.kernel.org>; Sat, 31 Aug 2013 06:05:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <52216105.LDLPibKhwtk4ZtnD%fengguang.wu@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Marc Carino <marc.ceeeee@gmail.com>, kbuild-all@01.org, linux-ide@vger.kernel.org

Hello, Marc.

On Sat, Aug 31, 2013 at 11:20:37AM +0800, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos dmabuf-sync
> head:   22c9eba34ec4787b6a32dcf521c6e07b3abfc146
> commit: 8be5ad9acb7c11b9d717bcdbe3d6de0dab081a39 [6976/8283] libata: Populate host-to-device FIS "auxiliary" field
> reproduce: make C=1 CF=-D__CHECK_ENDIAN__
...
>  > 574		fis[16] = aux & 0xff;
>    575		fis[17] = (aux >> 8) & 0xff;
>    576		fis[18] = (aux >> 16) & 0xff;
>    577		fis[19] = (aux >> 24) & 0xff;

So, this warning comes from ->aux handling in ata_tf_to_fis() and
looking at it I don't think the code is correct.

	const __le32 aux = cpu_to_le32(tf->auxiliary);

	...
	fis[16] = aux & 0xff;
	fis[17] = (aux >> 8) & 0xff;
	fis[18] = (aux >> 16) & 0xff;
	fis[19] = (aux >> 24) & 0xff;

If it's byte-by-byte assignments, why is it doing cpu_to_le32() too?
The above code is broken and will actually make fis[] fields to be
big-endian on big-endian machines.

Please consider the following.

	u32 a = 0x01020304;

	printf("%d %d %d %d\n", a & 0xff, (a >> 8) & 0xff,
	       (a >> 16) & 0xff, (a >> 24) & 0xff);

The output will *always* be "1 2 3 4" regardless of the endianness of
the machine.

Can you please submit a patch to fix this?

Thanks.

-- 
tejun
