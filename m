From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Subject: Re: [PATCH] ide: another possible ide panic fix for blk-end-request
Date: Tue, 05 Feb 2008 14:14:06 -0500 (EST)
Message-ID: <20080205.141406.78706562.k-ueda@ct.jp.nec.com>
References: <20080204.145312.39152078.k-ueda@ct.jp.nec.com>
	<20080205060157.GB29807@gollum.tnic>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:36631 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757851AbYBETPK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Feb 2008 14:15:10 -0500
In-Reply-To: <20080205060157.GB29807@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com, petkovbb@googlemail.com
Cc: jens.axboe@oracle.com, bzolnier@gmail.com, linux-ide@vger.kernel.org, j-nomura@ce.jp.nec.com, k-ueda@ct.jp.nec.com

Hi Boris,

On Tue, 5 Feb 2008 07:01:57 +0100, Borislav Petkov wrote:
> On Mon, Feb 04, 2008 at 02:53:12PM -0500, Kiyoshi Ueda wrote:
> > Hi Jens, Bart, Boris,
> > 
> > I have reviewed all blk-end-request patches again to confirm whether
> > there are any similar problems with the last week's ide-cd panic:
> >     http://lkml.org/lkml/2008/1/29/140
> > 
> > And I found a possible similar bug in ide-io change:
> > ide_end_drive_cmd() could be called for blk_pc_request() which could
> > have bios.
> 
> You mean ide_abort() and ide_error(), right?
> Because ide{-tape,-floppy,-scsi} do call already ide_end_request()
> for non-special rq's (!blk_special_request()), except ide-scsi
> filters also on !blk_sense_request().

That's right.

Thanks,
Kiyoshi Ueda
