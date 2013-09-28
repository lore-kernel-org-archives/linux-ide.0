From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] AHCI: disabled FBS prior to issuing software reset
Date: Sat, 28 Sep 2013 09:10:59 -0400
Message-ID: <20130928131059.GA3945@htj.dyndns.org>
References: <1380366816-16221-1-git-send-email-yxlraid@gmail.com>
 <20130928114950.GA2620@htj.dyndns.org>
 <CAP0P+NUvaLfXkOUGm8NX19AHvTHmU=Ya0NdFvyJc2gFjN-Cy0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP0P+NUvaLfXkOUGm8NX19AHvTHmU=Ya0NdFvyJc2gFjN-Cy0A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: xiangliang yu <yxlraid@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello,

On Sat, Sep 28, 2013 at 09:04:15PM +0800, xiangliang yu wrote:
> hi, Tejun
> i had tested the patch with Marvell 88se9235. And driver can find disk
> if FBS disabled, or can't find disk.

So it can't find the disk if FBS stays enabled?  Can you please attach
the boot log before & after?

> Please see chapter 9.3.9 and 9.3.8 of AHCI spec. Thanks.

Given how crappy and outdated PMP hardware are in general, I'm very
unwilling to make changes just because the spec says so, so please
stop repeating the spec and provide data.

Thanks.

-- 
tejun
