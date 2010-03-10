From: Tejun Heo <tj@kernel.org>
Subject: Re: Comment on ATA 4 KiB sector issues
Date: Wed, 10 Mar 2010 14:46:38 +0900
Message-ID: <4B97323E.1040807@kernel.org>
References: <Pine.GSO.4.63.1003080933100.4114@galaxy.agh.edu.pl> <4B95AEF6.8030906@kernel.org> <Pine.GSO.4.63.1003090947570.29136@galaxy.agh.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39066 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551Ab0CJFqw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Mar 2010 00:46:52 -0500
In-Reply-To: <Pine.GSO.4.63.1003090947570.29136@galaxy.agh.edu.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomasz Palac <palac@uci.agh.edu.pl>
Cc: linux-ide@vger.kernel.org

Hello,

On 03/09/2010 06:22 PM, Tomasz Palac wrote:
>> Using custom geometry is a good way to trick a partitioner which
>> partitions based on CHS alignment to align to larger units but it
>> isn't meaningful outside of that.  If CHS dosen't follow 255*63, a lot
>> of code (firmware, BIOS, boot loader, OS...) will just assume CHS is
>> incorrect.
> 
> As of firmware, Large Disk Howto states that a lot of SCSI host
> adapters are using 64/32 geometry (at least for disks smaller than 8
> GiB).  If BIOS supports EDD (INT13h Extensions), then disk geometry
> is irrelevant.

Yes, the geometry is basically arbitrary values which can be queried
using a BIOS call and the reason why SCSI hosts can choose them is
they implement BIOS extensions themselves.

> If not, then geometry can be read from partition table.

>From where?

> The only problem with 64/32 geometry is 1 GiB (as opposed to 8 GiB)
> limit for boot partition (without using EDD). The same applies to
> boot loaders. Modern OSes don't use CHS.

For modern OSes, geometry doesn't matter at all.  Older ones are the
ones having problems (I've been corrected: XP seems okay while 2000
depends on CHS).

Thanks.

-- 
tejun
