From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 8/12] ide-floppy: merge idefloppy_{input,output}_buffers
Date: Mon, 14 Jan 2008 22:38:35 +0100
Message-ID: <200801142238.35893.bzolnier@gmail.com>
References: <1200255505-31418-1-git-send-email-bbpetkov@yahoo.de> <1200255505-31418-8-git-send-email-bbpetkov@yahoo.de> <1200255505-31418-9-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:2318 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbYANVoK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jan 2008 16:44:10 -0500
Received: by ug-out-1314.google.com with SMTP id z38so900341ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 14 Jan 2008 13:44:08 -0800 (PST)
In-Reply-To: <1200255505-31418-9-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sunday 13 January 2008, Borislav Petkov wrote:
> We merge idefloppy_{input,output}_buffers() into idefloppy_io_buffers() by
> introducing a 4th arg. called direction. According to its value
> we atapi_input_bytes() or atapi_output_bytes(). Also, this simplifies the
> interrupt handler logic a bit. Finally, rename idefloppy_io_buffers() to
> ide_floppy_io_buffers().
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

This change depends on "ide-floppy: use an xfer_func_t and io_buf_t typedefs
in order to unify rw" which was not in the "v2.5" series.

I took the patch #16/21 from the previous series and applied it manually
fixing rejects, please verify that I didn't brake something in the process.

[...]

> @@ -380,8 +352,13 @@ static void idefloppy_output_buffers (ide_drive_t *drive, idefloppy_pc_t *pc, un
>  	idefloppy_do_end_request(drive, 1, done >> 9);
>  
>  	if (bcount) {
> -		printk(KERN_ERR "%s: leftover data in idefloppy_output_buffers, bcount == %d\n", drive->name, 
bcount);
> -		idefloppy_write_zeros(drive, bcount);
> +		printk(KERN_ERR "%s: leftover data in idefloppy_output_buffers,"
> +			" bcount == %d\n", drive->name, bcount);

I fixed the above to use __func__ while at it.

[ __FUNCTION__ is gcc-specific, __func__ is in C99 and is shorter ]
