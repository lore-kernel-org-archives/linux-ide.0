From: Tejun Heo <tj@kernel.org>
Subject: Re: Another FIXME in libata-scsi.c
Date: Thu, 4 Dec 2014 16:01:10 -0500
Message-ID: <20141204210110.GF4080@htj.dyndns.org>
References: <547FDDFF.7050802@gmail.com>
 <20141204182326.GC4080@htj.dyndns.org>
 <5480CAEF.8030500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5480CAEF.8030500@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nick <xerofoify@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Dec 04, 2014 at 03:58:23PM -0500, nick wrote:
> Are you sure as it seems FIX MES mean unfinished work and issues. I
> would personally remove the FIX ME part at least.

It really doesn't matter unless it's actively misleading.  If you have
good enough justification that the comment is unnecessary /
misleading, please feel free to submit a patch with accompanying
rationales but it's not something we should spend time and energy
collaborating on.

Thanks.

-- 
tejun
