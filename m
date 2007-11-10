From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: cd/dvd inaccessible in 2.6.24-rc2
Date: Sat, 10 Nov 2007 14:49:23 -0800
Message-ID: <20071110144923.beb7bbae.akpm@linux-foundation.org>
References: <1194668831.3436.14.camel@Athas>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44569 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754760AbXKJWtf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Nov 2007 17:49:35 -0500
In-Reply-To: <1194668831.3436.14.camel@Athas>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Will Trives <will@trivescon.com.au>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Sat, 10 Nov 2007 15:27:11 +1100 Will Trives <will@trivescon.com.au> wrote:

> 
> Hello,
> 
> Motherboard: Gigabyte GA-P35-DS4 (rev. 1.1)
> Chipset: Intel P35 + ICH9R 
> PATA port runs off JMicron controller
> CD/DVD Device: BENQ DW1640 16X
> 
> I cannot access my dvd burner under 2.6.24-rc2, I have no problems under
> 2.6.23. Basically the drive is detected OK, everything looks ok but as
> soon as I go to use it errors like this occur:
> 
> 
> ata9.00: qc timeout (cmd 0xa0)
> ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata9.00: cmd a0/00:00:00:02:00/00:00:00:00:00/a0 tag 0 cdb 0x5a data 2
> in
>          res 51/54:03:00:02:00/00:00:00:00:00/a0 Emask 0x5 (timeout)
> ata9.00: status: { DRDY ERR }
> ata9: soft resetting link
> ata9.00: revalidation failed (errno=-2)
> ata9: failed to recover some devices, retrying in 5 secs
> ata9: soft resetting link
> ata9.00: qc timeout (cmd 0xa1)
> ata9.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata9.00: revalidation failed (errno=-5)
> ata9: failed to recover some devices, retrying in 5 secs
> ata9: soft resetting link
> ata9.00: qc timeout (cmd 0xa1)
> ata9.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata9.00: revalidation failed (errno=-5)
> ata9.00: disabled
> ata9: soft resetting link
> ata9: EH complete
> 
> The drive is locked up after the first attempt to access it occurs, the
> tray cannot be ejected. 
> 
> 
> dmesg output
> 
> http://paste.ubuntu-nl.org/43948/
> 
> kernel .config
> 
> http://paste.ubuntu-nl.org/43944/
> 
> lspci -vvvxxxx
> 
> http://paste.ubuntu-nl.org/43950/
> 

Thanks for letting us know.

Added linux-ide Cc.

Rafael, it looks like another regression.
