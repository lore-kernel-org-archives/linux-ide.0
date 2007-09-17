From: "Andrew Paprocki" <andrew.m.paprocki@gmail.com>
Subject: Re: 2.6.22.6 sata_sil device errors & timeouts
Date: Mon, 17 Sep 2007 17:06:40 -0400
Message-ID: <76366b180709171406g61f09f39la8deeb3201ad0e37@mail.gmail.com>
References: <76366b180709170135v6c46f3d6qd3586ea79f9abc2@mail.gmail.com>
	 <46EE4679.7030600@gmail.com>
	 <76366b180709170904i7b2f5ab0o8605eb899d20f921@mail.gmail.com>
	 <46EEB449.8010305@gmail.com>
	 <76366b180709171205v5783fb9ave52b7e999da96f07@mail.gmail.com>
	 <76366b180709171226j5a299502q1a13f158d9b704aa@mail.gmail.com>
	 <Pine.LNX.4.63.0709171433120.28104@trinity.phys.uwm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.233]:33646 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760188AbXIQVGm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Sep 2007 17:06:42 -0400
Received: by qb-out-0506.google.com with SMTP id e11so1813732qbe
        for <linux-ide@vger.kernel.org>; Mon, 17 Sep 2007 14:06:40 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.63.0709171433120.28104@trinity.phys.uwm.edu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Bruce,

Just built it -- it eliminated the HSM violations, but I still get the
device errors:

smartmontools release 5.38 dated 2006/12/20 at 20:37:59 UTC
(I see the above date, even though I verified it is built from CVS head)

ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 0
         res 51/04:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x1 (device error)
ata2.00: configured for UDMA/100
ata2: EH complete

This is what it is in smartd.conf:
/dev/sda -d ata -a -o on -S on
/dev/sdb -d ata -a -o on -S on
/dev/sdc -d ata -a -o on -S on

Thanks, -Andrew

On 9/17/07, Bruce Allen <ballen@gravity.phys.uwm.edu> wrote:
> Hi Andrew,
>
> Please build the CVS version (unreleased) of smartmontools.  The versions
> below are dated 2006/12/20 and 2006/04/12.  You need to build a code
> version based on the past few weeks of code.
>
> Cheers,
>         Bruce
