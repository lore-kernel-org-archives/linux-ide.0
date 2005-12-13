From: Shem Multinymous <multinymous@gmail.com>
Subject: Re: tp_smapi conflict with IDE, hdaps
Date: Tue, 13 Dec 2005 20:41:00 +0200
Message-ID: <41840b750512131041i5ae5f021h29eed3492bad88ca@mail.gmail.com>
References: <41840b750512130635p45591633ya1df731f24a87658@mail.gmail.com>
	 <1134486203.11732.60.camel@localhost.localdomain>
	 <41840b750512130729y49903791xc9ceba4e6a18322e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.195]:36627 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030204AbVLMSli convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Dec 2005 13:41:38 -0500
Received: by zproxy.gmail.com with SMTP id 34so1799105nzf
        for <linux-ide@vger.kernel.org>; Tue, 13 Dec 2005 10:41:37 -0800 (PST)
In-Reply-To: <41840b750512130729y49903791xc9ceba4e6a18322e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Rovert Love <rlove@rlove.org>, Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org

On 12/13/05, Shem Multinymous <multinymous@gmail.com> wrote:
> ThinkPad T43 BIOS 1.24, Hitahi HTS726060M9AT00 firmware MH4OA6GA.

Oops, sorry, that's the hard disk. The drive is a Matshita UJ-822S
firmware 1.61 (branded by IBM as "UltraBay Slim DVD Multi-Burner
Plus").

Meanwhile, I found out that with this drive, "hdparm -E" does affect
CD-R discs, but not DVD-R discs. The SMAPI BIOS command affects both.

  Shem
