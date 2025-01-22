Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E50211712
	for <linux-ide@vger.kernel.org>; Wed, 22 Jan 2025 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737557958; cv=none; b=QFBkzxuy9eH1ukvlrdXJNbeUbEkUwTfVQENtqeh4OwIsiZgBgYPsfULOpA0z4/Z/+sgcaj917jVXyVUNyAVq/fvQN6Fvhuse+KLz0bdOCLmDz5jUCSrN/zM/kkL+8DtT0Zp/cgPZhcn9SJ6dLgi8DkB8e9Ly0neovDpFWPL/DC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737557958; c=relaxed/simple;
	bh=lJWRKWh+53BHw2fCEN7ze+KYRV16EZ87/o9mwCUhhhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tf8boayJIeSBJQnUnvboC6tHAiitBR9/mxmbtpGgaUC1jzaFe4OhksO56c1HIlzjL18mExXr1+yJfsRss96tIG6jTv2jmA6TzZ6wFdHngg0wPKaA+rVj/+9m4Phxz5DGSmCpRzRIQJ5QNXTR1MfAXOV6vcbMxFsRYZXhn5AQuaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zmdo6ubf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zmdo6ubf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEABC4CED2;
	Wed, 22 Jan 2025 14:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737557958;
	bh=lJWRKWh+53BHw2fCEN7ze+KYRV16EZ87/o9mwCUhhhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zmdo6ubfezEGz2S/zr3lKklh/X68H0bXgv/e1iALSN/u+upvinhFeqd2jPQCiE43a
	 Y7SmJBkBJyv5V0OaN4uhx4l4m0zInFjTmJ8ZDwA4BJaCv5yuq4JtbbIdVJYhnLAqLU
	 hIlyhuZEk8tiqb9UFKDtWuJQISQnWVR6KcHdO10GXCffVHytPEGLMatf6cD9vqZ4pR
	 hFpYEMw6RW6eRJx6Em6qLQWerfX/4pIxcd+fiR8N2Q3vHTeRvLSo22M7kT2txWHaDd
	 P3SDvTUnl2dNQ/8u7A4+ds3j4C/3C+lcbGOxOe+WMSwML1IGClwq1KcyK2/soV5cZz
	 sR7oMz2/DqXTA==
Date: Wed, 22 Jan 2025 15:59:13 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	reveliofuzzing <reveliofuzzing@gmail.com>
Subject: Re: out-of-bounds write in the function ata_pio_sector
Message-ID: <Z5EHwRtTL1Oy6T8_@ryzen>
References: <CA+-ZZ_jTgxh3bS7m+KX07_EWckSnW3N2adX3KV63y4g7M4CZ2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-ZZ_jTgxh3bS7m+KX07_EWckSnW3N2adX3KV63y4g7M4CZ2A@mail.gmail.com>

Hello Jens, Christoph, Martin,

On Wed, Jan 01, 2025 at 09:17:02PM -0500, reveliofuzzing wrote:
> Hi there,
>
> We found an out-of-bounds write in the function ata_pio_sector, which can cause
> the kernel to crash. We would like to report it for your reference.
>
> ## Problem in ata_pio_sector
> ata_pio_sector uses the following code to decide which page to use for the I/O:
> page = sg_page(qc->cursg);
> offset = qc->cursg->offset + qc->cursg_ofs;
>
> /* get the current page and offset */
> page = nth_page(page, (offset >> PAGE_SHIFT));
> offset %= PAGE_SIZE;
> but we found that `offset` could be as high as 0x5000---qc->cursg_ofs==0x5000,
> qc->cursg->offset == 0x0, making `page` point to a higher-position page that
> belongs to other threads.

I've managed to reproduce this on v6.13 using reveliofuzzing syzkaller
reproducer (which issues SCSI_IOCTL_SEND_COMMAND to the /dev/sg devices).

The problem is that the final if-statement in function ata_pio_sector()
(which lives in drivers/ata/libata-sff.c) looks like this:

	if (qc->cursg_ofs == qc->cursg->length) {
		qc->cursg = sg_next(qc->cursg);
		if (!qc->cursg)
			ap->hsm_task_state = HSM_ST_LAST;
		qc->cursg_ofs = 0;
	}

When the memory corruption occurs, it is because this if-statement never
evaluated to true, so ata_pio_sector() just continued writing to more and
more pages, overwriting pages owned by other tasks.


