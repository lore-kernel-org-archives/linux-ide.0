From: Tejun Heo <htejun@gmail.com>
Subject: Re: [ANNOUNCE] libata EH/NCQ/hotplug/PM git tree
Date: Thu, 11 May 2006 16:07:40 +0900
Message-ID: <4462E2BC.5070808@gmail.com>
References: <44614592.7080301@gmail.com> <1147316967.7273.26.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.207]:64199 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965184AbWEKHHq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 03:07:46 -0400
Received: by nz-out-0102.google.com with SMTP id 13so120625nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 00:07:45 -0700 (PDT)
In-Reply-To: <1147316967.7273.26.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Albert Lee <albertcc@tw.ibm.com>, Jens Axboe <axboe@suse.de>, Edward Falk <efalk@google.com>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Raymond Liu <Raymond.Liu@siliconimage.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi, Zhao.

zhao, forrest wrote:
> On Wed, 2006-05-10 at 10:44 +0900, Tejun Heo wrote:
>> Hello, all.
> Tejun,
> 
> I have comments about definition of macro ata_link_for_each_dev(dev,
> link) and struct ata_port{};.
> 
> In the definition of struct ata_port{}, there's
> ......
> struct ata_link link;
> struct ata_device __dev1;
> ......
> 
> Then macro ata_link_for_each_dev() assumes that the field 'device' in
> struct ata_link is adjacent to field '__dev1' in struct ata_port.
> 
> I think this assumption is not correct in theory. Because the alignment
> may make these two fields not adjacent in memory.
> 
> Although we haven't found the problem so far, it's very dangerous to
> have such assumption in the code.

Well, I think the technique is pretty widespread w/ flexible array
member, which is C99 standard and before C99 GCC had zero length array
for the same purpose.  e.g.

struct asdf {
	int nr_entries;
	void *ar[];
};

struct asdf *p;

p = kmalloc(sizeof(*p) + nr * sizeof(p->ar[0], GFP_KERNEL);
if (p)
	p->nr_entries = nr;

This works because alignof(outer struct) >= alignof(nested struct).  So,
we might end up allocating a few extra bytes due to alignment
requirements but that's perfectly okay.

__dev1 is the same.  It might or might not be allocated right after
link->dev[0] but it's guaranteed that &link->dev[1] <= &link->__dev1.
So, no problem there.  I'm pretty sure that this kind of technique is
used in other parts of the kernel too.

-- 
tejun
