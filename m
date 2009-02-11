From: Tejun Heo <tj@kernel.org>
Subject: Re: libata timeouts when stressing a Samsung HDD
Date: Wed, 11 Feb 2009 10:30:21 +0900
Message-ID: <49922A2D.508@kernel.org>
References: <20090202164053.4ecca9dd@dhcp-100-2-144.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59209 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753865AbZBKBa0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Feb 2009 20:30:26 -0500
In-Reply-To: <20090202164053.4ecca9dd@dhcp-100-2-144.bos.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: linux-ide@vger.kernel.org

Chuck Ebbert wrote:
> If I use an ext3 filesystem with noatime I never see problems, but if I use XFS
> with barriers and atime enabled, I keep getting this:
> 
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata1.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1: hard resetting link
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.00: configured for UDMA/133
> end_request: I/O error, dev sda, sector 13851948

ext3 doesn't use barrier by default.  Timing out on FLUSH_CACHE is a
pretty good sign that something is wrong with the disk.  Can you
please post the output of "smartctl -a /dev/sda"?

-- 
tejun
