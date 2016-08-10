From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH v5 2/2] Add support for SCT Write Same
Date: Wed, 10 Aug 2016 19:30:31 +0800
Message-ID: <CAGnHSEkQXN5+6_OLQZEREWp1+W8kn8=ew=oH52oSsV7CaZwOBQ@mail.gmail.com>
References: <1470790829-3793-1-git-send-email-shaun@tancheff.com>
 <1470790829-3793-3-git-send-email-shaun@tancheff.com> <CAGnHSEkJtUH6BkLoNB7v1DkF8ffaUf3RX+m=QzMU0-OmG0ZwFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33954 "EHLO
	mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932481AbcHJUTj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Aug 2016 16:19:39 -0400
In-Reply-To: <CAGnHSEkJtUH6BkLoNB7v1DkF8ffaUf3RX+m=QzMU0-OmG0ZwFw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaun Tancheff <shaun@tancheff.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, Josh Bingaman <josh.bingaman@seagate.com>, Shaun Tancheff <shaun.tancheff@seagate.com>

On 10 August 2016 at 14:31, Tom Yan <tom.ty89@gmail.com> wrote:
> I don't really know about SCT Write Same but there is one concern I
> could I think of.
>
> libata's SATL would report a maximum write same length base on the
> number of sectors a one-block TRIM payload can describe at most, which
> is 65535 * 64 = 4194240 (see ata_scsiop_inq_b0 in libata-scsi.c). If
> the drive does not support TRIM, it will not report such length. That
> is technically fine, as per SBC standard, and I suppose the SCSI disk
> driver would use SD_MAX_WS16_BLOCKS = 0x7fffff (8388607).

Actually it will use SD_MAX_WS10_BLOCKS = 0xffff (65535) in such case.
See sd_config_write_same() in sd.c. So if the device support TRIM,
each SCT Write Same will cover 4194240 logical sectors; if it does
not, each will cover 65535 logical sectors. In that case, perhaps we
should report the same value in the Maximum Write Same Length field
when (only) SCT Write Same is supported? (Not the Optimal Unmap
Granularity field though).
