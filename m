From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: [ltp] ICH6M legacy hotswap?
Date: Tue, 28 Feb 2006 17:31:31 +0200
Message-ID: <41840b750602280731l3f2ee8a2l5b98c5905b3ea7be@mail.gmail.com>
References: <41840b750602280135j511a7584m80b0b1f549780bf@mail.gmail.com>
	 <dead81ad0602280541i38dcdb49n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.193]:32410 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932227AbWB1Pbc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Feb 2006 10:31:32 -0500
Received: by wproxy.gmail.com with SMTP id 36so157015wra
        for <linux-ide@vger.kernel.org>; Tue, 28 Feb 2006 07:31:31 -0800 (PST)
In-Reply-To: <dead81ad0602280541i38dcdb49n@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-thinkpad@linux-thinkpad.org
Cc: linux-ide@vger.kernel.org

On 2/28/06, Jim Duchek <jim.duchek@gmail.com> wrote:
> I think if you can get AHCI working, I can get lt_hotswap working with it.

I tried switching this box from the ata_piix driver to the ahci
driver. The ahci driver recognizes the ICH6M chip (it's on the
whitelist of both drivers), but probing fails with error -12 
(-ENOMEM?! Does this make sense?).

Anyway, the ICH6M is not initialized to AHCI mode by the BIOS (at
least as judged by at ata_piix, since when using ata_piix,
piix_disable_ahci() isn't called).

  Shem
