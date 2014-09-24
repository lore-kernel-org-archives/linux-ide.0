From: Daniele Forsi <dforsi@gmail.com>
Subject: Re: Unable to complete boot with pata_sis
Date: Wed, 24 Sep 2014 23:07:17 +0200
Message-ID: <CAN_we7NnLLVpgm8eNOp8GdcoUm=UWHODdO4y3Gy3rGBBqXCj6w@mail.gmail.com>
References: <CAN_we7P6RF_OnBivLYqnpeftJH64st3msX-dJROetz1UxpDLjw@mail.gmail.com>
	<20140730155735.20b6d12c@alan.etchedpixels.co.uk>
	<CAN_we7P38OjX5dqDV5CuxS32xnnL-xXeu8GaFciwanqMSDGmSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:46529 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbaIXVHT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Sep 2014 17:07:19 -0400
Received: by mail-la0-f48.google.com with SMTP id ty20so11277457lab.7
        for <linux-ide@vger.kernel.org>; Wed, 24 Sep 2014 14:07:17 -0700 (PDT)
In-Reply-To: <CAN_we7P38OjX5dqDV5CuxS32xnnL-xXeu8GaFciwanqMSDGmSg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

> 2014-07-30 16:57 GMT+02:00 One Thousand Gnomes:
>
>> Somewhere there is a subtle behavioural difference between pata_sis and
>> the ancient sis5513 driver. About the only way to find it would be to
>> boot both the old and new kernels and log every single access to the disk
>> controller to the point of failure (or some short way into booting) in
>> both cases somewhere (eg over the network) then compare them.

is there a standard way to log those accesses to the disk controller?
Or is it enough to dump the values passed to pci_write_config_* like I
did in my previous email:
http://marc.info/?l=linux-ide&m=140744732530027&w=2

-- 
Daniele Forsi
