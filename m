From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata vs ATAPI
Date: Tue, 12 Oct 2004 17:46:33 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <416C50B9.2030703@pobox.com>
References: <58cb370e04101213215ce9a23c@mail.gmail.com>	 <416C438C.4010902@pobox.com>	 <58cb370e0410121417591ecff0@mail.gmail.com> <416C4CDE.40704@pobox.com> <58cb370e04101214392a8aae4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13237 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267939AbUJLVqr
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Oct 2004 17:46:47 -0400
In-Reply-To: <58cb370e04101214392a8aae4@mail.gmail.com>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Jens Axboe <axboe@suse.de>

Bartlomiej Zolnierkiewicz wrote:
> On Tue, 12 Oct 2004 17:30:06 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Another for the todo list:
>>
>>ATAPI PIO data xfer should _read_ bcount, to determine how many bytes to
>>read.  I forget if I do this, but I don't think so...
> 
> 
> atapi_pio_sector() does it...


Ah yes.  Well, don't add that to the todo list then :)

	Jeff


