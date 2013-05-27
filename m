From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 1/4] libata: add R-Car SATA driver
Date: Tue, 28 May 2013 00:32:36 +0400
Message-ID: <51A3C2E4.6070904@cogentembedded.com>
References: <201302202310.30443.sergei.shtylyov@cogentembedded.com> <519FF3D6.2090202@cogentembedded.com> <51A14665.3070508@cogentembedded.com> <20130525232024.GA11304@mtj.dyndns.org> <20130525232301.GB11304@mtj.dyndns.org> <51A14A9E.5060605@cogentembedded.com> <20130526002311.GA11809@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:34940 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932291Ab3E0Ucj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 May 2013 16:32:39 -0400
Received: by mail-la0-f50.google.com with SMTP id ed20so6796596lab.37
        for <linux-ide@vger.kernel.org>; Mon, 27 May 2013 13:32:37 -0700 (PDT)
In-Reply-To: <20130526002311.GA11809@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, vladimir.barinov@cogentembedded.com

Hello.

On 05/26/2013 04:23 AM, Tejun Heo wrote:

>
>>     Because with SFF-8038i  (BMIDE) controllers transfer can't cross
>> 64KiB address boundaries. This function has to break up those S/G
>> entries that do cross them. I.e. the PRD length is actually additionally
>> limited by an offset of its start within 64KiB memory segment.
>> Does this make sense? Or does the block layer already care about this?
>> Hm, I'm not confident now, should revisit this after some sleep.
> Yeah, that's exactly where I'm confused.  ATA_DMA_BOUNDARY is 64k
> which becomes both queue_segment_boundary and dma seg_boundary.
> AFAICS, both __blk_segment_map_sg() and dma mapping won't merge across
> seg_boundary and as each bvec is a single page at most, we shouldn't
> need to worry about getting sg's which cross 64k boundaries in bmdma
> controllers.  Hmmmmm...... I gotta be missing something.  What am I
> missing here?

     Probably nothing... maybe Jeff just copied that from ATADRVR
(which was his inspiration IIRC).
    BTW, I've just done some experimentation with my R-Car target
and ATA_DEBUG/ATA_VERBOSE_DEBUG #define'd and it turned out
that block layer didn't merge any segments at all... :-/

> Thanks.
>

WBR, Sergei

