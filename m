From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [libata] REQUEST_SENSE support for ATAPI
Date: Sat, 16 Oct 2004 19:29:09 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e04101610295e039481@mail.gmail.com>
References: <58cb370e0410151606566a6627@mail.gmail.com>
	 <41706533.4030906@pobox.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.200]:59557 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268189AbUJPR3L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Oct 2004 13:29:11 -0400
Received: by mproxy.gmail.com with SMTP id 77so64961rnk
        for <linux-ide@vger.kernel.org>; Sat, 16 Oct 2004 10:29:09 -0700 (PDT)
In-Reply-To: <41706533.4030906@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Fri, 15 Oct 2004 20:02:59 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> applied both to libata-dev queue.  comments:
> 
> * Christoph/James will probably complain about use of scsi_priv.h

Probably SCSI headers should be fixed instead
(libata is currently the only eh_strategy_handler user)...

> * my gut feeling is that atapi_request_sense() belongs in libata-scsi.c

No opinion here...

Anyway I can fix these issues if needed...
