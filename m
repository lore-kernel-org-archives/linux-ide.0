From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
Date: Sun, 22 Jan 2006 09:16:38 +0100
Message-ID: <1137917798.3328.2.camel@laptopd505.fenrus.org>
References: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:64911 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932174AbWAVIQl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Jan 2006 03:16:41 -0500
In-Reply-To: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ariel <askernel2615@dsgml.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 2006-01-21 at 21:13 -0500, Ariel wrote:
> I have a memory leak in scsi_cmd_cache.
> 
> Attached is a pretty graph made by munin, and you can see slab_cache 
> growing constantly since last reboot. Also attached is /proc/config.gz
> 
> And here is a copy of /proc/meminfo and /proc/slabinfo
> 
> I'm rebooting now since my system is all but unusable (so the mem stats 
> will reset), but if you need any more info let me know.


does this happen without the binary nvidia driver too? (it appears
you're using that). That's a good datapoint to have if so...

