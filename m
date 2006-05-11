From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [ANNOUNCE] libata EH/NCQ/hotplug/PM git tree
Date: Thu, 11 May 2006 11:09:27 +0800
Message-ID: <1147316967.7273.26.camel@forrest26.sh.intel.com>
References: <44614592.7080301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53407 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S965121AbWEKDUS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 May 2006 23:20:18 -0400
In-Reply-To: <44614592.7080301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Albert Lee <albertcc@tw.ibm.com>, Jens Axboe <axboe@suse.de>, Edward Falk <efalk@google.com>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Raymond Liu <Raymond.Liu@siliconimage.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Wed, 2006-05-10 at 10:44 +0900, Tejun Heo wrote:
> Hello, all.
Tejun,

I have comments about definition of macro ata_link_for_each_dev(dev,
link) and struct ata_port{};.

In the definition of struct ata_port{}, there's
......
struct ata_link link;
struct ata_device __dev1;
......

Then macro ata_link_for_each_dev() assumes that the field 'device' in
struct ata_link is adjacent to field '__dev1' in struct ata_port.

I think this assumption is not correct in theory. Because the alignment
may make these two fields not adjacent in memory.

Although we haven't found the problem so far, it's very dangerous to
have such assumption in the code.

Does this make sense to you?

Thanks,
Forrest
