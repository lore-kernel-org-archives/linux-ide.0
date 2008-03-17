From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 00/10] sg buffer copy helper functions
Date: Mon, 17 Mar 2008 10:06:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803171002230.3463-100000@iolanthe.rowland.org>
References: <20080317122350F.tomof@acm.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20080317122350F.tomof@acm.org>
Sender: linux-scsi-owner@vger.kernel.org
To: FUJITA Tomonori <tomof@acm.org>
Cc: fujita.tomonori@lab.ntt.co.jp, bharrosh@panasas.com, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, James.Bottomley@HansenPartnership.com, jens.axboe@oracle.com, dougg@torque.net, Geert.Uytterhoeven@sonycom.com, tony.luck@intel.com, Mark_Salyzyn@adaptec.com, ed.lin@promise.com, linuxraid@amcc.com, linux-usb@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, 17 Mar 2008, FUJITA Tomonori wrote:

> For me, it would be much better to fix USB drivers since LLDs should
> not rely on a scatterlist about how much data they transfer, as I
> said. If LLDs do that, they are broken. It's not good to add such a
> workaround to the common API for broken LLDs.
> 
> USB drivers should do something like this if they definitely need to
> call this API multiple times:
> 
>      done = sg_copy_buffer(buffer, scsi_bufflen(sc) - us->done_length,
>      us->done_length += done;

The USB drivers don't need to be fixed; they are already correct.

But if you are going to export a library routine for general use then
it should be written to fail gracefully -- it should not be able to
cause an invalid memory access.

Alan Stern

