From: Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH v3 3/3] libata: use blk taging
Date: Fri, 23 Jan 2015 14:13:08 -0700
Message-ID: <54C2B964.4030304@fb.com>
References: <81b8ef84122544faa1f37a404cf2e7c71791d961.1421371412.git.shli@fb.com> <92a8da78d57926f61e9050168499872d52066f1c.1421371412.git.shli@fb.com> <20150116082344.GA4913@infradead.org> <20150116221600.GA1099317@devbig257.prn2.facebook.com> <20150122211220.GA2123210@devbig257.prn2.facebook.com> <20150123201305.GC23011@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16246 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751710AbbAWVNS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Jan 2015 16:13:18 -0500
In-Reply-To: <20150123201305.GC23011@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Shaohua Li <shli@fb.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ide@vger.kernel.org, Kernel-team@fb.com, dan.j.williams@intel.com

On 01/23/2015 01:13 PM, Tejun Heo wrote:
> On Thu, Jan 22, 2015 at 01:12:20PM -0800, Shaohua Li wrote:
>> Hi Tejun,
>> are you ok to pick up these patches?
> 
> Yeah, looks fine from libata side.  Please feel free to add
> 
>  Acked-by: Tejun Heo <tj@kernel.org>
> 
> and route as you see fit.  If these can go through libata, please let
> me know.

I'll just take it through the block tree, there's the highest risk of
conflict there with the tagging changes.

-- 
Jens Axboe

