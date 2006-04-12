From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET 8/9] prep for hotplug support
Date: Wed, 12 Apr 2006 10:41:59 +0900
Message-ID: <443C5AE7.4060909@gmail.com>
References: <11447643813451-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.200]:26361 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751292AbWDLBmO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 21:42:14 -0400
Received: by zproxy.gmail.com with SMTP id o37so1244735nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 18:42:13 -0700 (PDT)
In-Reply-To: <11447643813451-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> This is the first take of prep-for-hotplug-support patchset.  As the
> name suggests, this patchset prepares libata for hotplug support.
> This patchset contains 15 patches.

13 patches, obviously. :/

> #01-02	update sata_sil (hotplug related constants, new interrupt handler)

These two are moved to the next patchset right before sata_sil hotplug 
update at the last minutes and I forgot to update the head message.  Sorry.

> #03-04	misc libata preps
> #05-12	prepare ata_bus_probe()
> #13-15	hotplug flags, extra fields, hotplug_wq

-- 
tejun
