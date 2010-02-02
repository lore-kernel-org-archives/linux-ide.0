From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 520 Bytes sector size
Date: Tue, 2 Feb 2010 23:25:40 +0000
Message-ID: <20100202232540.7f5327f6@lxorguk.ukuu.org.uk>
References: <93b143da1002020450sf495912ib0ea75989d1d8928@mail.gmail.com>
	<yq1aavrqlxw.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50406 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752792Ab0BBXY7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Feb 2010 18:24:59 -0500
In-Reply-To: <yq1aavrqlxw.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Dan Porat <dan.porat@gmail.com>, linux-ide@vger.kernel.org

On Tue, 02 Feb 2010 18:04:11 -0500
"Martin K. Petersen" <martin.petersen@oracle.com> wrote:

> >>>>> "Dan" == Dan Porat <dan.porat@gmail.com> writes:
> 
> Dan> I would like to run 520 Bytes disk in native mode.  What changes I
> Dan> have to run in sg driver ?  Is there any kernel already adapted for
> Dan> 520 bytes sector size ?
> 
> Linux does not support 520-byte sectors unless the drive is formatted
> with DIF and hanging off a DIF-capable HBA.

Is that true even with sg - I wouldn't have thought sg minded, it doesn't
seem to mind about strange sized transfers for CD-ROM ?
