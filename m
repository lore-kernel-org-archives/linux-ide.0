From: James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [PATCH/RFT] libata "DMA timeout" fix
Date: 28 Feb 2004 15:28:31 -0600
Sender: linux-scsi-owner@vger.kernel.org
Message-ID: <1078003712.2020.92.camel@mulgrave>
References: <4040E7B5.4020709@pobox.com>
	<1078001357.2020.90.camel@mulgrave>  <404106D7.8050809@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <404106D7.8050809@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, SCSI Mailing List <linux-scsi@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Sat, 2004-02-28 at 15:23, Jeff Garzik wrote:
> Yeah, that's much better.  That function is not exported though ;-)

I can fix that.  It really is a necessary function for drivers doing
their own strategy handler ... of which yours seems to be the only one.

James


