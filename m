From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [patch libata-dev-2.6 1/1] libata: sync SMART ioctls with ATA pass thru spec (T10/04-262r7)
Date: Wed, 2 Feb 2005 13:59:22 -0500
Message-ID: <20050202185922.GD17450@tuxdriver.com>
References: <20050202183753.GB17450@tuxdriver.com> <20050202185121.GX11484@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from ra.tuxdriver.com ([24.172.12.4]:59153 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262547AbVBBS7f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2005 13:59:35 -0500
Content-Disposition: inline
In-Reply-To: <20050202185121.GX11484@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, andyw@pobox.com, jgarzik@pobox.com, Curtis.Stevens@WDC.com

On Wed, Feb 02, 2005 at 07:51:22PM +0100, Jens Axboe wrote:
> On Wed, Feb 02 2005, John W. Linville wrote:

> > -/* Temporary values for T10/04-262 until official values are allocated */
> > -#define	ATA_16		      0x85	/* 16-byte pass-thru [0x85 == unused]*/
> > -#define	ATA_12		      0xb3	/* 12-byte pass-thru [0xb3 == obsolete set limits command] */
> > +/* Values for T10/04-262r7 */
> > +#define	ATA_16		      0x85	/* 16-byte pass-thru */
> > +#define	ATA_12		      0xa1	/* 12-byte pass-thru */
> 
> Ehh are you sure that is correct? 0xa1 is the BLANK command, I would
> hate to think there would be a collision like that.

Well, I'm sure that is what is in T10/04-262r7 in Table 1 on Page 1.
The spec is available here:

	http://www.t10.org/ftp/t10/document.04/04-262r7.pdf

Previous versions of the spec did not specify a value.  As to whether
or not the current spec is in error, hopefully Curtis can elablorate?

John
-- 
John W. Linville
linville@tuxdriver.com
