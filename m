From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET 8/9] prep for hotplug support
Date: Thu, 27 Apr 2006 05:22:50 -0400
Message-ID: <44508D6A.3050200@pobox.com>
References: <11447643813451-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49059 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964995AbWD0JW4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Apr 2006 05:22:56 -0400
In-Reply-To: <11447643813451-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, all.
> 
> This is the first take of prep-for-hotplug-support patchset.  As the
> name suggests, this patchset prepares libata for hotplug support.
> This patchset contains 15 patches.
> 
> #01-02	update sata_sil (hotplug related constants, new interrupt handler)
> #03-04	misc libata preps
> #05-12	prepare ata_bus_probe()
> #13-15	hotplug flags, extra fields, hotplug_wq

ACK, modulo the minor comments just sent.

Also, in general libata needs a rethink when it comes to workqueues. 
Sometimes a single thread is more appropriate than the workqueue default 
of one-thread-per-CPU.  Using workqueues in the default state is quite 
efficient, but can also given you a huge number of idle threads on a 
$BIGNUM CPU box.  Workqueues on a 16-CPU box can be pretty insane...

	Jeff



