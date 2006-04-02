From: "Wesley Lim" <wesleylim@gmail.com>
Subject: Re: sata_sil or libata?
Date: Sat, 1 Apr 2006 17:52:26 -0800
Message-ID: <a8b98fc60604011752m67727f9chf2f5e11d6ed2a3eb@mail.gmail.com>
References: <442F0CB5.9020004@dgreaves.com>
	 <Pine.LNX.4.44.0604011902330.7527-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.233]:8054 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932366AbWDBBw2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Apr 2006 20:52:28 -0500
Received: by wproxy.gmail.com with SMTP id i22so1114753wra
        for <linux-ide@vger.kernel.org>; Sat, 01 Apr 2006 17:52:27 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44.0604011902330.7527-100000@coffee.psychology.mcmaster.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: David Greaves <david@dgreaves.com>, linux-ide@vger.kernel.org

On 4/1/06, Mark Hahn <hahn@physics.mcmaster.ca> wrote:
> >     Additional sense: Unrecovered read error - auto reallocate failed
> > end_request: I/O error, dev sdb, sector 393692817
>
> this sort of thing would make me want to sanity-check the drives,
> since it certainly sounds like a media/heat/vibration/power problem.
>
> have you run a SMART selftest on these drives?

I've done badblocks on the drive and it's fine. I haven't tried
smartctl as I read -d ata can cause problems because of some SCSI
queuing thing? Can I safely use smartd yet?
