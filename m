From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: libata vs ATAPI
Date: Tue, 12 Oct 2004 23:39:18 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e04101214392a8aae4@mail.gmail.com>
References: <58cb370e04101213215ce9a23c@mail.gmail.com>
	 <416C438C.4010902@pobox.com>
	 <58cb370e0410121417591ecff0@mail.gmail.com> <416C4CDE.40704@pobox.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.207]:21427 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267851AbUJLVjS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Oct 2004 17:39:18 -0400
Received: by mproxy.gmail.com with SMTP id 77so387719rnk
        for <linux-ide@vger.kernel.org>; Tue, 12 Oct 2004 14:39:18 -0700 (PDT)
In-Reply-To: <416C4CDE.40704@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Jens Axboe <axboe@suse.de>

On Tue, 12 Oct 2004 17:30:06 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> Another for the todo list:
> 
> ATAPI PIO data xfer should _read_ bcount, to determine how many bytes to
> read.  I forget if I do this, but I don't think so...

atapi_pio_sector() does it...
