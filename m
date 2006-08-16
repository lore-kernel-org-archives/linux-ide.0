From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: More ATA corner cases
Date: Wed, 16 Aug 2006 14:27:11 +0200
Message-ID: <20060816122710.GJ15015@harddisk-recovery.com>
References: <1155731962.24077.346.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dtp.xs4all.nl ([80.126.206.180]:22679 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751153AbWHPM1N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Aug 2006 08:27:13 -0400
Content-Disposition: inline
In-Reply-To: <1155731962.24077.346.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Wed, Aug 16, 2006 at 01:39:22PM +0100, Alan Cox wrote:
> Any objection to me adding a new cable type for "40 wire ATA66 capable"
> to indicate the laptop vendor has been sneaky and we should do full UDMA
> ranges regardless of drive or other controller reporting.

Makes sense, lots of laptops do this.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
