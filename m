From: Christoph Hellwig <hch@lst.de>
Subject: Re: Issues with commit 34b48db6 ("block: remove artifical
	max_hw_sectors cap")
Date: Mon, 5 Jan 2015 18:18:38 +0100
Message-ID: <20150105171838.GB30028@lst.de>
References: <Pine.LNX.4.44L0.1412301017060.30572-100000@netrider.rowland.org> <54A2D07B.4040607@interlog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54A2D07B.4040607@interlog.com>
Sender: linux-scsi-owner@vger.kernel.org
To: Douglas Gilbert <dgilbert@interlog.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Christoph Hellwig <hch@lst.de>, "Kenneth R. Crudup" <kenny@panix.com>, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
List-Id: linux-ide@vger.kernel.org

On Tue, Dec 30, 2014 at 11:19:07AM -0500, Douglas Gilbert wrote:
> In SCSI, the VPD page 0xb0 (Block limits) has a "Maximum transfer
> length" field (32 bits long). Its units are logical blocks. Useful
> if >0 as 0 means "unreported".
>
> USB to SATA bridges should comply with SAT. However SAT and SAT-2
> don't even mention that VPD page. SAT-3 and SAT-4 mention that page
> but have "unspecified" next to that field. Basically useless.

Maybe we need to cap the max sectors value to something fairly low
unless we have the block limits VPD page and it contains useful information.
