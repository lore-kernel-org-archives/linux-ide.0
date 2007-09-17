From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.22.6 sata_sil device errors & timeouts
Date: Mon, 17 Sep 2007 19:07:21 +0200
Message-ID: <46EEB449.8010305@gmail.com>
References: <76366b180709170135v6c46f3d6qd3586ea79f9abc2@mail.gmail.com>	 <46EE4679.7030600@gmail.com> <76366b180709170904i7b2f5ab0o8605eb899d20f921@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:12752 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbXIQRJX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Sep 2007 13:09:23 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1357602rvb
        for <linux-ide@vger.kernel.org>; Mon, 17 Sep 2007 10:09:23 -0700 (PDT)
In-Reply-To: <76366b180709170904i7b2f5ab0o8605eb899d20f921@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: linux-ide@vger.kernel.org, ballen@gravity.phys.uwm.edu

[cc'ing Bruce Allen]

Andrew Paprocki wrote:
> I didn't mention it before, but I'm also getting these errors every
> time I boot. I'm thinking they're related to the drive not supporting
> cmds that smartd is sending it. If so, is there any way that
> libata/smartd can handle this more gracefully? This stuff spews into
> dmesg and gives a scare that there is a real hardware problem that may
> cause data corruption. I get exactly 6 instances of each of these two
> blocks of output prior to reaching the login prompt:
> 
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> ata1.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 0
>          res 51/04:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x1 (device error)
> ata1.00: configured for UDMA/100
> ata1: EH complete
> 
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> ata2.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 0
>          res 51/04:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x1 (device error)
> ata2.00: configured for UDMA/100
> ata2: EH complete

Upgrading smartd should fix it.  Which version are you using?

-- 
tejun
