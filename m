From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] speed up SATA
Date: Mon, 29 Mar 2004 13:36:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040329113641.GE1453@openzaurus.ucw.cz>
References: <4066021A.20308@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4066021A.20308@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

Hi!

> Things seem to be looking pretty good, so it's now time to turn on 
> lba48-sized transfers.  Most SATA disks will be lba48 anyway, even 
> the ones smaller than 137GB, for this and other reasons.
> 
> With this simple patch, the max request size goes from 128K to 
> 32MB... so you can imagine this will definitely help performance.  
> Throughput goes up.  Interrupts go down.  Fun for the whole family.

32MB is one second if everything goes okay... That will be horrible for latency, right?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         
