From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH RESEND number 2] libata: eliminate the home grown dma
 padding in favour of that provided by the block layer
Date: Mon, 04 Feb 2008 10:28:25 +0900
Message-ID: <47A66A39.7090800@gmail.com>
References: <1199138168.3110.12.camel@localhost.localdomain>	 <1200698057.3111.68.camel@localhost.localdomain>	 <1201894847.3134.59.camel@localhost.localdomain>	 <47A37AF3.3030503@garzik.org>	 <1201900175.3134.67.camel@localhost.localdomain> <47A52F23.70506@gmail.com>	 <1202013174.3187.69.camel@localhost.localdomain>	 <47A56F2B.4040904@gmail.com>	 <1202049511.3318.13.camel@localhost.localdomain>	 <47A5DA5F.3070209@gmail.com> <1202055156.3318.58.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:10586 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457AbYBDB2d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Feb 2008 20:28:33 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1342614rvb.1
        for <linux-ide@vger.kernel.org>; Sun, 03 Feb 2008 17:28:32 -0800 (PST)
In-Reply-To: <1202055156.3318.58.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Jens Axboe <Jens.Axboe@oracle.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

James Bottomley wrote:
> On Mon, 2008-02-04 at 00:14 +0900, Tejun Heo wrote:
>> James Bottomley wrote:
>>> I'm reluctant to add another parameter to the request, but this one you
>>> can calculate:  you just do it wherever you work out the size of the
>>> request.  If data_len is the true data length and total_data_len is the
>>> data length plus the drain length, the calculation fragment is
>>>
>>> if (blk_pc_request(req))
>>> 	data_len = req->data_len;
>>> else
>>> 	data_len = req->nr_sectors << 9;
>>> total_data_len = data_len + req->q->dma_drain_size;
>>>
>>> If the request has already been mapped by scsi, then data_len is
>>> actually scsi_cmnd->sdb.length
>> We either need to add a field or a helper and rq->data_len should
>> probably record the size with drain buffer attached and either add
>> raw_data_len or blk_rq_raw_data_len().  That size is the length of data
>> in sg and should be programmed into the controller etc... For ATAPI the
>> raw size is only used to program the chunk size for odd devices.
> 
> OK, could you show me an example of where you need it and I'll come up
> with the macro ... that should also help us decide whether it needs to
> be in block or in libata alone.  Note that aic94xx only wants the true
> size (we effectively treat the drain element as non existent), and I
> anticipate this being true of most conforming implementations.  It's
> only the problem HBAs that need to know how much slack they have for DMA
> overruns.

Some ATA controllers including SFF BMDMA and libata PIO HSM need the
number of bytes mapped in the sg table.  Yeah, it can be calculated with
a simple macro but it also is a fundamentally confusing dual-sizing
which should be made as clear as possible.  Plus, it can be difficult to
find out when somebody used the wrong thing, so what I'm saying is that
we need to make it easy.  Anyways, please lemme work on it a bit.  I'll
get back to you guys soon.

Thanks.

-- 
tejun
