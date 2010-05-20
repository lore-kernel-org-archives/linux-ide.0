From: "Buehl, Reiner" <reiner.buehl@hp.com>
Subject: RE: ext3 filesystem corruption on md RAID1 device
Date: Thu, 20 May 2010 11:35:37 +0000
Message-ID: <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B1DDEA@GVW1115EXC.americas.hpqcorp.net>
References: <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B1DCFD@GVW1115EXC.americas.hpqcorp.net>
	<877hmy264p.fsf@openvz.org>
	<BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B1DDA7@GVW1115EXC.americas.hpqcorp.net>
 <871vd624qi.fsf@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:4841 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab0ETLha convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 May 2010 07:37:30 -0400
In-Reply-To: <871vd624qi.fsf@openvz.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>

> Hm.. So may be this is not a barrier related.
> >m two smaller Seagate disks to the currently used 1TB disks. There for
> my first thought was a failed disk or memory but they seem to be ok
> based on the SMART and memtest results.
> >
> You may possibly force this to happen sooner like follows:
> find /your-mnt/ -ls > /dev/null #fore fstat for all inodes

The affected filesystem is unfortunately the root filesystem of this server. I have some backups but still would prefer not to force more such errors unless there is no other option. Can I turn on some debugging output or otherwise ensure that if I enforce this error that we get some data that helps diagnose the problem? 