Here is some trace_printks that I added that shows the problem:

     kworker/1:3-116     [001] d.h1.   121.445073: ata_pio_sector: 1/3 qc: ffff888008928130 cursg_ofs: 0x0 cursg->offset: 0x0 offset: 0x0 offset_mod: 0x0 sect_size: 0x200
     kworker/1:3-116     [001] d.h1.   121.445079: ata_pio_sector: 2/3 orig_page: ffffea0000263180 page: ffffea0000263180 page_diff: 0x0 nbytes: 0xd42 curbytes: 0x0
     kworker/1:3-116     [001] d.h1.   121.445098: ata_pio_sector: 3/3 qc->cursg_ofs: 0x200 qc->cursg->length: 0xd42 equal ? 0 n_elem: 1 orig_n_elem: 1
     kworker/1:3-116     [001] d.h1.   121.445164: ata_pio_sector: 1/3 qc: ffff888008928130 cursg_ofs: 0x200 cursg->offset: 0x0 offset: 0x200 offset_mod: 0x200 sect_size: 0x200
     kworker/1:3-116     [001] d.h1.   121.445168: ata_pio_sector: 2/3 orig_page: ffffea0000263180 page: ffffea0000263180 page_diff: 0x0 nbytes: 0xd42 curbytes: 0x200
     kworker/1:3-116     [001] d.h1.   121.445185: ata_pio_sector: 3/3 qc->cursg_ofs: 0x400 qc->cursg->length: 0xd42 equal ? 0 n_elem: 1 orig_n_elem: 1
     kworker/1:3-116     [001] d.h1.   123.492925: ata_pio_sector: 1/3 qc: ffff888008928130 cursg_ofs: 0x400 cursg->offset: 0x0 offset: 0x400 offset_mod: 0x400 sect_size: 0x200
     kworker/1:3-116     [001] d.h1.   123.492929: ata_pio_sector: 2/3 orig_page: ffffea0000263180 page: ffffea0000263180 page_diff: 0x0 nbytes: 0xd42 curbytes: 0x400
     kworker/1:3-116     [001] d.h1.   123.492943: ata_pio_sector: 3/3 qc->cursg_ofs: 0x600 qc->cursg->length: 0xd42 equal ? 0 n_elem: 1 orig_n_elem: 1
     kworker/1:3-116     [001] d.h1.   123.492990: ata_pio_sector: 1/3 qc: ffff888008928130 cursg_ofs: 0x600 cursg->offset: 0x0 offset: 0x600 offset_mod: 0x600 sect_size: 0x200
     kworker/1:3-116     [001] d.h1.   123.492993: ata_pio_sector: 2/3 orig_page: ffffea0000263180 page: ffffea0000263180 page_diff: 0x0 nbytes: 0xd42 curbytes: 0x600
     kworker/1:3-116     [001] d.h1.   123.493005: ata_pio_sector: 3/3 qc->cursg_ofs: 0x800 qc->cursg->length: 0xd42 equal ? 0 n_elem: 1 orig_n_elem: 1

We can see that qc->cursg_ofs gets incremented by qc->sect_size (0x200),
but since qc->cursg_ofs is never equal to qc->cursg->length (0xd42),
it doesn't stop, and ends up writing way more than qc->cursg->length.



If I compare the function:
/* Transfer qc->sect_size bytes of data from/to the ATA device. */
ata_pio_sector()

with function:
/* __atapi_pio_bytes - Transfer data from/to the ATAPI device. */
__atapi_pio_bytes()


I can see that __atapi_pio_bytes() actually has this code:
/* don't overrun current sg */
count = min(sg->length - qc->cursg_ofs, bytes);


which I guess makes sense, since the function has _bytes_ in the name.
ata_pio_sector() has _sector_ in the name, so it makes sense that it
would have to transfer one or more sectors (even if there currently
doesn't seem to be anything that guarantees this...).


So, should I add a similar:
count = min(sg->length - qc->cursg_ofs, bytes);
to ata_pio_sector(), or should I add code to
ata_pio_sector() that simply rejects a qc->nbytes that is not a multiple
of qc->sect_size ?



I was kind of expecting some upper layer, SCSI or block, to have rejected
an operation that is not a multiple of the sector size.

Is that a silly assumption?


Looking at drivers/scsi/scsi_ioctl.c:sg_scsi_ioctl() I can see that it
rejects:
if (in_len > PAGE_SIZE || out_len > PAGE_SIZE)


If I dump the request in gdb, it seems that:
cmd_flags is: REQ_OP_DRV_IN
__data_len is: 0xd42

(gdb) p /x *((struct request *) ((void*)qc->scsicmd - sizeof(struct request)))
$21 = {q = 0xffff888008d50000, mq_ctx = 0xffff88806d242980, mq_hctx = 0xffff88800781e000, 
  cmd_flags = 0x22, rq_flags = 0x18, tag = 0x0, internal_tag = 0x1, timeout = 0xea60, 
  __data_len = 0xd42, __sector = 0xffffffffffffffff, bio = 0xffff8880088fc700, 
  biotail = 0xffff8880088fc700, {queuelist = {next = 0xffff8880088f12c8, 
      prev = 0xffff8880088f12c8}, rq_next = 0xffff8880088f12c8}, part = 0x0, 
  alloc_time_ns = 0x0, start_time_ns = 0xa837cc389, io_start_time_ns = 0x0, 
  stats_sectors = 0x0, nr_phys_segments = 0x1, nr_integrity_segments = 0x0, state = 0x1, 
  ref = {counter = 0x1}, deadline = 0xfffd2516, {hash = {next = 0x0, pprev = 0x0}, 
    ipi_list = {next = 0x0}}, {rb_node = {__rb_parent_color = 0xffff8880088f1320, 
      rb_right = 0x0, rb_left = 0x0}, special_vec = {bv_page = 0xffff8880088f1320, 
      bv_len = 0x0, bv_offset = 0x0}}, elv = {icq = 0x0, priv = {0xffff88800781f860, 
      0x0}}, flush = {seq = 0x7, saved_end_io = 0x0}, fifo_time = 0xfffc2f88, 
  end_io = 0xffffffff81f55550, end_io_data = 0xffff88800de2fb80}

p /x qc->scsicmd->cmnd[0]
$25 = 0x85
include/scsi/scsi_proto.h:#define       ATA_16                0x85      /* 16-byte pass-thru */


which must have meant that:
in_len == 0, out_len = 0xd42 (3394).

The page size on this system is 4k (4096), so I suppose that out_len is not
greater than PAGE_SIZE.

So I guess that SCSI layer does not reject a request that is not a multiple of
the sector size.

So what is the best solution here?

Should we add such a check in SCSI? libata? or should each (libata) driver
themselves reject such a thing?

Advice is welcome :)


Kind regards,
Niklas
