From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [libata] REQUEST_SENSE support for ATAPI
Date: Fri, 15 Oct 2004 20:02:59 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41706533.4030906@pobox.com>
References: <58cb370e0410151606566a6627@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1203 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267793AbUJPADM
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Oct 2004 20:03:12 -0400
In-Reply-To: <58cb370e0410151606566a6627@mail.gmail.com>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

applied both to libata-dev queue.  comments:

* Christoph/James will probably complain about use of scsi_priv.h

* my gut feeling is that atapi_request_sense() belongs in libata-scsi.c


