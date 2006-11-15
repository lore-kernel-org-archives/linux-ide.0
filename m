From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: ata_piix on Thinkpad T30 - qc timeout on boot
Date: Wed, 15 Nov 2006 11:47:48 +0000
Message-ID: <20061115114748.7a51d03c@localhost.localdomain>
References: <1163563453.3100.24.camel@dv>
	<1163569390.4410.8.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49047 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932853AbWKOLmZ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Nov 2006 06:42:25 -0500
In-Reply-To: <1163569390.4410.8.camel@dv>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-ide@vger.kernel.org

On Wed, 15 Nov 2006 00:43:10 -0500
Pavel Roskin <proski@gnu.org> wrote:

> Hello again and sorry for post scriptum.
> 
> On Tue, 2006-11-14 at 23:04 -0500, Pavel Roskin wrote:
> 
> > ata2.01: qc timeout (cmd 0xa1)
> > ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)

Just about everyone is seeing this with the new EH code and current
libata. If you back out the EH changes life seems to go back to normal.

Alan
