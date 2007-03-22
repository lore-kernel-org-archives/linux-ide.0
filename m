From: Aristeu Sergio Rozanski Filho <aristeu.sergio@gmail.com>
Subject: Re: 2.6.20.3 AMD64 oops in CFQ code
Date: Thu, 22 Mar 2007 14:43:35 -0400
Message-ID: <20070322184335.GB31733@cathedrallabs.org>
References: <20070322123821.7843.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.228]:49011 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934170AbXCVSni (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Mar 2007 14:43:38 -0400
Received: by wx-out-0506.google.com with SMTP id h31so957188wxd
        for <linux-ide@vger.kernel.org>; Thu, 22 Mar 2007 11:43:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070322123821.7843.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux@horizon.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk

> This is a uniprocessor AMD64 system running software RAID-5 and RAID-10
> over multiple PCIe SiI3132 SATA controllers.  The hardware has been very
> stable for a long time, but has been acting up of late since I upgraded
> to 2.6.20.3.  ECC memory should preclude the possibility of bit-flip
> errors.
Tried checking the memory with memtest86?

Do you have k8_edac module loaded?
If you don't, I'd recomend using it to get reports of
recoverable/unrecoverable memory errors, check http://bluesmoke.sf.net/ for
latest version.

-- 
Aristeu

